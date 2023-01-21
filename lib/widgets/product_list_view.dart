import 'package:flutter/material.dart';
import 'package:store_app/model/product.dart';
import 'package:store_app/pages/product_details_page.dart';
import 'package:store_app/product_provider.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageStateNotifier = ProductProvider.of(context)?.notifier;

    return Container(
      color: Colors.white54.withOpacity(0.9),
      child: StaggeredDualView(
        aspectRatio: 0.7,
        offsetPercent: 0.3,
        itemCount: pageStateNotifier?.products.length ?? 0,
        itemBuilder: (_, index) {
          var product = pageStateNotifier?.products.elementAt(index);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 650),
                  pageBuilder: (context, animation, __) {
                    return FadeTransition(
                      opacity: animation,
                      child: ProductDetailsPage(
                        product: product ?? Product(),
                        onProductAdded: () {
                          pageStateNotifier?.addProduct(product);
                        },
                        onProductFavorite: () {
                          pageStateNotifier?.makeFavorite(product);
                        },
                      ),
                    );
                  },
                ),
              );
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 36,
                            bottom: 0,
                            child: Hero(
                              tag: 'list_${product?.title}',
                              child: Image.network(
                                product?.image ?? "",
                                height: 120,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -2,
                            right: 8,
                            child: IconButton(
                              tooltip: "Favorite",
                              onPressed: () {
                                pageStateNotifier?.makeFavorite(product);
                                (context as Element).reassemble();
                              },
                              icon: Icon(
                                product?.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹ ${(product?.price ?? 0).toStringAsFixed(0)}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      product?.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${product?.rating?.rate}",
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "(${product?.rating?.count} Ratings)",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Container(color: Colors.primaries.elementAt(index % Colors.primaries.length)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    // return ListView.builder(
    //   itemCount: pageStateNotifier?.notifier.products.length,
    //   itemBuilder: (_, index) {
    //     var product = pageStateNotifier?.notifier.products.elementAt(index);
    //     return Container(
    //       color: Colors.primaries.elementAt(index % Colors.primaries.length),
    //       height: kToolbarHeight,
    //       child: Text("${product?.title}"),
    //     );
    //   },
    // );
  }
}

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      this.spacing = 0.0,
      this.aspectRatio = 0.5,
      this.offsetPercent = 0.3})
      : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;
  final double offsetPercent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;
        final itemHeight = (width * 0.5) / aspectRatio;
        final height = constraints.maxHeight + itemHeight;

        return OverflowBox(
          maxHeight: height,
          minHeight: height,
          maxWidth: width,
          minWidth: width,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: (_, index) {
              return Transform.translate(
                offset: Offset(0.0, index.isOdd ? itemHeight * offsetPercent : 0.0),
                child: itemBuilder(context, index),
              );
            },
          ),
        );
      },
    );
  }
}
