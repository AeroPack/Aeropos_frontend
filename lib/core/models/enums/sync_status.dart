enum SyncStatus {
  synced(0),
  pending(1),
  conflict(2),
  error(3);

  final int value;
  const SyncStatus(this.value);

  static SyncStatus fromValue(int value) {
    return SyncStatus.values.firstWhere((e) => e.value == value);
  }
}
