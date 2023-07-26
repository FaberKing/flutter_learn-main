abstract mixin class PersistentState<T> {
  Future<bool> localSave();
  Future<T?> fromStorage();
}
