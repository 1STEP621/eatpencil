import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:eatpencil/providers.dart';

class AnimatedListController<T> {
  late final List<T> Function() contents;
  late final void Function(T) add;
  late final void Function(List<T>) addAll;
  late final void Function(T) remove;
  late final void Function(int) removeAt;
  late final void Function(T, T) update;
  late final void Function(int, T) updateAt;
  late final void Function() clear;
}

class AnimatedListWithController<T> extends ConsumerStatefulWidget {
  final AnimatedListController<T> controller;
  final Widget Function(BuildContext, T, Animation<double>) itemBuilder;
  final bool reverse;

  const AnimatedListWithController({
    required this.controller,
    required this.itemBuilder,
    this.reverse = false,
    super.key,
  });

  @override
  ConsumerState<AnimatedListWithController<T>> createState() => _AnimatedListWithControllerState<T>();
}

class _AnimatedListWithControllerState<T> extends ConsumerState<AnimatedListWithController<T>> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<T> _items = [];

  @override
  void initState() {
    widget.controller.contents = () => _items;
    widget.controller.add = (content) {
      _items.insert(0, content);
      _listKey.currentState?.insertItem(
        0,
        duration: const Duration(milliseconds: 700),
      );
    };
    widget.controller.addAll = (contents) {
      _items.insertAll(0, contents);
      _listKey.currentState?.insertAllItems(
        0,
        contents.length,
        duration: const Duration(milliseconds: 700),
      );
    };
    widget.controller.remove = (content) {
      final index = _items.indexWhere((e) => e == content);
      _items.removeAt(index);
      _listKey.currentState?.removeItem(index, (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: widget.itemBuilder(context, content, animation),
        );
      });
    };
    widget.controller.removeAt = (index) {
      final item = _items[index];
      _items.removeAt(index);
      _listKey.currentState?.removeItem(index, (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: widget.itemBuilder(context, item, animation),
        );
      });
    };
    widget.controller.update = (from, to) {
      final index = _items.indexWhere((e) => e == from);
      setState(() {
        _items[index] = to;
      });
    };
    widget.controller.updateAt = (index, to) {
      setState(() {
        _items[index] = to;
      });
    };
    widget.controller.clear = () {
      _items.clear();
      _listKey.currentState?.removeAllItems((context, animation) {
        return const SizedBox();
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      reverse: widget.reverse,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: CurveTween(
            curve: const Cubic(0.23, 1, 0.32, 1),
          ).animate(animation),
          child: Column(
            children: [
              SizedBox(
                key: ValueKey(_items[index]),
                child: widget.itemBuilder(context, _items[index], animation),
              ),
              if (index != _items.length - 1)
                Divider(
                  color: theme(ref).divider,
                  height: 0,
                ),
            ],
          ),
        );
      },
    );
  }
}
