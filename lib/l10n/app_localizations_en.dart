// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Settings';

  @override
  String get checkout => 'Checkout';

  @override
  String get total => 'Total';

  @override
  String get inventory => 'Inventory';

  @override
  String get languageSelection => 'Language';

  @override
  String get overview => 'Overview';

  @override
  String get totalSales => 'Total Sales';

  @override
  String get transactions => 'Transactions';

  @override
  String get invoiceSettings => 'Invoice Settings';

  @override
  String get invoiceSettingsSubtitle => 'Configure layouts and printer options';

  @override
  String get rolePermissions => 'Role & Permissions';

  @override
  String get rolePermissionsSubtitle => 'Manage role access and security';
}
