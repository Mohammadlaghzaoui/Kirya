import '../models/company.dart';
import 'kirya_store.dart';

class CompanyRepository {
  CompanyRepository(this._store);
  final KiryaStore _store;

  Future<List<Company>> all() async => [..._store.companies];

  Future<Company?> byId(String id) async {
    try {
      return _store.companies.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<Company?> byEmail(String email) async {
    try {
      return _store.companies.firstWhere(
        (c) => c.contactEmail.toLowerCase() == email.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<Company> save(Company company) async {
    final i = _store.companies.indexWhere((c) => c.id == company.id);
    if (i == -1) {
      _store.companies.add(company);
    } else {
      _store.companies[i] = company;
    }
    return company;
  }

  String newId() => _store.newId('company');
}
