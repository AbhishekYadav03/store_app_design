import 'package:flutter/cupertino.dart';
import 'package:store_app/model/product.dart';
import 'package:store_app/model/product_item.dart';

enum StorePageState { normal, detail, cart }

class StoreStateNotifier with ChangeNotifier {
  StorePageState pageState = StorePageState.normal;
  List<Product> products = productListFromJson(productString);
  List<ProductItem> cart = [];

  void changeToNormal() {
    pageState = StorePageState.normal;
    notifyListeners();
  }

  void changeToCart() {
    pageState = StorePageState.cart;
    notifyListeners();
  }

  void deleteProduct(ProductItem? productItem) {
    cart.remove(productItem);
    notifyListeners();
  }

  void addProduct(Product? product) {
    if (product == null) return;
    for (ProductItem item in cart) {
      if (item.product.id == product.id) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(ProductItem(product: product));
    notifyListeners();
  }

  void makeFavorite(Product? product) {
    if (product == null) return;
    var index = products.indexOf(product);
    product = product.copyWith(isFavorite: !(product.isFavorite));
    products[index] = product;
    notifyListeners();
  }

  int totalCartElements() => cart.fold<int>(0, (previousValue, element) => previousValue + element.quantity);

  double totalPriceElements() => cart.fold<double>(
      0.0, (previousValue, element) => previousValue + (element.quantity * (element.product.price ?? 0)));
}
