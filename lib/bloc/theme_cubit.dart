import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(Brightness.light));

  void setThemeBrightness(Brightness brightness) {
    emit(ThemeState(brightness));
  }
}
