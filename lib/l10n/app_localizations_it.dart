// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Cruscotto';

  @override
  String get settings => 'Impostazioni';

  @override
  String get checkout => 'Cassa';

  @override
  String get total => 'Totale';

  @override
  String get inventory => 'Inventario';

  @override
  String get languageSelection => 'Lingua';

  @override
  String get overview => 'Panoramica';

  @override
  String get totalSales => 'Vendite totali';

  @override
  String get transactions => 'Transazioni';

  @override
  String get invoiceSettings => 'Impostazioni fattura';

  @override
  String get invoiceSettingsSubtitle => 'Configura layout e opzioni stampante';

  @override
  String get rolePermissions => 'Ruoli e permessi';

  @override
  String get rolePermissionsSubtitle =>
      'Gestisci l\'accesso ai ruoli e la sicurezza';
}
