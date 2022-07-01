import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin CalendarMixin {
  DateTime date({required int month, required int year}) {
    return DateTime.utc(year, month, 1);
  }

  int daysInMonth(DateTime date) => DateTimeRange(
        start: DateTime(date.year, date.month, 1),
        end: DateTime(date.year, date.month + 1),
      ).duration.inDays;
  int daysInCurrentMonth() {
    final daysInCurrentMonth = daysInMonth(DateTime.now());
    return daysInCurrentMonth;
  }

  int daysInNextMonth() {
    final daysInNextMonth = daysInMonth(DateTime.now());
    return daysInNextMonth;
  }

  int daysToEndTheMonth() {
    final daysToEndTheMonth = daysInCurrentMonth() - DateTime.now().day;
    return daysToEndTheMonth;
  }

  CleanCalendarController calendarController({
    required dynamic Function(DateTime, DateTime?)? onRangeSelected,
    required dynamic Function(DateTime)? onDayTapped,
    required dynamic Function(DateTime)? onPreviousMinDateTapped,
    required dynamic Function(DateTime)? onAfterMaxDateTapped,
    required bool isSelectable,
    required int month,
    required DateTime minDate,
    DateTime? finalDate,
  }) {
    const daysInFiftyYears = 18250;
    final calendarController = CleanCalendarController(
      minDate: minDate,
      maxDate:DateTime.now().add(const Duration(days: daysInFiftyYears)),
         
      onRangeSelected: onRangeSelected,
      onDayTapped: onDayTapped,
      onPreviousMinDateTapped: onPreviousMinDateTapped,
      onAfterMaxDateTapped: onAfterMaxDateTapped,
      weekdayStart: DateTime.sunday,
      rangeMode: isSelectable,
      endDateSelected: finalDate,
    );
    return calendarController;
  }

  final rowTextStyle = TextStyle(
    color: const Color.fromARGB(255, 22, 114, 189),
    fontSize: 18.sp,
  );
}
