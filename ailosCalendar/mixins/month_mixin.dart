mixin MonthMixin {
  DateTime getMonths({
    required DateTime minDate,
    required DateTime maxDate,
  }) {
    List<DateTime> months = [];
    DateTime currentDate = DateTime(minDate.year, minDate.month);
    months.add(currentDate);

    while (!(currentDate.year == maxDate.year &&
        currentDate.month == maxDate.month)) {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
      months.add(currentDate);
    }
    return months[0];
  }
}
