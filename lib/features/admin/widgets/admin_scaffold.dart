import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/responsive.dart';
import 'admin_sidebar.dart';
import 'admin_top_bar.dart';

/// Admin shell: persistent sidebar on desktop, drawer on smaller screens.
class AdminScaffold extends StatefulWidget {
  const AdminScaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  State<AdminScaffold> createState() => _AdminScaffoldState();
}

class _AdminScaffoldState extends State<AdminScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final currentRoute = GoRouterState.of(context).uri.path;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: isDesktop
          ? null
          : Drawer(
              child: AdminSidebar(
                currentRoute: currentRoute,
                onTapItem: () => Navigator.of(context).pop(),
              ),
            ),
      body: Row(
        children: [
          if (isDesktop) AdminSidebar(currentRoute: currentRoute),
          Expanded(
            child: Column(
              children: [
                AdminTopBar(
                  title: widget.title,
                  onMenuTap: isDesktop
                      ? null
                      : () => _scaffoldKey.currentState?.openDrawer(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isDesktop ? 28 : 18),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
