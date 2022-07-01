import 'dart:developer';

import 'package:ailos_app/core/colors/ailos_colors.dart';
import 'package:ailos_app/core/widgets/ailosCalendar/cubit/arrowVisible/arrow_froward_visible_cubit.dart';
import 'package:ailos_app/core/widgets/ailosCalendar/cubit/years_cubit/years_cubit.dart';
import 'package:ailos_app/core/widgets/ailosCalendar/mixins/month_mixin.dart';
import 'package:ailos_app/core/widgets/ailosCalendar/widgets/month_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../../cubit/arrowVisible/arrow_back_visible_cubit.dart';
import '../../cubit/calendarHelper/calendar_helper_cubit.dart';
import '../../mixins/calendar_mixin.dart';
import '../../mixins/day_builder_mixin.dart';
import '../../mixins/responsive_calendar_mixin.dart';
part '../calendar_buttons.dart';
part '../calendar_header.dart';

class AilosCalendar extends StatelessWidget
    with CalendarMixin, DayBuilderMixin, ResponsiveCalendarMixin, MonthMixin {
  /// [onRangeSelected] Is the callback to execute when the user selects a range of dates. It receives the first and last date of the range and store in a vaviable.
  final dynamic Function(DateTime firstDate, DateTime? lastDate)?
      onRangeSelected;

  /// [onPreviousMinDateTapped] Is the callback to execute when the user taps on the previous minimum date
  final dynamic Function(DateTime date)? onPreviousMinDateTapped;

  /// [onDayTapped] Is the callback to execute when the user taps on a day
  final dynamic Function(DateTime date)? onDayTapped;

  /// [onAfterMaxDateTapped] Is the callback to execute when the user taps on the last date of the selection
  final dynamic Function(DateTime)? onAfterMaxDateTapped;

  /// [cancellCallback] Is the callback to hide the calendar
  final VoidCallback cancellCallback;

  ///[isSelectable] Make the calendar selectable
  final bool isSelectable;

  /// [isRangeSelected] is the initial state of a range selection.
  final bool isRangeSelected;

  /// [onChangeIsRangeSelected] is the callback that is called when the range selection is changed.
  final Function(bool)? onChangeIsRangeSelected;

  /// [minDateSelectable] controls the minimum date the user can select a date ex: DateTime.utc(2022, 6, 5)
  final DateTime? minDateSelectable;

  /// [maxDateSelectable] controls the maximum selection date from the current date example: DateTime.now().add(const Duration(days: 10),),
  final DateTime? maxDateSelectable;

  AilosCalendar({
    Key? key,
    required this.onRangeSelected,
    required this.cancellCallback,
    this.onPreviousMinDateTapped,
    this.onDayTapped,
    this.onAfterMaxDateTapped,
    this.isRangeSelected = false,
    this.onChangeIsRangeSelected,
    this.isSelectable = true,
    this.minDateSelectable,
    this.maxDateSelectable,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO ver problema da seleção entre meses
    bool containerVisible = false;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArrowBackVisibleCubit(),
        ),
        BlocProvider(
          create: (context) => ArrowFrowardVisibleCubit(),
        ),
        BlocProvider(
          create: (context) => CalendarHelperCubit(),
        ),
        BlocProvider(
          create: (context) => YearsCubit(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final yearsCubit = context.read<YearsCubit>();
          final calendarHelperCubit = context.read<CalendarHelperCubit>();
          final arrowBackVisibleCubit = context.read<ArrowBackVisibleCubit>();
          final arrowFrowardVisibleCubit =
              context.read<ArrowFrowardVisibleCubit>();

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CalendarHelperCubit, int>(
                    builder: (context, state) {
                      return BlocBuilder<YearsCubit, int>(
                        builder: (context, state) {
                          return Stack(
                            children: [
                              _CalendarButtons(
                                arrowBackVisible: true,
                                arrowFrowardVisible: true,
                                arrowBackCallback: () =>
                                    yearsCubit.dateDecrement(),
                                arrowFrowardCallback: () =>
                                    yearsCubit.dateIncrement(),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    state.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Stack(
                    children: [
                      BlocBuilder<ArrowFrowardVisibleCubit, bool>(
                        builder: (context, arrowFrowardVisible) {
                          return BlocBuilder<ArrowBackVisibleCubit, bool>(
                            builder: (context, arrowBackVisible) {
                              return BlocBuilder<YearsCubit, int>(
                                builder: (context, state) {
                                  return BlocBuilder<CalendarHelperCubit, int>(
                                    builder: (context, state) {
                                      return _CalendarButtons(
                                        arrowBackVisible: arrowBackVisible,
                                        arrowFrowardVisible:
                                            arrowFrowardVisible,
                                        arrowBackCallback: () {
                                          calendarHelperCubit.dateDecrement();
                                          arrowBackVisibleCubit.hideBackArrow(
                                            currentMonth: state,
                                          );
                                          arrowFrowardVisibleCubit
                                              .showFrowardArrow(
                                            backArrowState: arrowFrowardVisible,
                                          );
                                        },
                                        arrowFrowardCallback: () {
                                          calendarHelperCubit.dateIncrement();
                                          arrowFrowardVisibleCubit
                                              .hideFrowardArrow(
                                            currentMonth: state,
                                          );
                                          arrowBackVisibleCubit.showBackArrow(
                                            backArrowState: arrowBackVisible,
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: BlocBuilder<CalendarHelperCubit, int>(
                            builder: (context, state) {
                              return MonthWidget(
                                month: getMonths(
                                  minDate: date(
                                    month: state,
                                    year: yearsCubit.state,
                                  ),
                                  maxDate: DateTime.utc(2100, 12, 31),
                                ),
                                locale: 'pt',
                                layout: Layout.BEAUTY,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      BlocBuilder<YearsCubit, int>(
                        builder: (context, state) {
                          return BlocBuilder<CalendarHelperCubit, int>(
                            builder: (arrowContext, state) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AilosColors.grey),
                                ),
                                child: ScrollableCleanCalendar(
                                  weekdayTextStyle: const TextStyle(
                                    fontSize: 15,
                                    color: AilosColors.grey,
                                  ),
                                  monthTextStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  spaceBetweenMonthAndCalendar: 0,
                                  calendarController: calendarController(
                                    minDate: date(
                                      month: calendarHelperCubit.state,
                                      year: yearsCubit.state,
                                    ),
                                    month: calendarHelperCubit.state,
                                    isSelectable: isSelectable,
                                    onRangeSelected: onRangeSelected,
                                    onDayTapped: onDayTapped,
                                    onPreviousMinDateTapped:
                                        onPreviousMinDateTapped,
                                    onAfterMaxDateTapped: onAfterMaxDateTapped,
                                  ),
                                  spaceBetweenCalendars: 150,
                                  layout: Layout.BEAUTY,
                                  locale: 'pt_BR',
                                  calendarCrossAxisSpacing: 0,
                                  calendarMainAxisSpacing: 2,
                                  monthBuilder: (context, text) {
                                    return const SizedBox.shrink();
                                  },
                                  dayBuilder: (context, values) {
                                    log(values.minDate.toString());
                                    return dayBuilder(
                                      minDateSelectable: minDateSelectable ??
                                          DateTime.utc(2022, 1, 5),
                                      maxDateSelectable: maxDateSelectable ??
                                          DateTime.now().add(
                                            const Duration(days: 30),
                                          ),
                                      changeContainerVisibilityToTrue: () {
                                        containerVisible = true;
                                      },
                                      changeContainerVisibilityToFalse: () {
                                        containerVisible = false;
                                      },
                                      containerVisible: containerVisible,
                                      context,
                                      values,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
