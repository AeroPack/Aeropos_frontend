import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the current [Locale] for the whole app.
///
/// Default is English. To switch language at runtime, do:
/// ```dart
/// ref.read(localeProvider.notifier).state = const Locale('ar');
/// ```
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));
