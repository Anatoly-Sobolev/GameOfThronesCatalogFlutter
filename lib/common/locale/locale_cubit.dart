import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(super.initialState);

  void toggle() {
    emit(Locale(state.languageCode == 'ru' ? 'en' : 'ru'));
  }
}
