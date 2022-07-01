import 'dart:developer';

import 'package:bloc/bloc.dart';

class ArrowBackVisibleCubit extends Cubit<bool> {
  ArrowBackVisibleCubit() : super(true);
  hideBackArrow({required int currentMonth}) {
    if (currentMonth == DateTime.january + 1) {
      log(currentMonth.toString());
      log(state.toString());
      emit(!state);
    }
  }

  showBackArrow({required bool backArrowState}) {
    if (backArrowState == false) {
      emit(!state);
    }
  }
}
