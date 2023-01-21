import 'package:flutter/material.dart';
import 'package:store_app/model/product.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.product,
    this.onProductAdded,
    this.onProductFavorite,
  }) : super(key: key);

  final Product product;
  final VoidCallback? onProductAdded;
  final VoidCallback? onProductFavorite;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String heroTag = '';

  void _addToCart(BuildContext context) {
    setState(() {
      heroTag = 'details';
    });
    if (widget.onProductAdded != null) widget.onProductAdded!();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Product Details",
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(color: Colors.black),
        ),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFF4C459),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'list_${widget.product.title}$heroTag',
                      child: Image.network(
                        widget.product.image ?? "",
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.product.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (widget.product.category ?? "").toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          '₹ ${(widget.product.price ?? 0).toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'About the product',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.description ?? "",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(
                      widget.product.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (widget.onProductFavorite != null) widget.onProductFavorite!();
                      print("object");
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: const Color(0xFFF4C459),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () => _addToCart(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
