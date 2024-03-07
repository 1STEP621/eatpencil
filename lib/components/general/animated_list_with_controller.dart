import 'package:flutter/material.dart';

class AnimatedListController<T> {
  late final void Function(List<T>) addAll;
  late final void Function(T) remove;
  late final void Function(int) removeTop;
  late final void Function(int) removeBottom;
  late final void Function() clear;

  void _setAddAllCallee(void Function(List<T>) to) {
    addAll = to;
  }

  void _setRemoveCallee(void Function(T) to) {
    remove = to;
  }

  void _setRemoveTopCallee(void Function(int) to) {
    removeTop = to;
  }

  void _setRemoveBottomCallee(void Function(int) to) {
    removeBottom = to;
  }

  void _setClearCallee(void Function() to) {
    clear = to;
  }
}

class AnimatedListWithController<T> extends StatefulWidget {
  final AnimatedListController<T> controller;
  final Widget Function(BuildContext, T, Animation<double>) itemBuilder;

  const AnimatedListWithController({
    required this.controller,
    required this.itemBuilder,
    super.key,
  });

  @override
  State<AnimatedListWithController<T>> createState() => _AnimatedListWithControllerState<T>();
}

class _AnimatedListWithControllerState<T> extends State<AnimatedListWithController<T>> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<T> _items = [];

  @override
  void initState() {
    widget.controller._setAddAllCallee((contents) {
      _items.insertAll(0, contents);
      _listKey.currentState?.insertAllItems(
        0,
        contents.length,
        duration: const Duration(milliseconds: 700),
      );
    });
    widget.controller._setRemoveCallee((content) {
      final index = _items.indexWhere((e) => e == content);
      _items.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: const SizedBox(),
          );
        },
      );
    });
    widget.controller._setRemoveTopCallee((count) {
      _items.removeRange(0, count);
      _listKey.currentState?.removeAllItems(
        (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: const SizedBox(),
          );
        },
      );
    });
    widget.controller._setRemoveBottomCallee((count) {
      _items.removeRange(_items.length - count, _items.length);
      _listKey.currentState?.removeAllItems(
        (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: const SizedBox(),
          );
        },
      );
    });
    widget.controller._setClearCallee(() {
      _items.clear();
      _listKey.currentState?.removeAllItems((context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const SizedBox(),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: CurveTween(
            curve: const Cubic(0.23, 1, 0.32, 1),
          ).animate(animation),
          child: widget.itemBuilder(context, _items[index], animation),
        );
      },
    );
  }
}
