import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty/api/data/character.dart';
import 'package:rick_and_morty/api/service/rick_and_morty_api_intarface.dart';

class InternetServiceDio implements InternetService {
  final Dio _client;

  InternetServiceDio(this._client);

  @override
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _client.get(
        'https://rickandmortyapi.com/api/character',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        List<Character> characters =
            results.map((e) => Character.fromJson(e)).toList();

        await _cacheCharacters(characters, page);
        return characters;
      } else {
        throw Exception('Не удалось получить данные: ${response.statusCode}');
      }
    } catch (e) {
      print(
          "Ошибка сети, загружаем кэшированные данные для страницы $page: $e");
      return await getCachedCharacters(page);
    }
  }

  Future<void> _cacheCharacters(List<Character> characters, int page) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(characters.map((character) => character.toJson()).toList());
    await prefs.setString('cached_characters_page_$page', jsonString);
  }

  @override
  Future<List<Character>> getCachedCharacters(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cached_characters_page_$page');

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => Character.fromJson(e)).toList();
    }

    return [];
  }
}
