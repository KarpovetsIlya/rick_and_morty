import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/routes/routes.dart';

class AppNavigationShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavigationShell({super.key, required this.navigationShell});

  @override
  State<AppNavigationShell> createState() => _AppNavigationShellState();
}

class _AppNavigationShellState extends State<AppNavigationShell> {
  int selectedIndex = 0;

  void setActiveIndex(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go(Routes.homeScreen.toPath);
        break;
      case 1:
        context.go(Routes.favoritesScreen.toPath);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: setActiveIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
