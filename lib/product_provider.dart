import 'package:flutter/material.dart';
import 'package:store_app/store_state_notifier.dart';

class ProductProvider extends InheritedWidget {
  final StoreStateNotifier notifier;

  const ProductProvider({
    Key? key,
    required Widget child,
    required this.notifier,
  }) : super(key: key, child: child);

  //const ProductProvider(Key? key, {required this.notifier, required this.child}) : super(key: key, child: child);
  static ProductProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ProductProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
