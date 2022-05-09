import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_states.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              elevation: 10.0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
              bottom: const TabBar(
                indicatorWeight: 3.0,
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                labelColor: Color(0xFF222222),
                labelStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(icon: Text('Women')),
                  Tab(icon: Text('Men')),
                  Tab(icon: Text('Kids')),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                buildWomenPage(),
                buildMenPage(),
                buildKidsPage(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildWomenPage() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'SUMMER SALES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Up to 50% off',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                  text: 'New', imagePath: 'assets/images/cat_new.png'),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                  text: 'Clothes', imagePath: 'assets/images/cat_clothes.png'),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                  text: 'Shoes', imagePath: 'assets/images/cat_shoes.png'),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                  text: 'Accesories',
                  imagePath: 'assets/images/cat_accesories.png'),
              const SizedBox(height: 65.0),
            ],
          ),
        ),
      );
  Widget buildMenPage() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'SUMMER SALES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Up to 50% off',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'New',
                imagePath: 'assets/images/men_new.jpg',
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'Clothes',
                imagePath: 'assets/images/men_clothes.jpg',
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'Shoes',
                imagePath: 'assets/images/men_shoes.jpg',
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'Accesories',
                imagePath: 'assets/images/men_accesories.jpg',
              ),
              const SizedBox(height: 65.0),
            ],
          ),
        ),
      );
  Widget buildKidsPage() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'SUMMER SALES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Up to 50% off',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'New',
                imagePath: 'assets/images/kids_new.jpg',
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'Clothes',
                imagePath: 'assets/images/kids_clothes.jpg',
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'Shoes',
                imagePath: 'assets/images/kids_shoes.jpg',
              ),
              const SizedBox(height: 16.0),
              buildCategoryItem(
                text: 'Accesories',
                imagePath: 'assets/images/kids_accesories.jpg',
              ),
              const SizedBox(height: 65.0),
            ],
          ),
        ),
      );

  Widget buildCategoryItem({
    required String text,
    required String imagePath,
  }) =>
      InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
