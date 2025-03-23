import 'package:rick_and_morty/api/data/character.dart';

abstract interface class InternetService {
  Future<List<Character>> getCharacters({int page = 1});
  Future<List<Character>> getCachedCharacters(int page);
}
