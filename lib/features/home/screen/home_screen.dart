import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/character_bloc.dart';
import 'package:rick_and_morty/bloc/theme_cubit.dart';
import 'package:rick_and_morty/features/home/widgets/card_character.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(GetCharacters());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<CharacterBloc>().add(LoadMoreCharacters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        leading: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                final newBrightness = state.brightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark;
                context.read<ThemeCubit>().setThemeBrightness(newBrightness);
              },
            );
          },
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: BlocConsumer<CharacterBloc, CharacterState>(
        listener: (context, state) {
          if (state is CharacterLoaded && state.hasReachedMax) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Достигнут конец списка')),
            );
          } else if (state is CharacterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CharacterLoading && state.character.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterError) {
            return Center(child: Text(state.message));
          } else if (state is CharacterLoaded) {
            if (state.character.isEmpty) {
              return const Center(child: Text('Нет данных'));
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    _scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                  context.read<CharacterBloc>().add(LoadMoreCharacters());
                }
                return true;
              },
              child: Scrollbar(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.character.length
                      : state.character.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.character.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final character = state.character[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CardCharacter(
                        character: character,
                        isFavoriteScreen: false,
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
