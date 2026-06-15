import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_user.dart';
import 'repository_providers.dart';

/// Authentication state. Null means signed out.
class AuthController extends Notifier<AppUser?> {
  @override
  AppUser? build() => null;

  Future<bool> signIn(String email, String password) async {
    final user =
        await ref.read(authRepositoryProvider).signIn(email, password);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  void signOut() => state = null;
}

final authProvider =
    NotifierProvider<AuthController, AppUser?>(AuthController.new);

/// Convenience flags for protected routing.
final isAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(authProvider);
  return user?.isAdmin ?? false;
});

final hasPortalAccessProvider = Provider<bool>((ref) {
  final user = ref.watch(authProvider);
  if (user == null) return false;
  if (user.isAdmin) return true;
  if (!user.isCompanyOwner || user.companyId == null) return false;
  final company = ref
      .watch(kiryaStoreProvider)
      .companies
      .where((c) => c.id == user.companyId)
      .toList();
  return company.isNotEmpty && company.first.portalAccess;
});
