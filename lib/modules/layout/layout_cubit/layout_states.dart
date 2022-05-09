import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/fovorite_model.dart';
import 'package:shop_app/models/home_model.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class LayoutChangeBottomNavBarIndexState extends LayoutStates {}

class LayoutChangeViewStyleState extends LayoutStates {}

class LayoutShowProductDialogState extends LayoutStates {}

class LayoutGetHomeProductsLoadingState extends LayoutStates {}

class LayoutGetHomeProductsSuccessState extends LayoutStates {
  final HomeModel homeModel;

  LayoutGetHomeProductsSuccessState(this.homeModel);
}

class LayoutGetHomeProductsErrorState extends LayoutStates {
  final String error;

  LayoutGetHomeProductsErrorState(this.error);
}

class LayoutGetFavoritesLoadingState extends LayoutStates {}

class LayoutGetFavoritesSuccessState extends LayoutStates {}

class LayoutGetFavoritesErrorState extends LayoutStates {
  final String error;

  LayoutGetFavoritesErrorState(this.error);
}

class LayoutGetCategoriesLoadingState extends LayoutStates {}

class LayoutGetCategoriesSuccessState extends LayoutStates {}

class LayoutGetCategoriesErrorState extends LayoutStates {
  final String error;

  LayoutGetCategoriesErrorState(this.error);
}

class LayoutAddFavoriteLoadingState extends LayoutStates {}

class LayoutAddFavoriteSuccessState extends LayoutStates {
  final AddFavorite addFavorite;

  LayoutAddFavoriteSuccessState(this.addFavorite);
}

class LayoutAddFavoriteErrorState extends LayoutStates {
  final String error;

  LayoutAddFavoriteErrorState(this.error);
}

class LayoutGetCartDataLoadingState extends LayoutStates {}

class LayoutGetCartDataSuccessState extends LayoutStates {
  final CartModel cartModel;

  LayoutGetCartDataSuccessState(this.cartModel);
}

class LayoutGetCartDataErrorState extends LayoutStates {
  final String error;

  LayoutGetCartDataErrorState(this.error);
}

class LayoutAddToCartLoadingState extends LayoutStates {}

class LayoutAddToCartSuccessState extends LayoutStates {}

class LayoutAddToCartErrorState extends LayoutStates {
  final String error;

  LayoutAddToCartErrorState(this.error);
}
