import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';
import 'package:meus_fiis/shared/n_widgets/n_child_builder.dart';
import 'package:meus_fiis/shared/n_widgets/n_config.dart';
import 'package:meus_fiis/shared/n_widgets/n_text_field.dart';

class NDatePicker extends StatelessWidget {
  NDatePicker({
    super.key,
    DateTime? min,
    DateTime? max,
    this.selectedDate,
    this.onChanged,
    this.required = false,
    this.label,
  })  : min = min ?? DateTime(2020),
        max = max ?? DateTime(2025);

  final DateTime min;
  final DateTime max;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?>? onChanged;
  final bool required;
  final String? label;

  final _valueController = TextEditingController();

  Future<void> _showDatePicker(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: min,
      lastDate: max,
      locale: NConfig.of(context).locale,
    );
    if (newDate != null) {
      onChanged?.call(newDate);
    }
    _valueController.text = newDate?.toIso8601String() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return NTextField(
      readOnly: true,
      controller: _valueController,
      label: label,
      onTap: () => _showDatePicker(context),
      suffix: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: NSpacing.n16, left: NSpacing.n4),
            child: NChildBuilder(
              builder: (context, child) {
                if (required) {
                  return child;
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child,
                    Padding(
                      padding: const EdgeInsets.only(left: NSpacing.n8),
                      child: NButton(
                        radius: NRadius.n4,
                        onTap: () {
                          _valueController.text = '';
                          onChanged?.call(null);
                        },
                        child: const Icon(
                          Icons.clear,
                          size: NSizing.n16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: const Icon(
                Icons.arrow_drop_down,
                size: NSizing.n16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
