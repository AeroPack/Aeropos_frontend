import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../core/di/service_locator.dart';

final salesListStreamProvider = StreamProvider<List<TypedResult>>((ref) {
  final database = ServiceLocator.instance.database;
  return database.watchInvoicesWithCustomer();
});
