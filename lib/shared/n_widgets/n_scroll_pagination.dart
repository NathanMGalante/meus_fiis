import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_sizing.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';
import 'package:meus_fiis/shared/n_widgets/n_scroll_fade.dart';

class NScrollPagination<ItemType> extends StatefulWidget {
  const NScrollPagination({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.items,
    this.itemVisibility,
  });

  final NScrollPaginationController<ItemType> controller;
  final Widget Function(BuildContext, ItemType) itemBuilder;
  final FutureOr<List<ItemType>> items;
  final bool Function(ItemType)? itemVisibility;

  @override
  State<NScrollPagination<ItemType>> createState() =>
      _NScrollPaginationState<ItemType>();
}

class _NScrollPaginationState<ItemType>
    extends State<NScrollPagination<ItemType>> {
  late ScrollController _scrollController;

  void _listener() {
    if (!widget.controller.lastPage &&
        _scrollController.offset +
                _scrollController.position.viewportDimension >=
            _scrollController.position.maxScrollExtent) {
      widget.controller._request();
    }
  }

  @override
  void didUpdateWidget(covariant NScrollPagination<ItemType> oldWidget) {
    widget.controller._widgetState = this;
    _scrollController.removeListener(_listener);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.controller._widgetState = this;
    _scrollController = ScrollController();
    _scrollController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return FutureBuilder<void>(
          future: widget.controller._loadItems(widget.items),
          builder: (context, snapshot) {
            if (widget.controller.isFirstPage) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: NButton(
                    onTap: widget.controller._request,
                    radius: NRadius.n8,
                    color: Theme.of(context).highlightColor,
                    padding: const EdgeInsets.all(8.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tentar novamente'),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ),
                );
              }
              if (widget.controller._parsedItems.isEmpty) {
                return NButton(
                  onTap: widget.controller._request,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Tentar novamente'),
                      Icon(Icons.refresh),
                    ],
                  ),
                );
              }
            }
            return NScrollFade(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: [
                  for (ItemType item in widget.controller._parsedItems)
                    widget.itemBuilder(context, item),
                  if (!widget.controller.isFirstPage &&
                      snapshot.connectionState == ConnectionState.waiting)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(NSpacing.n4),
                        child: SizedBox.square(
                          dimension: NSizing.n16,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      ),
                    ),
                  if (!widget.controller.isFirstPage && snapshot.hasError)
                    NButton(
                      onTap: widget.controller._request,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: NSpacing.n4),
                            child: Icon(Icons.refresh),
                          ),
                          Text('Tentar novamente'),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class NScrollPaginationController<ItemType> extends ChangeNotifier {
  NScrollPaginationController({this.pageSize = 10});

  _NScrollPaginationState<ItemType>? _widgetState;

  int pageSize;
  final List<ItemType> allItems = [];
  final List<ItemType> currentItems = [];
  int page = 0;
  bool lastPage = false;

  bool get isFirstPage => page == 0;

  List<ItemType> get _parsedItems {
    if (_widgetState?.widget.itemVisibility != null) {
      return currentItems.where(_widgetState!.widget.itemVisibility!).toList();
    }
    return currentItems;
  }

  Future<void> _loadItems(FutureOr<List<ItemType>> items) async {
    if (allItems.isEmpty) {
      allItems.addAll(await items);
    }
    int firstIndex = page * pageSize;
    if (!lastPage && firstIndex < allItems.length) {
      int lastIndex = firstIndex + pageSize;
      if (lastIndex > allItems.length) {
        lastIndex = allItems.length;
        lastPage = true;
      }
      page++;
      currentItems.addAll(allItems.sublist(firstIndex, lastIndex));
    }
  }

  void refresh() {
    reset();
    _request();
  }

  void reset() {
    allItems.clear();
    currentItems.clear();
    page = 0;
    lastPage = false;
  }

  @override
  void dispose() {
    _widgetState = null;
    super.dispose();
  }

  void _request() {
    if (_widgetState?.context != null && _widgetState!.context.mounted) {
      notifyListeners();
    }
  }
}
