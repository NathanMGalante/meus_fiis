import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';

class NTextField extends StatelessWidget {
  const NTextField({
    super.key,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.suffix,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: NSpacing.n16,
          right: NSpacing.n16,
          bottom: NSpacing.n16,
        ),
        constraints: BoxConstraints.tight(const Size.fromHeight(NSizing.n40)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NRadius.n4),
        ),
        hintStyle: Theme.of(context).textTheme.bodySmall,
        suffix: suffix,
      ),
    );
  }
}
