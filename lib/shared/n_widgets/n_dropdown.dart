import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_config.dart';

class NDropdown<ItemType> extends StatelessWidget {
  const NDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.onSelected,
    this.itemText,
    this.enabled = true,
    this.hintText,
    this.label,
  }) : assert(itemText != null || items is List<String> || items is List<num>);

  final List<ItemType> items;
  final ItemType? selectedItem;
  final String Function(ItemType)? itemText;
  final ValueChanged<ItemType?>? onSelected;
  final bool enabled;
  final String? hintText;
  final String? label;

  Widget _suffixIcon(IconData trailingIcon) {
    return Transform.translate(
      offset: const Offset(-NSpacing.n4, -NSpacing.n4),
      child: Icon(trailingIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButtonTheme(
      data: const IconButtonThemeData(
          style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      )),
      child: DropdownMenu<ItemType>(
        enabled: enabled,
        initialSelection: selectedItem,
        label: label == null ? null : Text(label!),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: NSpacing.n16),
          constraints: BoxConstraints.tight(const Size.fromHeight(NSizing.n32)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(NRadius.n4),
          ),
          hintStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onSelected: onSelected,
        trailingIcon: _suffixIcon(Icons.arrow_drop_down),
        selectedTrailingIcon: _suffixIcon(Icons.arrow_drop_up),
        menuStyle: const MenuStyle(
          visualDensity: VisualDensity(vertical: -NSizing.n4),
        ),
        hintText: hintText ?? NConfig.of(context).dropdownHintText,
        dropdownMenuEntries: [
          for (var item in items)
            DropdownMenuEntry<ItemType>(
              value: item,
              label: itemText?.call(item) ?? item.toString(),
            ),
        ],
      ),
    );
  }
}
