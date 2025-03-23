enum Routes { homeScreen, favoritesScreen }

extension RoutesExtension on Routes {
  String get toPath {
    switch (this) {
      case Routes.homeScreen:
        return '/home_screen';
      case Routes.favoritesScreen:
        return '/favorites_screen';
    }
  }

  String get toName {
    switch (this) {
      case Routes.homeScreen:
        return 'HOME_SCREEN';
      case Routes.favoritesScreen:
        return 'FAVORITES_SCREEN';
    }
  }
}
