// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Panel de control';

  @override
  String get settings => 'Configuración';

  @override
  String get checkout => 'Pago';

  @override
  String get total => 'Total';

  @override
  String get inventory => 'Inventario';

  @override
  String get languageSelection => 'Idioma';

  @override
  String get overview => 'Resumen';

  @override
  String get totalSales => 'Ventas totales';

  @override
  String get transactions => 'Transacciones';

  @override
  String get invoiceSettings => 'Ajustes de factura';

  @override
  String get invoiceSettingsSubtitle =>
      'Configurar diseños y opciones de impresora';

  @override
  String get rolePermissions => 'Roles y permisos';

  @override
  String get rolePermissionsSubtitle =>
      'Administrar el acceso a roles y la seguridad';
}
