import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/tenant_service.dart';
import '../services/sync_service.dart';
import '../repositories/product_repository.dart';
import '../repositories/customer_repository.dart';
import '../repositories/supplier_repository.dart';
import '../repositories/employee_repository.dart';
import '../repositories/sale_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/unit_repository.dart';
import '../repositories/brand_repository.dart';
import '../services/inventory_service.dart';
import 'package:ezo/core/viewModel/product_view_model.dart';
import 'package:ezo/core/viewModel/category_view_model.dart';
import 'package:ezo/core/viewModel/unit_view_model.dart';
import 'package:ezo/core/viewModel/brand_view_model.dart';
import 'package:ezo/core/viewModel/customer_view_model.dart';
import 'package:ezo/core/viewModel/supplier_view_model.dart';
import 'package:ezo/core/viewModel/employee_view_model.dart';
import '../database/app_database.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_client.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import 'package:http/http.dart' as http;

class ServiceLocator {
  static final instance = ServiceLocator._();
  ServiceLocator._();

  late final AppDatabase database;
  late final FlutterSecureStorage secureStorage;
  late final Dio dio;

  late final ProductRepository productRepository;
  late final CustomerRepository customerRepository;
  late final SupplierRepository supplierRepository;
  late final EmployeeRepository employeeRepository;
  late final SaleRepository saleRepository;
  late final CategoryRepository categoryRepository;
  late final UnitRepository unitRepository;
  late final BrandRepository brandRepository;
  late final AuthRepository authRepository;
  late final ProfileRepository profileRepository;

  late final InventoryService inventoryService;
  late final SyncService syncService;
  late final TenantService tenantService;

  late final ProductViewModel productViewModel;
  late final CategoryViewModel categoryViewModel;
  late final UnitViewModel unitViewModel;
  late final BrandViewModel brandViewModel;
  late final CustomerViewModel customerViewModel;
  late final SupplierViewModel supplierViewModel;
  late final EmployeeViewModel employeeViewModel;

  Future<void> initialize() async {
    // Initialize database
    database = AppDatabase();

    // Initialize secure storage
    secureStorage = const FlutterSecureStorage();

    // Initialize network
    final authInterceptor = AuthInterceptor(secureStorage);
    dio = DioClient.createDio(authInterceptor);

    // Initialize data sources
    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio);

    // Initialize repositories
    productRepository = ProductRepository(database);
    customerRepository = CustomerRepository(database);
    supplierRepository = SupplierRepository(database);
    employeeRepository = EmployeeRepository(database);
    saleRepository = SaleRepository(database);
    categoryRepository = CategoryRepository(database);
    unitRepository = UnitRepository(database);
    brandRepository = BrandRepository(database);
    authRepository = AuthRepositoryImpl(
      authRemoteDataSource,
      secureStorage,
      database,
    );
    profileRepository = ProfileRepositoryImpl(
      http.Client(),
      secureStorage,
      baseUrl: 'http://127.0.0.1:5002', // Match backend port
    );

    // Initialize services
    tenantService = TenantService();
    inventoryService = InventoryService(productRepository);
    syncService = SyncService(
      db: database,
      dio: dio, // Injected shared Dio instance
      productRepo: productRepository,
      customerRepo: customerRepository,
      supplierRepo: supplierRepository,
      employeeRepo: employeeRepository,
      saleRepo: saleRepository,
      categoryRepo: categoryRepository,
      unitRepo: unitRepository,
      brandRepo: brandRepository,
    );

    // Initialize view models
    productViewModel = ProductViewModel(
      database,
      categoryRepository,
      unitRepository,
      brandRepository,
      syncService,
    );
    categoryViewModel = CategoryViewModel(database, syncService);
    unitViewModel = UnitViewModel(database, syncService);
    brandViewModel = BrandViewModel(database, syncService);
    customerViewModel = CustomerViewModel(
      database,
      customerRepository,
      syncService,
    );
    supplierViewModel = SupplierViewModel(
      database,
      supplierRepository,
      syncService,
    );
    employeeViewModel = EmployeeViewModel(
      database,
      employeeRepository,
      syncService,
    );

    // Start auto-sync
    syncService.startAutoSync(interval: const Duration(minutes: 5));
  }

  Future<void> dispose() async {
    syncService.stopAutoSync();
  }
}
