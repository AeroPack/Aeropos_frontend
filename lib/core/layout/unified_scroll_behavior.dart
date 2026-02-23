import 'dart:ui';
import 'package:flutter/material.dart';

class UnifiedScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse, // Allows mouse drag scrolling on both platforms
  };

  // Force the scrollbar to be visible and styled consistently
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return Scrollbar(
      controller: details.controller,
      thumbVisibility: true, 
      thickness: 8.0,
      radius: const Radius.circular(4),
      child: child,
    );
  }
}