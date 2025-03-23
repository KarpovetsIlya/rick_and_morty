import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty/api/data/character.dart';

class ProviderService with ChangeNotifier {
  List<Character> _favorites = [];

  List<Character> get favorites => _favorites;

  ProviderService() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favorites');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _favorites = jsonList.map((e) => Character.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addFavorite(Character character) async {
    if (!_favorites.contains(character)) {
      _favorites.add(character);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(Character character) async {
    _favorites.remove(character);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_favorites.map((e) => e.toJson()).toList());
    await prefs.setString('favorites', jsonString);
  }

  void sortFavoritesByName(bool ascending) {
    _favorites.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    notifyListeners();
  }
}
