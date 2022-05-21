import 'package:flutter/material.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/shared/style/colors.dart';

// Widgets ..
Widget customFormField({
  required String label,
  String? hint,
  Widget? suffixIcon,
  bool? isSecure = false,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  void Function(String)? onChanged,
}) =>
    Container(
      width: double.infinity,
      height: 64.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.black54,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TextFormField(
        style: const TextStyle(fontWeight: FontWeight.w500),
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          label: Text(label),
          suffixIcon: suffixIcon,
        ),
        obscureText: isSecure!,
      ),
    );

Widget customButton({
  required String text,
  double? width = double.infinity,
  required Function() onPressed,
  bool upper = false,
  Widget? child,
}) =>
    Container(
      height: 48.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: buttonColor,
      ),
      child: child ??
          TextButton(
            onPressed: onPressed,
            child: Text(
              upper ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
    );

Widget buildProductsListItem(
  ProductModel product,
  LayoutCubit cubit,
) =>
    Stack(
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 184.0,
                width: 148.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(product.image!),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    const Icon(
                      Icons.star_border_outlined,
                      size: 14.0,
                    ),
                  const SizedBox(width: 5.0),
                  const Text(
                    '(0)',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: 148.0,
                child: Text(
                  product.name!,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 0.9,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    '${product.price}\$',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      decoration: product.price != product.oldPrice
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  if (product.price != product.oldPrice) ...[
                    const SizedBox(width: 10.0),
                    Text(
                      '${product.oldPrice}\$',
                      style: const TextStyle(
                        color: buttonColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 60.0,
          right: 1.0,
          child: Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                onPressed: () => cubit.favorite(
                  productId: product.id!,
                ),
                icon: cubit.favorites[product.id]!
                    ? const Icon(
                        Icons.favorite,
                        size: 18.0,
                        color: buttonColor,
                      )
                    : const Icon(
                        Icons.favorite_border_outlined,
                        size: 18.0,
                        color: Color(0xFF9B9B9B),
                      ),
              )),
        ),
        Positioned(
          top: 8.0,
          left: 9.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 5.0,
            ),
            decoration: BoxDecoration(
              color:
                  product.discount > 0 ? buttonColor : const Color(0xFF222222),
              borderRadius: BorderRadius.circular(29.0),
            ),
            child: Text(
              product.price != product.oldPrice
                  ? '-${product.discount} %'
                  : 'New',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
Widget buildCategoryContainer(CategoryModel category) => Container(
      width: 100.0,
      height: 70.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(29.0),
      ),
      child: Center(
        child: Text(
          category.name!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
Widget quantityButton({
  required IconData icon,
  required Function()? onPressed,
}) =>
    Container(
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 8.0,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          color: Colors.grey,
        ),
        onPressed: onPressed,
      ),
    );
// Functions ..
navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}
