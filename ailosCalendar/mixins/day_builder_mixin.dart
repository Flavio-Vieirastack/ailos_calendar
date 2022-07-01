import 'package:ailos_app/core/colors/ailos_colors.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/models/day_values_model.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';

mixin DayBuilderMixin {
  Widget dayBuilder(
    BuildContext context,
    DayValues values, {
    required VoidCallback changeContainerVisibilityToTrue,
    required VoidCallback changeContainerVisibilityToFalse,
    required bool containerVisible,
    required DateTime maxDateSelectable,
    required DateTime minDateSelectable,
  }) {
    BorderRadiusGeometry? _borderRadius;
    BorderRadiusGeometry? _firstContainerLigatureRadius;
    BorderRadiusGeometry? _secondContainerLigatureRadius;
    BoxBorder? _currentDayBorder;
    EdgeInsetsGeometry? _currentDayMargin;
    Color _bgColor = Colors.transparent;
    Color _firstContainerLigatureBackgroundColor = Colors.transparent;
    Color _secondContainerLigatureBackgroundColor = Colors.transparent;
    TextStyle txtStyle = const TextStyle(color: Colors.black, fontSize: 14);
    const Color _rangeColor = AilosColors.blue60;
    const double _containerHeight = 40;
    double _containerWidth = 40;
    double _firstcontainerLigatureWidth = 40;
    bool ignorePointerValue = false;
    if (values.isSelected) {
      if ((values.selectedMinDate != null &&
              values.day.isSameDay(values.selectedMinDate!)) ||
          (values.selectedMaxDate != null &&
              values.day.isSameDay(values.selectedMaxDate!))) {
        _bgColor = AilosColors.blue100;
        txtStyle =
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
        if (values.selectedMinDate == values.selectedMaxDate) {
          txtStyle = const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          );
          _borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          );
        } else if (values.selectedMinDate != null &&
            values.day.isSameDay(values.selectedMinDate!)) {
          //!Controla o radius da primeira seleção do range
          _borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          );
          _firstContainerLigatureRadius = const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          );
          _secondContainerLigatureRadius = const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          );
          _secondContainerLigatureBackgroundColor = _rangeColor;
          changeContainerVisibilityToTrue.call();
          _firstcontainerLigatureWidth = double.infinity;
          txtStyle = const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
        } else if (values.selectedMaxDate != null &&
            values.day.isSameDay(values.selectedMaxDate!)) {
          //!Controla o radius da segunda seleção do range
          _borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          );
          changeContainerVisibilityToFalse.call();

          _firstContainerLigatureRadius = const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          );
          _firstContainerLigatureBackgroundColor = _rangeColor;
          txtStyle = const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          );
        }
      } else {
        _bgColor = _rangeColor; //!Controla a cor do range
        _currentDayBorder = Border.all(color: _rangeColor, width: 0);
        txtStyle = const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
        _containerWidth = double.infinity;
      }
    } else if (values.day.isSameDay(DateTime.now())) {
      //!controla a cor da borda da data atual
      _borderRadius = const BorderRadius.all(Radius.circular(32));
      _currentDayBorder = Border.all(color: AilosColors.blueDark);
      _currentDayMargin = const EdgeInsets.all(2);
    } else if (values.day.isBefore(minDateSelectable) ||
        values.day.isAfter(maxDateSelectable)) {
      ignorePointerValue = true;
      txtStyle = const TextStyle(color: AilosColors.grey40);
    }

    return IgnorePointer(
      ignoring: ignorePointerValue,
      child: Stack(
        children: [
          Visibility(
            visible: containerVisible,
            child: Container(
              height: _containerHeight,
              width: _firstcontainerLigatureWidth,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: _secondContainerLigatureBackgroundColor,
                borderRadius: _secondContainerLigatureRadius,
              ),
            ),
          ),
          Container(
            height: _containerHeight,
            width: _containerWidth,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: _firstContainerLigatureBackgroundColor,
              borderRadius: _firstContainerLigatureRadius,
            ),
            child: Container(
              height: _containerHeight,
              width: _containerWidth,
              margin: _currentDayMargin,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: _currentDayBorder,
                color: _bgColor,
                borderRadius: _borderRadius,
              ),
              child: Text(
                values.text,
                textAlign: TextAlign.center,
                style: txtStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
