import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/api/service/provider_service.dart';
import 'package:rick_and_morty/api/service/rick_and_morty_api_intarface.dart';
import 'package:rick_and_morty/bloc/character_bloc.dart';
import 'package:rick_and_morty/bloc/theme_cubit.dart';
import 'package:rick_and_morty/injection_container.dart';
import 'package:rick_and_morty/routes/app_router.dart';
import 'package:rick_and_morty/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInjectionContainer();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) => CharacterBloc(getIt<InternetService>()),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        ChangeNotifierProvider(create: (_) => ProviderService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
