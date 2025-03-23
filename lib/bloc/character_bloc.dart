import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/api/data/character.dart';
import 'package:rick_and_morty/api/service/rick_and_morty_api_intarface.dart';

part 'character_event.dart';
part 'character_state.dart';

enum SortType { name, status }

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final InternetService internetService;
  List<Character> _characters = [];
  int _currentPage = 1;
  bool _hasReachedMax = false;

  CharacterBloc(this.internetService) : super(CharacterInitial()) {
    on<GetCharacters>(_onGetCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
    on<SortCharacters>(_onSortCharacters);
  }

  Future<void> _onGetCharacters(
      GetCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading(character: _characters));
    _currentPage = 1;
    _hasReachedMax = false;

    try {
      final characters =
          await internetService.getCharacters(page: _currentPage);
      _characters = characters;
      emit(CharacterLoaded(characters, hasReachedMax: _hasReachedMax));
    } catch (e) {
      final cachedCharacters =
          await internetService.getCachedCharacters(_currentPage);
      if (cachedCharacters.isNotEmpty) {
        _characters = cachedCharacters;
        emit(CharacterLoaded(cachedCharacters, hasReachedMax: true));
      } else {
        emit(CharacterError('Ошибка сети: $e'));
      }
    }
  }

  Future<void> _onLoadMoreCharacters(
      LoadMoreCharacters event, Emitter<CharacterState> emit) async {
    if (_hasReachedMax) return;

    try {
      final nextPage = _currentPage + 1;
      final newCharacters = await internetService.getCharacters(page: nextPage);

      if (newCharacters.isEmpty) {
        _hasReachedMax = true;
      } else {
        _characters.addAll(newCharacters);
        _currentPage = nextPage;
      }

      emit(
          CharacterLoaded(List.of(_characters), hasReachedMax: _hasReachedMax));
    } catch (e) {
      final cachedCharacters =
          await internetService.getCachedCharacters(_currentPage + 1);
      if (cachedCharacters.isNotEmpty) {
        _characters.addAll(cachedCharacters);
        _currentPage += 1;
        emit(CharacterLoaded(List.of(_characters), hasReachedMax: false));
      } else {
        emit(CharacterError('Ошибка при загрузке новых персонажей: $e'));
      }
    }
  }

  void _onSortCharacters(SortCharacters event, Emitter<CharacterState> emit) {
    if (_characters.isEmpty) return;

    List<Character> sortedList = List.from(_characters);

    switch (event.sortType) {
      case SortType.name:
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.status:
        sortedList.sort((a, b) => a.status.compareTo(b.status));
        break;
    }

    emit(CharacterLoaded(sortedList, hasReachedMax: _hasReachedMax));
  }
}
