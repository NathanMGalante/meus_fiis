import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/modules/home/views/operation/controller.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';
import 'package:meus_fiis/shared/n_widgets/n_dropdown.dart';

class OperationDialog extends StatefulWidget {
  const OperationDialog({super.key});

  @override
  State<OperationDialog> createState() => _OperationDialogState();
}

class _OperationDialogState extends State<OperationDialog> {
  OperationController get controller => Get.find<OperationController>();

  String tag = '';
  OperationType? type;
  DateTime? operationTime;
  num quantity = 0;
  num price = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(NSpacing.n8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NDropdown<String>(
                searchItems: (page, pageSize, searchText) => controller.search(
                  page: page,
                  pageSize: pageSize,
                  searchText: searchText,
                ),
                enableSearch: true,
                required: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: NSpacing.n8),
                child: Row(
                  children: [
                    Expanded(
                      child: NDropdown<OperationType>(
                        items: OperationType.values,
                        selectedItem: OperationType.buy,
                        itemText: (item) => item.text,
                        required: true,
                      ),
                    ),
                    const SizedBox(width: NSpacing.n8),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: NSpacing.n32,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: NSpacing.n8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: NSpacing.n32,
                      ),
                    ),
                    const SizedBox(width: NSpacing.n8),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: NSpacing.n32,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: NSpacing.n16),
                child: NButton(
                  onTap: controller.addOperation,
                  radius: NRadius.n4,
                  padding: const EdgeInsets.symmetric(vertical: NRadius.n4),
                  color: Theme.of(context).buttonTheme.colorScheme?.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.plus,
                        color: Colors.white,
                        size: NSizing.n16,
                      ),
                      const Text(
                        'Adicionar',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
