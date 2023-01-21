import 'package:flutter/material.dart';
import 'package:store_app/product_provider.dart';

class CartViewDetails extends StatelessWidget {
  const CartViewDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notifier = ProductProvider.of(context)?.notifier;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Cart',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: notifier?.cart.length,
                    itemBuilder: (context, index) {
                      final item = notifier?.cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(item?.product.image ?? ""),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              item?.quantity.toString() ?? "",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                item?.product.title ?? "",
                                maxLines: 2,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '₹ ' + ((item?.product.price ?? 0) * (item?.quantity ?? 0)).toStringAsFixed(0),
                              style: const TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                notifier?.deleteProduct(item);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '₹ ' + (notifier?.totalPriceElements().toStringAsFixed(0) ?? ""),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0, left: 15.0, right: 15.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: const Color(0xFFF4C459),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () => null,
                  ),
                ),
                const Spacer(flex: 1)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
