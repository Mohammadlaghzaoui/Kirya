import '../models/enums.dart';
import '../models/package_model.dart';
import 'kirya_store.dart';

/// CRUD + ordering operations for B2B packages.
class PackageRepository {
  PackageRepository(this._store);
  final KiryaStore _store;

  Future<List<PackageModel>> all() async {
    final list = [..._store.packages]..sort((a, b) => a.order.compareTo(b.order));
    return list;
  }

  Future<List<PackageModel>> active() async {
    final list = await all();
    return list.where((p) => p.isActive).toList();
  }

  Future<PackageModel?> byId(String id) async {
    try {
      return _store.packages.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<PackageModel> create(PackageModel package) async {
    _store.packages.add(package);
    return package;
  }

  Future<PackageModel> update(PackageModel package) async {
    final i = _store.packages.indexWhere((p) => p.id == package.id);
    if (i != -1) _store.packages[i] = package;
    return package;
  }

  Future<void> delete(String id) async {
    _store.packages.removeWhere((p) => p.id == id);
  }

  Future<void> toggleActive(String id) async {
    final i = _store.packages.indexWhere((p) => p.id == id);
    if (i == -1) return;
    final p = _store.packages[i];
    _store.packages[i] = p.copyWith(
      status: p.isActive ? RecordStatus.inactive : RecordStatus.active,
    );
  }

  Future<void> reorder(String id, int newOrder) async {
    final i = _store.packages.indexWhere((p) => p.id == id);
    if (i == -1) return;
    _store.packages[i] = _store.packages[i].copyWith(order: newOrder);
  }

  String newId() => _store.newId('pkg');
}
