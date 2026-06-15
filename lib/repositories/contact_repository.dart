import '../models/contact_request.dart';
import 'kirya_store.dart';

class ContactRepository {
  ContactRepository(this._store);
  final KiryaStore _store;

  Future<List<ContactRequest>> all() async {
    final list = [..._store.contactRequests]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  Future<ContactRequest> submit({
    required String companyName,
    required String contactPerson,
    required String email,
    String? phone,
    int? vehicleCount,
    required String message,
  }) async {
    // Simulate network latency.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final now = DateTime.now();
    final request = ContactRequest(
      id: _store.newId('contact'),
      companyName: companyName,
      contactPerson: contactPerson,
      email: email,
      phone: phone,
      vehicleCount: vehicleCount,
      message: message,
      createdAt: now,
      updatedAt: now,
    );
    _store.contactRequests.add(request);
    return request;
  }

  Future<void> markHandled(String id, {required bool handled}) async {
    final i = _store.contactRequests.indexWhere((c) => c.id == id);
    if (i != -1) {
      _store.contactRequests[i] =
          _store.contactRequests[i].copyWith(handled: handled);
    }
  }
}
