import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/favorites/screen/favorites_screen.dart';
import 'package:rick_and_morty/features/home/screen/home_screen.dart';
import 'package:rick_and_morty/routes/routes.dart';
import 'package:rick_and_morty/routes/view/app_navigation_shell.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.homeScreen.toPath,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppNavigationShell(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.homeScreen.toPath,
                name: Routes.homeScreen.toName,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.favoritesScreen.toPath,
                name: Routes.favoritesScreen.toName,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
