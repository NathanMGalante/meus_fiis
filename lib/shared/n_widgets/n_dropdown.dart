import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_list.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_string.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';
import 'package:meus_fiis/shared/n_widgets/n_child_builder.dart';
import 'package:meus_fiis/shared/n_widgets/n_config.dart';
import 'package:meus_fiis/shared/n_widgets/n_scroll_pagination.dart';
import 'package:meus_fiis/shared/n_widgets/n_text_field.dart';

class NDropdown<ItemType> extends StatelessWidget {
  NDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.onSelected,
    this.itemText,
    this.enabled = true,
    this.hintText,
    this.label,
    this.enableSearch = false,
    this.required = false,
  })  : assert(itemText != null || items is List<String> || items is List<num>),
        _valueController = TextEditingController(
            text: selectedItem == null
                ? null
                : itemText?.call(selectedItem) ?? selectedItem.toString());

  final List<ItemType> items;
  final ItemType? selectedItem;
  final String Function(ItemType)? itemText;
  final ValueChanged<ItemType?>? onSelected;
  final bool enabled;
  final String? hintText;
  final String? label;
  final bool enableSearch;
  final bool required;

  final TextEditingController _valueController;

  String _getItemText(ItemType item) => itemText?.call(item) ?? item.toString();

  Future<void> _showSelection(BuildContext context) async {
    final searchController = TextEditingController();
    final NScrollPaginationController<ItemType> scrollPaginationController =
        NScrollPaginationController();
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(NRadius.n4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (enableSearch)
                TextField(
                  autofocus: true,
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: NSpacing.n16,
                    ),
                    hintText: NConfig.of(context).searchHintText,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  onChanged: (_) => scrollPaginationController.refresh(),
                ),
              Expanded(
                child: NScrollPagination<ItemType>(
                  controller: scrollPaginationController,
                  items: items,
                  itemVisibility: (item) {
                    return _getItemText(item).nNormalize.toUpperCase().contains(
                          searchController.value.text.nNormalize.toUpperCase(),
                        );
                  },
                  itemBuilder: (context, item) {
                    return NButton(
                      onTap: () {
                        _valueController.text = _getItemText(item);
                        onSelected?.call(item);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(NSpacing.n8),
                        child: Builder(
                          builder: (context) {
                            try {
                              final splitText =
                                  _getItemText(item).nSplitFirstWord(
                                searchController.value.text,
                              );
                              return Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(splitText.first),
                                    ),
                                    WidgetSpan(
                                      child: Container(
                                        color: Theme.of(context).highlightColor,
                                        child: Text(splitText.second),
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Text(splitText.last),
                                    ),
                                  ],
                                ),
                              );
                            } catch (ex) {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NTextField(
      readOnly: true,
      controller: _valueController,
      onTap: () => _showSelection(context),
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
                          onSelected?.call(null);
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
