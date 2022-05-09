import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: cubit
              .screens[cubit.currentIndex], //cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            height: 53.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -4),
                  blurRadius: 20.0,
                  color: Colors.black.withOpacity(0.06),
                ),
              ],
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                items: cubit.botNavBarItems,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.changeBotNavBarIndex(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
