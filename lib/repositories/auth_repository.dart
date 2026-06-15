import '../models/app_user.dart';
import 'kirya_store.dart';

/// Minimal email/password authentication over the in-memory store.
///
/// Demo credentials (password equals the local-part of the email):
///   admin@kirya.app / admin   → Super Admin
///   owner@kirya.app / owner   → Rental Company Owner
///
/// Swap this for Firebase Auth / Supabase Auth by implementing [signIn] against
/// the provider and mapping the resulting claims to an [AppUser].
class AuthRepository {
  AuthRepository(this._store);
  final KiryaStore _store;

  Future<AppUser?> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final normalized = email.trim().toLowerCase();
    AppUser? user;
    for (final u in _store.users) {
      if (u.email.toLowerCase() == normalized) {
        user = u;
        break;
      }
    }
    if (user == null) return null;

    // Demo rule: password is the part before "@".
    final expected = user.email.split('@').first;
    if (password != expected) return null;
    return user;
  }
}
