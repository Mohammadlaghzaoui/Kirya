import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Labeled text field used throughout the CMS editors.
class CMSFieldEditor extends StatelessWidget {
  const CMSFieldEditor({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.prefix,
    this.helper,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix,
            helperText: helper,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

/// Two fields side by side on desktop, stacked on mobile.
class CMSFieldRow extends StatelessWidget {
  const CMSFieldRow({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 720;
    if (!isWide) return Column(children: children);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}
