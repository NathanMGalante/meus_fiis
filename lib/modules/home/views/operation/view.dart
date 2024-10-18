import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/views/operation/widgets/operation_button.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';

class OperationsView extends GetView<HomeController> {
  const OperationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: NSpacing.n4),
          child: const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: NSpacing.n4),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: NSpacing.n16,
                    ),
                    child: OperationButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
        for (final operation in controller.operations)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: NSpacing.n4,
              horizontal: NSpacing.n16,
            ),
            child: Text(operation.tag),
          )
      ],
    );
  }
}
