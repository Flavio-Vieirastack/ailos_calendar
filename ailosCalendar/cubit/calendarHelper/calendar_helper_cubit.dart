
import 'package:bloc/bloc.dart';

import '../../mixins/calendar_mixin.dart';

class CalendarHelperCubit extends Cubit<int> with CalendarMixin {
  CalendarHelperCubit() : super(DateTime.now().month);

  dateIncrement() {
    if (state <= DateTime.december - 1) {
      emit(state + 1);
    }
  }

  dateDecrement() {
    if (state >= DateTime.january + 1) {
      emit(state - 1);
    }
  }
}
