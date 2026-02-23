import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../di/service_locator.dart';

enum InvoiceLayout {
  thermal,
  modern,
  classic,
  luxury,
  stylish,
  advanced_gst,
  simple,
  dreams,
  custom,
}

class InvoiceTemplate {
  final InvoiceLayout layout;
  final String footerMessage;

  // Customization
  final String accentColor;
  final String fontFamily;
  final double fontSizeMultiplier;

  // Toggles
  final bool showAddress;
  final bool showCustomerDetails;
  final bool showFooter;

  // Custom Template Configuration
  final String? customConfig;

  InvoiceTemplate({
    this.layout = InvoiceLayout.thermal,
    this.footerMessage = "Thank you for shopping with Ezo POS!",
    this.accentColor = '#2A2D64',
    this.fontFamily = 'Roboto',
    this.fontSizeMultiplier = 1.0,
    this.showAddress = true,
    this.showCustomerDetails = true,
    this.showFooter = true,
    this.customConfig,
  });

  factory InvoiceTemplate.defaults() {
    return InvoiceTemplate();
  }

  factory InvoiceTemplate.fromEntity(InvoiceSettingEntity entity) {
    return InvoiceTemplate(
      layout: InvoiceLayout.values.firstWhere(
        (e) => e.name == entity.layout,
        orElse: () => InvoiceLayout.thermal,
      ),
      footerMessage: entity.footerMessage,
      accentColor: entity.accentColor,
      fontFamily: entity.fontFamily,
      fontSizeMultiplier: entity.fontSizeMultiplier,
      showAddress: entity.showAddress,
      showCustomerDetails: entity.showCustomerDetails,
      showFooter: entity.showFooter,
      customConfig: entity.customConfig,
    );
  }
}

class InvoiceTemplateNotifier extends Notifier<InvoiceTemplate> {
  late final AppDatabase _db;

  @override
  InvoiceTemplate build() {
    _db = ServiceLocator.instance.database;
    _loadFromDb();
    return InvoiceTemplate.defaults();
  }

  Future<void> _loadFromDb() async {
    final entity = await _db.getInvoiceSettings();
    if (entity != null) {
      state = InvoiceTemplate.fromEntity(entity);
    }
  }

  Future<void> updateTemplate({
    InvoiceLayout? layout,
    String? footerMessage,
    String? accentColor,
    String? fontFamily,
    double? fontSizeMultiplier,
    bool? showAddress,
    bool? showCustomerDetails,
    bool? showFooter,
    String? customConfig,
  }) async {
    final newState = InvoiceTemplate(
      layout: layout ?? state.layout,
      footerMessage: footerMessage ?? state.footerMessage,
      accentColor: accentColor ?? state.accentColor,
      fontFamily: fontFamily ?? state.fontFamily,
      fontSizeMultiplier: fontSizeMultiplier ?? state.fontSizeMultiplier,
      showAddress: showAddress ?? state.showAddress,
      showCustomerDetails: showCustomerDetails ?? state.showCustomerDetails,
      showFooter: showFooter ?? state.showFooter,
      customConfig: customConfig ?? state.customConfig,
    );

    state = newState;

    await _db.upsertInvoiceSettings(
      InvoiceSettingsCompanion(
        id: const Value(1),
        layout: Value(newState.layout.name),
        footerMessage: Value(newState.footerMessage),
        accentColor: Value(newState.accentColor),
        fontFamily: Value(newState.fontFamily),
        fontSizeMultiplier: Value(newState.fontSizeMultiplier),
        showAddress: Value(newState.showAddress),
        showCustomerDetails: Value(newState.showCustomerDetails),
        showFooter: Value(newState.showFooter),
        customConfig: Value(newState.customConfig),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

final invoiceTemplateProvider =
    NotifierProvider<InvoiceTemplateNotifier, InvoiceTemplate>(
      InvoiceTemplateNotifier.new,
    );
