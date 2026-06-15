import 'package:flutter/material.dart';

import 'app_footer.dart';
import 'responsive_navbar.dart';

/// Standard public-page chrome: sticky navbar, mobile drawer and footer around a
/// scrollable body.
class PublicScaffold extends StatefulWidget {
  const PublicScaffold({
    super.key,
    required this.children,
    this.showFooter = true,
  });

  final List<Widget> children;
  final bool showFooter;

  @override
  State<PublicScaffold> createState() => _PublicScaffoldState();
}

class _PublicScaffoldState extends State<PublicScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: const MobileNavDrawer(),
      appBar: ResponsiveNavbar(
        onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...widget.children,
            if (widget.showFooter) const AppFooter(),
          ],
        ),
      ),
    );
  }
}
