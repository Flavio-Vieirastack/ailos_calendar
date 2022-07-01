import 'package:bloc/bloc.dart';

class YearsCubit extends Cubit<int> {
  YearsCubit() : super(DateTime.now().year);
  dateIncrement() => emit(state + 1);

  dateDecrement() => emit(state - 1);
 
}
