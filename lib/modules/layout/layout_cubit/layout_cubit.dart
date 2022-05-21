// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/fovorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/bag_module/bag_module.dart';
import 'package:shop_app/modules/favorites_module/favorites_module.dart';
import 'package:shop_app/modules/home_module/home_module.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/modules/shop_module/shop_module.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';
import 'package:shop_app/shared/network/remote/google_signin.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  bool isGridView = false;

  void changeViewStyle() {
    isGridView = !isGridView;
    emit(LayoutChangeViewStyleState());
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ShopScreen(),
    BagScreen(),
    const FavoritesScreen(),
    const HomeScreen(),
  ];
  List<BottomNavigationBarItem> botNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      activeIcon: Icon(Icons.shopping_cart),
      label: 'Shop',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
      label: 'Bag',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border_outlined),
      activeIcon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  int selectedIndexId = 0;
  void showDialog(int productId) {
    selectedIndexId = selectedIndexId == productId ? 0 : productId;
    emit(LayoutShowProductDialogState());
  }

  void changeBotNavBarIndex(index) {
    currentIndex = index;
    selectedIndexId = 0;

    emit(LayoutChangeBottomNavBarIndexState());
  }

  List<ProductModel> newProducts = [];
  List<ProductModel> onSaleProducts = [];
  Map<int, bool> favorites = {};
  HomeModel? homeModel;
  void getHomeProducts() {
    emit(LayoutGetHomeProductsLoadingState());
    DioHelper.getData(
      token: token,
      endPoint: HOME,
      lang: 'en',
    ).then((value) {
      favorites = {};
      newProducts = [];
      onSaleProducts = [];
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
        if (element.discount != 0) {
          onSaleProducts.add(element);
        } else {
          newProducts.add(element);
        }
      });
      emit(LayoutGetHomeProductsSuccessState(homeModel!));
    }).catchError((error) {
      emit(LayoutGetHomeProductsErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoriteProducts() {
    emit(LayoutGetFavoritesLoadingState());
    DioHelper.getData(
      token: token,
      endPoint: FAVORITES,
      lang: 'en',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(LayoutGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutGetFavoritesErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(LayoutGetCategoriesLoadingState());
    DioHelper.getData(
      token: token,
      endPoint: CATEGORIES,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(LayoutGetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutGetCategoriesErrorState(error.toString()));
    });
  }

  AddFavorite? favoriteProduct;
  void favorite({
    required int productId,
  }) {
    favorites[productId] = !favorites[productId]!;
    emit(LayoutAddFavoriteLoadingState());
    DioHelper.postData(
      endPoint: FAVORITES,
      data: {'product_id': productId},
      token: token,
      lang: 'en',
    ).then((value) {
      favoriteProduct = AddFavorite.fromJson(value.data);
      selectedIndexId = 0;
      emit(LayoutAddFavoriteSuccessState(favoriteProduct!));
      getFavoriteProducts();
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(LayoutAddFavoriteErrorState(error.toString()));
    });
  }

  CartModel? cartModel;
  void getCartData() {
    emit(LayoutGetCartDataLoadingState());
    DioHelper.getData(
      lang: 'en',
      token: token,
      endPoint: CARTS,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(LayoutGetCartDataSuccessState(cartModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LayoutGetCartDataErrorState(error.toString()));
    });
  }

  CartChange? cartChange;
  void addtoCart({required int productId}) {
    emit(LayoutAddToCartLoadingState());
    DioHelper.postData(
      endPoint: CARTS,
      data: {'product_id': productId},
      token: token,
      lang: 'en',
    ).then((value) {
      cartChange = CartChange.fromJson(value.data);
      selectedIndexId = 0;
      emit(LayoutAddToCartSuccessState());
      getCartData();
    }).catchError((error) {
      emit(LayoutAddToCartErrorState(error.toString()));
    });
  }
}
