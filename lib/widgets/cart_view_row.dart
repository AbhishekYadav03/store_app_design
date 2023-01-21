import 'package:flutter/material.dart';
import 'package:store_app/product_provider.dart';

class CartViewRow extends StatelessWidget {
  const CartViewRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notifier = ProductProvider.of(context)?.notifier;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(
                  notifier?.cart.length ?? 0,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'list_${notifier?.cart[index].product.title}details',
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              notifier?.cart[index].product.image ?? "",
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          height: 16,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              notifier?.cart[index].quantity.toString() ?? "",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: const Color(0xFFF4C459),
          child: Text(
            notifier?.totalCartElements().toString() ?? "",
          ),
        ),
      ],
    );
  }
}
