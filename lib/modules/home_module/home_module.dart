import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        var cubit = LayoutCubit.get(context);
        if (state is LayoutGetHomeProductsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: buttonColor,
            ),
          );
        }
        if (state is LayoutAddFavoriteSuccessState) {
          if (state.addFavorite.status!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.addFavorite.message!),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () => cubit.favorite(
                      productId: state.addFavorite.data!.product!.id!),
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.addFavorite.message!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: buttonColor,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        height: 400.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/BigBanner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 32.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 230.0,
                              child: Text(
                                'Fashion Sale',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 57.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            customButton(
                              width: 160.0,
                              text: 'Check',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 22.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'New',
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 34.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'You\'ve never seen it before.',
                              style: TextStyle(
                                color: Color(0xFF9B9B9B),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          child: const Text(
                            'view all',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 260.0,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildProductsListItem(
                        cubit.newProducts[index],
                        cubit,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16.0),
                      itemCount: cubit.newProducts.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 22.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Sale',
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 34.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Super summer sale',
                              style: TextStyle(
                                color: Color(0xFF9B9B9B),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          child: const Text(
                            'view all',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 260.0,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildProductsListItem(
                        cubit.onSaleProducts[index],
                        cubit,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16.0),
                      itemCount: cubit.onSaleProducts.length,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
