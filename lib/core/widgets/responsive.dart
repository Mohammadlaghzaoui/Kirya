import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

enum DeviceType { mobile, tablet, desktop }

/// Lightweight responsive helpers built on [LayoutBuilder] / [MediaQuery].
class Responsive {
  Responsive._();

  static DeviceType typeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < AppConstants.mobileBreakpoint) return DeviceType.mobile;
    if (width < AppConstants.tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      typeOf(context) == DeviceType.mobile;
  static bool isTablet(BuildContext context) =>
      typeOf(context) == DeviceType.tablet;
  static bool isDesktop(BuildContext context) =>
      typeOf(context) == DeviceType.desktop;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    switch (typeOf(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

/// Builder variant that exposes the current [DeviceType].
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, DeviceType type) builder;

  @override
  Widget build(BuildContext context) =>
      builder(context, Responsive.typeOf(context));
}

/// Constrains content to the brand max width and applies page padding.
class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.child,
    this.maxWidth = AppConstants.maxContentWidth,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<double>(
      context,
      mobile: 20,
      tablet: 32,
      desktop: 24,
    );
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: horizontal),
          child: child,
        ),
      ),
    );
  }
}
