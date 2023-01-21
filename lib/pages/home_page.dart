import 'package:flutter/material.dart';
import 'package:store_app/product_provider.dart';
import 'package:store_app/store_state_notifier.dart';
import 'package:store_app/widgets/cart_view_details.dart';
import 'package:store_app/widgets/cart_view_row.dart';
import 'package:store_app/widgets/product_list_view.dart';

double kCartHeight = 100;
Duration transitionDuration = const Duration(milliseconds: 200);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageStateNotifier = StoreStateNotifier();

  _onVerticalDragUpdate(DragUpdateDetails details) {
    var delta = details.primaryDelta ?? 0;
    if (delta < -3) {
      pageStateNotifier.changeToCart();
    } else if (delta > 5) {
      pageStateNotifier.changeToNormal();
    }
  }

  double getPageHeight(StorePageState state, Size size) {
    if (state == StorePageState.normal) {
      return -kCartHeight;
    } else if (state == StorePageState.cart) {
      return -(size.height - kToolbarHeight - kCartHeight / 2);
    }
    return 0;
  }

  double getCartHeight(StorePageState state, Size size) {
    if (state == StorePageState.normal) {
      return size.height - kCartHeight;
    } else if (state == StorePageState.cart) {
      return kToolbarHeight + kCartHeight / 2;
    }
    return 0;
  }

  double _getTopForAppBar(StorePageState state) {
    if (state == StorePageState.normal) {
      return 0.0;
    } else if (state == StorePageState.cart) {
      return -kCartHeight;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ProductProvider(
      notifier: pageStateNotifier,
      child: AnimatedBuilder(
        animation: pageStateNotifier,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedPositioned(
                          duration: transitionDuration,
                          curve: Curves.decelerate,
                          left: 0,
                          right: 0,
                          top: getPageHeight(pageStateNotifier.pageState, size),
                          height: size.height,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              margin: EdgeInsets.only(top: kToolbarHeight + kCartHeight),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: const ProductListView(),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: transitionDuration,
                          curve: Curves.decelerate,
                          left: 0,
                          right: 0,
                          top: getCartHeight(pageStateNotifier.pageState, size),
                          height: size.height,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalDragUpdate,
                            child: Container(
                              height: kCartHeight,
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedSwitcher(
                                      duration: transitionDuration,
                                      child: SizedBox(
                                        height: kToolbarHeight,
                                        child: pageStateNotifier.pageState == StorePageState.normal
                                            ? CartViewRow(key: UniqueKey())
                                            : const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CartViewDetails(key: UniqueKey()),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: transitionDuration,
                          top: _getTopForAppBar(pageStateNotifier.pageState),
                          left: 0,
                          right: 0,
                          child: AppBar(
                            elevation: 0,
                            backgroundColor: const Color(0xFFF4C459),
                            foregroundColor: Colors.white,
                            title: const Text("The Store"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
