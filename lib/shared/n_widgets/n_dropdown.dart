import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_list.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_string.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';
import 'package:meus_fiis/shared/n_widgets/n_child_builder.dart';
import 'package:meus_fiis/shared/n_widgets/n_config.dart';
import 'package:meus_fiis/shared/n_widgets/n_scroll_view.dart';

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

  void _showSelection(BuildContext context) {
    final searchController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(NRadius.n4)),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
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
                      onChanged: (_) => setState(() {}),
                    ),
                  Expanded(
                    child: NScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var item in items.where(
                            (item) {
                              final text = _getItemText(item);
                              final search = searchController.value.text;
                              return text.nNormalize.toUpperCase().contains(
                                    search.nNormalize.toUpperCase(),
                                  );
                            },
                          ))
                            NButton(
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
                                                color: Theme.of(context)
                                                    .highlightColor,
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
                                      return Text('');
                                    }
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: _valueController,
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
      ),
      onTap: () => _showSelection(context),
    );
  }
}
