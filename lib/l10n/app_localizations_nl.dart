// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Instellingen';

  @override
  String get checkout => 'Afrekenen';

  @override
  String get total => 'Totaal';

  @override
  String get inventory => 'Inventaris';

  @override
  String get languageSelection => 'Taal';

  @override
  String get overview => 'Overzicht';

  @override
  String get totalSales => 'Totale verkopen';

  @override
  String get transactions => 'Transacties';

  @override
  String get invoiceSettings => 'Factuurinstellingen';

  @override
  String get invoiceSettingsSubtitle =>
      'Indelingen en printeropties configureren';

  @override
  String get rolePermissions => 'Rollen & Machtigingen';

  @override
  String get rolePermissionsSubtitle => 'Roltoegang en beveiliging beheren';
}
