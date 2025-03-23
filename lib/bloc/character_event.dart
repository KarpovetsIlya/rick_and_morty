part of 'character_bloc.dart';

abstract class CharacterEvent {}

class GetCharacters extends CharacterEvent {}

class LoadMoreCharacters extends CharacterEvent {}

class SortCharacters extends CharacterEvent {
  final SortType sortType;

  SortCharacters(this.sortType);
}
