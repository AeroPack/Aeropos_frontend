import 'package:drift/drift.dart';

export 'native.dart' if (dart.library.html) 'web.dart';
