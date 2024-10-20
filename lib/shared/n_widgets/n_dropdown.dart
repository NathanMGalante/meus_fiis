import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_future.dart';
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
    this.items = const [],
    this.searchItems,
    this.selectedItem,
    this.onSelected,
    this.itemText,
    this.enabled = true,
    this.hintText,
    this.label,
    this.enableSearch = false,
    this.required = false,
    this.errorText,
    this.noDataText,
  })  : assert(itemText != null || items is List<String> || items is List<num>),
        _valueController = TextEditingController(
            text: selectedItem == null
                ? null
                : itemText?.call(selectedItem) ?? selectedItem.toString());

  final FutureOr<List<ItemType>> items;
  final Future<List<ItemType>> Function(int page, int pageSize, String search)?
      searchItems;
  final ItemType? selectedItem;
  final String Function(ItemType)? itemText;
  final ValueChanged<ItemType?>? onSelected;
  final bool enabled;
  final String? hintText;
  final String? label;
  final bool enableSearch;
  final bool required;
  final String? errorText;
  final String? noDataText;

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
                child: Builder(
                  builder: (context) {
                    if (searchItems != null) {
                      return NScrollPagination<ItemType>(
                        controller: scrollPaginationController,
                        items: (page, pageSize) => searchItems!(
                          page,
                          pageSize,
                          searchController.value.text,
                        ),
                        itemVisibility: (item) {
                          return _getItemText(item)
                              .nNormalize
                              .toUpperCase()
                              .contains(
                                searchController.value.text.nNormalize
                                    .toUpperCase(),
                              );
                        },
                        itemBuilder: (context, item) {
                          return NButton(
                            onTap: () {
                              _valueController.text = _getItemText(item);
                              onSelected?.call(item);
                              Navigator.pop(context);
                            },
                            child: _SearchItem(
                              itemText: _getItemText(item),
                              searchText: searchController.value.text,
                            ),
                          );
                        },
                      );
                    }
                    return FutureBuilder<List<ItemType>>(
                      future: items.future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              errorText ?? snapshot.error.toString(),
                            ),
                          );
                        }
                        if ((snapshot.data ?? []).isEmpty) {
                          return Center(
                            child: Text(
                              noDataText ?? '',
                            ),
                          );
                        }
                        return ListView(
                          children: [
                            for (ItemType item in snapshot.data!)
                              NButton(
                                onTap: () {
                                  _valueController.text = _getItemText(item);
                                  onSelected?.call(item);
                                  Navigator.pop(context);
                                },
                                child: _SearchItem(
                                  itemText: _getItemText(item),
                                  searchText: searchController.value.text,
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
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

class _SearchItem extends StatelessWidget {
  const _SearchItem({
    required this.itemText,
    required this.searchText,
  });

  final String itemText;
  final String searchText;

  List<String> get _splitText {
    try {
      return itemText.nSplitFirstWord(searchText);
    } catch (ex) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_splitText.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(NSpacing.n8),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text(_splitText.first),
            ),
            WidgetSpan(
              child: Container(
                color: Theme.of(context).highlightColor,
                child: Text(_splitText.second),
              ),
            ),
            WidgetSpan(
              child: Text(_splitText.last),
            ),
          ],
        ),
      ),
    );
  }
}
