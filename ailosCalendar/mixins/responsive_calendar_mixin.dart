import 'package:flutter/material.dart';

class AppSizesContants {
  AppSizesContants._();
  static const kTabletBreakpoint = 768.0;
  static const kDesktopBreakpoint = 1440.0;
  static const kDesktopSmallBreakpoint = 1200.0;
  static const kMobileBreakpoint = 600.0;
  static const kMobileSmallBreakpoint = 375.0;
}

mixin ResponsiveCalendarMixin {
  num responsiveHeight({
    required BoxConstraints constraints,
    required num defaulMobiletHight,
    required num tabletheight,
  }) {
    if (constraints.maxWidth <= AppSizesContants.kMobileBreakpoint) {
      return defaulMobiletHight;
    } else if (constraints.maxWidth >= AppSizesContants.kTabletBreakpoint &&
        constraints.maxWidth < AppSizesContants.kDesktopBreakpoint) {
      return tabletheight;
    } else if (constraints.maxWidth >= AppSizesContants.kMobileBreakpoint &&
        constraints.maxWidth <= AppSizesContants.kTabletBreakpoint) {
      return tabletheight;
    } else {
      return tabletheight;
    }
  }

  num responsiveWidth({
    required BoxConstraints constraints,
    required num defaulMobiletWidth,
    required num tabletWidth,
  }) {
    if (constraints.maxWidth <= AppSizesContants.kMobileBreakpoint) {
      return defaulMobiletWidth;
    } else if (constraints.maxWidth >= AppSizesContants.kTabletBreakpoint &&
        constraints.maxWidth < AppSizesContants.kDesktopBreakpoint) {
      return tabletWidth;
    } else if (constraints.maxWidth >= AppSizesContants.kMobileBreakpoint &&
        constraints.maxWidth <= AppSizesContants.kTabletBreakpoint) {
      return tabletWidth;
    } else {
      return tabletWidth;
    }
  }

  double responsiveCalenderHeight({
    required double calendarMobileHeight,
    required double calenderTabletHeight,
    required BuildContext context,
  }) {
    if (MediaQuery.of(context).size.width <=
        AppSizesContants.kMobileBreakpoint) {
      return calendarMobileHeight;
    } else if (MediaQuery.of(context).size.width >=
            AppSizesContants.kTabletBreakpoint &&
        MediaQuery.of(context).size.width <
            AppSizesContants.kDesktopBreakpoint) {
      return calenderTabletHeight;
    } else if (MediaQuery.of(context).size.width >=
            AppSizesContants.kMobileBreakpoint &&
        MediaQuery.of(context).size.width <=
            AppSizesContants.kTabletBreakpoint) {
      return calenderTabletHeight;
    } else {
      return calenderTabletHeight;
    }
  }
}
