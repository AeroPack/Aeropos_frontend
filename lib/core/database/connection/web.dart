import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor connect() {
  return WebDatabase('ezo_pos_product_master');
}
