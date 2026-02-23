import 'package:drift/drift.dart';

@DataClassName('InvoiceSettingEntity')
class InvoiceSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get layout => text().withLength(min: 1, max: 50)();
  TextColumn get footerMessage => text().withLength(min: 1, max: 1000)();

  // Customization Options
  TextColumn get accentColor => text()
      .withLength(min: 1, max: 10)
      .withDefault(const Constant('#2A2D64'))();
  TextColumn get fontFamily => text()
      .withLength(min: 1, max: 50)
      .withDefault(const Constant('Roboto'))();
  RealColumn get fontSizeMultiplier =>
      real().withDefault(const Constant(1.0))();

  // Section Toggles
  BoolColumn get showAddress => boolean().withDefault(const Constant(true))();
  BoolColumn get showCustomerDetails =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get showFooter => boolean().withDefault(const Constant(true))();

  // Custom Template Configuration (JSON)
  TextColumn get customConfig => text().nullable()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
