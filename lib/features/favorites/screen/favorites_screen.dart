import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/api/service/provider_service.dart';
import 'package:rick_and_morty/features/home/widgets/card_character.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isSortedAscending = true;

  void _sortFavorites(ProviderService provider) {
    setState(() {
      _isSortedAscending = !_isSortedAscending;
      provider.sortFavoritesByName(_isSortedAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<ProviderService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Избранное',
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSortedAscending ? Icons.sort_by_alpha : Icons.sort,
            ),
            onPressed: () => _sortFavorites(favoritesProvider),
          ),
        ],
      ),
      body: favoritesProvider.favorites.isEmpty
          ? const Center(
              child: Text(
                'Нет избранных персонажей',
              ),
            )
          : ListView.builder(
              itemCount: favoritesProvider.favorites.length,
              itemBuilder: (context, index) {
                final character = favoritesProvider.favorites[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CardCharacter(
                      character: character, isFavoriteScreen: true),
                );
              },
            ),
    );
  }
}
