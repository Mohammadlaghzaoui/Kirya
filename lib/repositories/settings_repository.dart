import '../models/website_settings.dart';
import 'kirya_store.dart';

class SettingsRepository {
  SettingsRepository(this._store);
  final KiryaStore _store;

  Future<WebsiteSettings> get() async => _store.settings;

  Future<WebsiteSettings> save(WebsiteSettings settings) async {
    _store.settings = settings;
    return settings;
  }
}
