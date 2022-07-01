part of './mainCalendar/ailos_calendar.dart';

class _CalendarButtons extends StatelessWidget {
  final VoidCallback arrowBackCallback;
  final VoidCallback arrowFrowardCallback;
  final bool arrowBackVisible;
  final bool arrowFrowardVisible;
  const _CalendarButtons({
    Key? key,
    required this.arrowBackCallback,
    required this.arrowFrowardCallback,
    required this.arrowBackVisible,
    required this.arrowFrowardVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: arrowBackVisible,
          child: IconButton(
            onPressed: arrowBackCallback,
            icon: const Icon(Icons.arrow_back_ios),
            color: AilosColors.blueDark
          ),
        ),
        Visibility(
          visible: arrowFrowardVisible,
          child: IconButton(
            onPressed: arrowFrowardCallback,
            icon: const Icon(Icons.arrow_forward_ios),
            color: AilosColors.blueDark
          ),
        ),
      ],
    );
  }
}
