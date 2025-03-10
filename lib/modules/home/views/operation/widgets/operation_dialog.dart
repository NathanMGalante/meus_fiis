import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/modules/home/models/operation_type.dart';
import 'package:meus_fiis/modules/home/views/operation/controller.dart';
import 'package:meus_fiis/shared/in18.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';
import 'package:meus_fiis/shared/n_widgets/n_date_picker.dart';
import 'package:meus_fiis/shared/n_widgets/n_dropdown.dart';
import 'package:meus_fiis/shared/n_widgets/n_text_field.dart';

class OperationDialog extends StatefulWidget {
  const OperationDialog({super.key});

  @override
  State<OperationDialog> createState() => _OperationDialogState();
}

class _OperationDialogState extends State<OperationDialog> {
  OperationController get controller => Get.find<OperationController>();
  final _quantityController = TextEditingController(text: '0');
  final _priceController = TextEditingController(text: '0');

  String tag = '';
  OperationType type = OperationType.buy;
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
                label: In18.operationTagLabel.name.tr,
                searchItems: (page, pageSize, searchText) => controller.search(
                  page: page,
                  pageSize: pageSize,
                  searchText: searchText,
                ),
                selectedItem: tag,
                onSelected: (value) => setState(() => tag = value ?? ''),
                enableSearch: true,
                required: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: NSpacing.n8),
                child: Row(
                  children: [
                    Expanded(
                      child: NDropdown<OperationType>(
                        label: In18.operationTypeLabel.name.tr,
                        items: OperationType.values,
                        selectedItem: type,
                        itemText: (item) => item.text,
                        required: true,
                        onSelected: (value) => setState(
                          () => type = value ?? OperationType.buy,
                        ),
                      ),
                    ),
                    const SizedBox(width: NSpacing.n8),
                    Expanded(
                      child: NDatePicker(
                        label: In18.operationDateLabel.name.tr,
                        selectedDate: operationTime,
                        onChanged: (value) => setState(
                          () => operationTime = value,
                        ),
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
                      child: NTextField(
                        label: In18.operationQuantityLabel.name.tr,
                        controller: _quantityController,
                        onChanged: (value) => setState(
                          () => quantity = num.parse(value),
                        ),
                      ),
                    ),
                    const SizedBox(width: NSpacing.n8),
                    Expanded(
                      child: NTextField(
                        label: In18.operationPriceLabel.name.tr,
                        controller: _priceController,
                        onChanged: (value) => setState(
                          () => price = num.parse(value),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: NSpacing.n16),
                child: NButton(
                  onTap: () => controller.addOperation(
                    tag: tag,
                    type: type,
                    operationTime: operationTime!,
                    quantity: quantity,
                    price: price,
                  ),
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
