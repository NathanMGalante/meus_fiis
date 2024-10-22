import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/shared/in18.dart';

class OperationCardItem extends StatelessWidget {
  const OperationCardItem({
    super.key,
    required this.label,
    required this.value,
    this.color,
  });

  final In18 label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.name.tr,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}
