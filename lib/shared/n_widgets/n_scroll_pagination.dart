import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_widgets/n_child_builder.dart';
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
        return FutureBuilder<List<ItemType>>(
          future: widget.controller._loadItems(widget.items),
          builder: (context, snapshot) {
            return NChildBuilder(
              builder: (context, child) {
                if (widget.controller.isFirstPage) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if ((snapshot.data ?? []).isEmpty) {
                    return const Center(child: Text('Nenhum item encontrado'));
                  }
                  return child;
                }
                return child;

                // return Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Expanded(child: child),
                //     Builder(
                //       builder: (context) {
                //         if (snapshot.connectionState ==
                //             ConnectionState.waiting) {
                //           return const Center(
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //         if (snapshot.hasError) {
                //           return Text(snapshot.error.toString());
                //         }
                //         return child;
                //       },
                //     ),
                //   ],
                // );
              },
              child: NScrollFade(
                controller: _scrollController,
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: [
                    for (ItemType item in snapshot.data ?? [])
                      widget.itemBuilder(context, item),
                  ],
                ),
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

  Future<List<ItemType>> _loadItems(FutureOr<List<ItemType>> items) async {
    if (allItems.isEmpty) {
      allItems.addAll(await items);
    }
    int firstIndex = page * pageSize;
    if (lastPage || firstIndex >= allItems.length) {
      return currentItems;
    }

    int lastIndex = firstIndex + pageSize;
    if (lastIndex > allItems.length) {
      lastIndex = allItems.length;
      lastPage = true;
    }
    page++;
    currentItems.addAll(allItems.sublist(firstIndex, lastIndex));
    if (_widgetState?.widget.itemVisibility != null) {
      return currentItems.where(_widgetState!.widget.itemVisibility!).toList();
    }
    return currentItems;
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
