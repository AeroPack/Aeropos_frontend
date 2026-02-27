// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'Gösterge Paneli';

  @override
  String get settings => 'Ayarlar';

  @override
  String get checkout => 'Ödeme';

  @override
  String get total => 'Toplam';

  @override
  String get inventory => 'Envanter';

  @override
  String get languageSelection => 'Dil';

  @override
  String get overview => 'Genel Bakış';

  @override
  String get totalSales => 'Toplam Satışlar';

  @override
  String get transactions => 'İşlemler';

  @override
  String get invoiceSettings => 'Fatura Ayarları';

  @override
  String get invoiceSettingsSubtitle =>
      'Düzenleri ve yazıcı seçeneklerini yapılandırın';

  @override
  String get rolePermissions => 'Rol ve İzinler';

  @override
  String get rolePermissionsSubtitle => 'Rol erişimini ve güvenliği yönetin';
}
