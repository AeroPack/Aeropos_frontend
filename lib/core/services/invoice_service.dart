import 'package:pdf/widgets.dart' as pw;
import '../../features/sales/templates/thermal_layout.dart';
import '../../features/sales/templates/modern_layout.dart';
import '../../features/sales/templates/classic_layout.dart';
import '../../features/sales/templates/luxury_layout.dart';
import '../../features/sales/templates/stylish_layout.dart';
import '../../features/sales/templates/simple_layout.dart';
import '../../features/sales/templates/advanced_gst_layout.dart';
import '../../features/sales/templates/dreams_layout.dart';
import '../models/sale.dart';
import '../models/invoice.dart';
import '../models/invoice_template.dart';
import '../database/app_database.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../di/service_locator.dart';

class InvoiceService {
  final ProfileRepository _profileRepository;

  InvoiceService()
    : _profileRepository = ServiceLocator.instance.profileRepository;
  Future<pw.Document> generateInvoicePdf(
    Invoice invoice,
    CustomerEntity? customer,
    InvoiceTemplate template,
  ) async {
    // Fetch profile data for business details
    Map<String, dynamic>? profile;
    try {
      profile = await _profileRepository.getProfile();
    } catch (e) {
      // If profile fetch fails, continue with null profile
      profile = null;
    }

    switch (template.layout) {
      case InvoiceLayout.modern:
        return await ModernLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.classic:
        return await ClassicLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.luxury:
        return await LuxuryLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.stylish:
        return await StylishLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.simple:
        return await SimpleLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.advanced_gst:
        return await AdvancedGstLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.dreams:
        return await DreamsLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
      case InvoiceLayout.thermal:
      case InvoiceLayout.custom:
        // Custom layout uses a different API, fallback to thermal for now
        return await ThermalLayout.generate(
          invoice,
          customer,
          template,
          profile,
        );
    }
  }

  /// Legacy support for Sales (POS checkout)
  Future<pw.Document> generateInvoice(
    Sale sale,
    InvoiceTemplate template,
  ) async {
    // Map Sale to Invoice for unified layout support
    final invoice = Invoice(
      uuid: sale.uuid,
      invoiceNumber: sale.invoiceNumber,
      customerId: sale.customerId,
      date: sale.createdAt,
      subtotal: sale.subtotal,
      tax: sale.tax,
      discount: sale.discount,
      total: sale.total,
      items: sale.items
          .map(
            (item) => InvoiceItem(
              productId: item.productId,
              productName: item.product.name,
              quantity: item.quantity,
              unitPrice: item.unitPrice,
              discount: item.discount, // Map item discount
              totalPrice: item.total,
            ),
          )
          .toList(),
    );

    return await generateInvoicePdf(invoice, null, template);
  }

  Future<pw.Document> generateModernInvoice({
    required Invoice invoice,
    required CustomerEntity? customer,
    required List<InvoiceItem> items,
    required InvoiceTemplate template,
  }) async {
    final fullInvoice = invoice.copyWith(items: items);
    return await generateInvoicePdf(fullInvoice, customer, template);
  }
}
