import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/api/data/character.dart';
import 'package:rick_and_morty/api/service/provider_service.dart';

class CardCharacter extends StatefulWidget {
  final Character character;
  final bool isFavoriteScreen;

  const CardCharacter({
    required this.character,
    this.isFavoriteScreen = false,
    super.key,
  });

  @override
  State<CardCharacter> createState() => _CardCharacterState();
}

class _CardCharacterState extends State<CardCharacter> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<ProviderService>(context);
    final isFavorite = favoritesProvider.favorites.contains(widget.character);

    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.character.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.character.image,
                        width: 380,
                        height: 300,
                        fit: BoxFit.cover,
                        color: Colors.black26,
                        colorBlendMode: BlendMode.darken,
                      )
                    : Image.asset(
                        'assets/images/no_image.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.character.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!widget.isFavoriteScreen)
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoritesProvider.removeFavorite(widget.character);
                      } else {
                        favoritesProvider.addFavorite(widget.character);
                      }
                    },
                  ),
                ),
              ),
            if (widget.isFavoriteScreen)
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      favoritesProvider.removeFavorite(widget.character);
                    },
                  ),
                ),
              ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.character.species,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.character.gender,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.character.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
