// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Einstellungen';

  @override
  String get checkout => 'Kasse';

  @override
  String get total => 'Gesamt';

  @override
  String get inventory => 'Inventar';

  @override
  String get languageSelection => 'Sprache';

  @override
  String get overview => 'Übersicht';

  @override
  String get totalSales => 'Gesamtumsatz';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get invoiceSettings => 'Rechnungseinstellungen';

  @override
  String get invoiceSettingsSubtitle =>
      'Layouts und Druckeroptionen konfigurieren';

  @override
  String get rolePermissions => 'Rollen & Berechtigungen';

  @override
  String get rolePermissionsSubtitle =>
      'Rollenzugriff und Sicherheit verwalten';
}
