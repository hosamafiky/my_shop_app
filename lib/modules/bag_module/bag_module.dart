import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/shared/components/components.dart';

class BagScreen extends StatelessWidget {
  BagScreen({Key? key}) : super(key: key);

  final promoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        var inCartItemsLength = cubit.cartModel!.data!.cartItems.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Bag'),
            centerTitle: true,
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
            elevation: 5.0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var inCartItem = cubit.cartModel!.data!.cartItems[index];
                      return SizedBox(
                        height: 121.0,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: 104.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 104.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            inCartItem.product!.image!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    inCartItem.product!.name!,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => cubit.showDialog(
                                                      inCartItem.product!.id!),
                                                  child: const Icon(
                                                    Icons.more_vert_rounded,
                                                    size: 30.0,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      quantityButton(
                                                        icon: Icons.remove,
                                                        onPressed: () {},
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16.0,
                                                        ),
                                                        child: Text(
                                                          inCartItem.quantity!
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      quantityButton(
                                                        icon: Icons.add,
                                                        onPressed: () {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 25.0),
                                                Text(
                                                  '${inCartItem.product!.price!} \$',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (cubit.selectedIndexId ==
                                inCartItem.product!.id!)
                              Positioned(
                                top: 0.0,
                                right: 40.0,
                                child: Container(
                                  width: 170.0,
                                  height: 96.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 25.0,
                                        color: Colors.black.withOpacity(0.14),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () => cubit.favorite(
                                          productId: inCartItem.product!.id!,
                                        ),
                                        child: SizedBox(
                                          height: 48.0,
                                          child: Center(
                                            child: Text(
                                              inCartItem.product!.inFavorites!
                                                  ? 'Delete from favorites'
                                                  : 'Add to favorites',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                      InkWell(
                                        onTap: () => cubit.addtoCart(
                                          productId: inCartItem.product!.id!,
                                        ),
                                        child: const SizedBox(
                                          height: 47.0,
                                          child: Center(
                                            child: Text(
                                              'Delete from the list',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 24.0),
                    itemCount: inCartItemsLength,
                  ),
                ),
                const SizedBox(height: 14.0),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: promoController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your promo code',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total amount:',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${cubit.cartModel!.data!.total!.round().toString()} \$',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                customButton(text: 'Checkout', upper: true, onPressed: () {}),
                const SizedBox(height: 65.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
