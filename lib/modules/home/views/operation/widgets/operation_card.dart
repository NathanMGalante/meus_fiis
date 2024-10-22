import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/modules/home/models/operation.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/modules/home/views/operation/controller.dart';
import 'package:meus_fiis/modules/home/views/operation/widgets/operation_card_item.dart';
import 'package:meus_fiis/shared/in18.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_colors.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_date_formatter.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';

class OperationCard extends GetWidget<OperationController> {
  const OperationCard({
    super.key,
    required this.operation,
  });

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: NSpacing.n4,
              horizontal: NSpacing.n16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OperationCardItem(
                        label: In18.operationTagLabel,
                        value: operation.tag,
                      ),
                    ),
                    Expanded(
                      child: OperationCardItem(
                        label: In18.operationTypeLabel,
                        value: operation.operationType.text,
                        color: (operation.operationType == OperationType.buy
                            ? Colors.green
                            : Colors.red),
                      ),
                    ),
                    Expanded(
                      child: OperationCardItem(
                        label: In18.operationDateLabel,
                        value: NDateFormatter.formatDate(
                          operation.operationDateTime,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: NSpacing.n4),
                  child: Row(
                    children: [
                      Expanded(
                        child: OperationCardItem(
                          label: In18.operationQuantityLabel,
                          value: operation.quantity.toString(),
                        ),
                      ),
                      Expanded(
                        child: OperationCardItem(
                          label: In18.operationPriceLabel,
                          value: operation.price.toString(),
                        ),
                      ),
                      Expanded(
                        child: OperationCardItem(
                          label: In18.operationTotalLabel,
                          value:
                              (operation.quantity * operation.price).toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 4,
            child: NButton(
              onTap: () => controller.removeOperation(operation),
              radius: 64,
              padding: const EdgeInsets.all(NSpacing.n2),
              child: Icon(
                MdiIcons.delete,
                size: NSizing.n16,
                color: Colors.red.withMix(
                  Theme.of(context).colorScheme.primary,
                  250,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
