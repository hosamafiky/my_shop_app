import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/fovorite_model.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  List<String> categories = ['Summer', 'T-Shirts', 'Shirts', 'Pants'];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.black45,
    ));
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const SizedBox(
              width: 82.0,
              child: Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          //TODO: Use CustomTabBar...
          body: ConditionalBuilder(
            condition: cubit.categoriesModel != null,
            builder: (context) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 12.0,
                        color: Colors.black.withOpacity(0.12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        height: 52.0,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              buildCategoryContainer(
                            cubit.categoriesModel!.data!.categories[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 13.0),
                          itemCount:
                              cubit.categoriesModel!.data!.categories.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.filter_list),
                                SizedBox(width: 7.0),
                                Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(Icons.compare_arrows),
                                SizedBox(width: 7.0),
                                Text(
                                  'Price: lowest to high',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                cubit.isGridView
                                    ? Icons.list
                                    : Icons.view_module,
                              ),
                              onPressed: () => cubit.changeViewStyle(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.favoritesModel != null,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: cubit.isGridView
                          ? GridView.count(
                              padding: const EdgeInsets.only(top: 16.0),
                              crossAxisCount: 2,
                              physics: const BouncingScrollPhysics(),
                              mainAxisSpacing: 18.0,
                              crossAxisSpacing: 19.0,
                              childAspectRatio: 0.59,
                              children: cubit.favoritesModel!.data!.favorites
                                  .map(
                                    (element) => buildFavoriteProductGridItem(
                                      element,
                                      cubit,
                                    ),
                                  )
                                  .toList(),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                bottom: 60.0,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  buildFavoriteProductListItem(
                                cubit.favoritesModel!.data!.favorites[index],
                                cubit,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16.0),
                              itemCount:
                                  cubit.favoritesModel!.data!.favorites.length,
                            ),
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildFavoriteProductListItem(FavoriteModel model, LayoutCubit cubit) =>
      SizedBox(
        width: double.infinity,
        height: 116.0,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: double.infinity,
                height: 104.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        //width: 104.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(model.product!.image!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    model.product!.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () => cubit.favorite(
                                      productId: model.product!.id!,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Row(
                                    children: [
                                      Text(
                                        '${model.product!.price!}\$',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (model.product!.discount != 0) ...[
                                        const SizedBox(width: 5.0),
                                        Text(
                                          '${model.product!.oldPrice!}\$',
                                          style: const TextStyle(
                                            color: buttonColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 25.0),
                                Expanded(
                                  flex: 10,
                                  child: Row(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xFFFFBA49),
                                          size: 14.0,
                                        ),
                                      const SizedBox(width: 5.0),
                                      const Text(
                                        '(10)',
                                        style: TextStyle(
                                          color: Color(0xFF222222),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
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
            Positioned(
              bottom: 0.0,
              right: 3.0,
              child: Container(
                width: 36.0,
                height: 36.0,
                decoration: const BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black45,
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () => cubit.addtoCart(
                    productId: model.product!.id!,
                  ),
                  icon: const Icon(
                    Icons.shopping_bag,
                    size: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (model.product!.discount != 0)
              Positioned(
                top: 5.0,
                left: 4.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(29.0),
                  ),
                  child: Text(
                    '-${model.product!.discount} %',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
  Widget buildFavoriteProductGridItem(
          FavoriteModel element, LayoutCubit cubit) =>
      Stack(
        children: [
          SizedBox(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 208.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        element.product!.image!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFBA49),
                        size: 14.0,
                      ),
                    const SizedBox(width: 5.0),
                    const Text(
                      '(10)',
                      style: TextStyle(
                        color: Color(0xFF9B9B9B),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    element.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '${element.product!.price!}\$',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (element.product!.discount != 0) ...[
                        const SizedBox(width: 5.0),
                        Text(
                          '${element.product!.oldPrice!}\$',
                          style: const TextStyle(
                            color: buttonColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (element.product!.discount != 0)
            Positioned(
              top: 8.0,
              left: 8.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(29.0),
                ),
                child: Text(
                  '- ${element.product!.discount} %',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 190.0,
            right: 10.0,
            child: Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                color: buttonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black45,
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => cubit.addtoCart(
                  productId: element.product!.id!,
                ),
                icon: const Icon(
                  Icons.shopping_bag,
                  size: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: GestureDetector(
              onTap: () => cubit.favorite(
                productId: element.product!.id!,
              ),
              child: const Icon(
                Icons.close,
                size: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      );
}
