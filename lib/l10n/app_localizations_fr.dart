// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get settings => 'Paramètres';

  @override
  String get checkout => 'Paiement';

  @override
  String get total => 'Total';

  @override
  String get inventory => 'Inventaire';

  @override
  String get languageSelection => 'Langue';

  @override
  String get overview => 'Vue d\'ensemble';

  @override
  String get totalSales => 'Ventes totales';

  @override
  String get transactions => 'Transactions';

  @override
  String get invoiceSettings => 'Paramètres de facturation';

  @override
  String get invoiceSettingsSubtitle =>
      'Configurer les mises en page et les options d\'impression';

  @override
  String get rolePermissions => 'Rôles & Autorisations';

  @override
  String get rolePermissionsSubtitle =>
      'Gérer l\'accès aux rôles et la sécurité';
}
