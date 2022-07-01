import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class ArrowFrowardVisibleCubit extends Cubit<bool> {
  ArrowFrowardVisibleCubit() : super(true);
  hideFrowardArrow({required int currentMonth}) {
    log(currentMonth.toString());
    if (currentMonth >= DateTime.december - 1) {
      emit(!state);
    }
  }

  showFrowardArrow({required bool backArrowState}) {
    if (backArrowState == false) {
      emit(!state);
    }
  }
}
