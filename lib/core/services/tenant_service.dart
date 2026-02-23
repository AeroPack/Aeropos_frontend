class TenantService {
  // Default to 1 for now/dev
  int _tenantId = 1;

  int get tenantId => _tenantId;

  void setTenantId(int id) {
    _tenantId = id;
  }
}
