part of 'character_bloc.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<Character> character;

  CharacterLoading({this.character = const []});
}

class CharacterLoaded extends CharacterState {
  final List<Character> character;
  final bool hasReachedMax;
  CharacterLoaded(this.character, {this.hasReachedMax = false});
}

class CharacterError extends CharacterState {
  final String message;
  CharacterError(this.message);
}
