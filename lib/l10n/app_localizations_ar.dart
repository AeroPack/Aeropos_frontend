// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'AeroPOS';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get settings => 'الإعدادات';

  @override
  String get checkout => 'الدفع';

  @override
  String get total => 'الإجمالي';

  @override
  String get inventory => 'المخزون';

  @override
  String get languageSelection => 'اللغة';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get totalSales => 'إجمالي المبيعات';

  @override
  String get transactions => 'المعاملات';

  @override
  String get invoiceSettings => 'إعدادات الفاتورة';

  @override
  String get invoiceSettingsSubtitle => 'تكوين التخطيطات وخيارات الطابعة';

  @override
  String get rolePermissions => 'الأدوار والصلاحيات';

  @override
  String get rolePermissionsSubtitle => 'إدارة صلاحيات الأدوار والأمان';
}
