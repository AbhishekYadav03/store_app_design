import 'package:store_app/model/product.dart';

class ProductItem {
  ProductItem({this.quantity = 1, required this.product});

  int quantity;
  final Product product;

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 0) {
      quantity++;
    }
  }
}
