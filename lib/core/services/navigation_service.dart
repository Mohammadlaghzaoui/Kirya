import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Small helper for opening external URLs (portal redirect, social links,
/// hosted Stripe Checkout in production).
class NavigationService {
  const NavigationService();

  Future<void> openExternal(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      await launchUrl(uri, webOnlyWindowName: '_self');
    } catch (e) {
      debugPrint('NavigationService.openExternal failed: $e');
    }
  }

  Future<void> openInNewTab(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } catch (e) {
      debugPrint('NavigationService.openInNewTab failed: $e');
    }
  }
}
