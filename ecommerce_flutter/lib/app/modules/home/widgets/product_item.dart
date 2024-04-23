import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:ecommerce_flutter/app/main_router.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../core/models/product.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushRoute(ProductDetailViewRoute(item: item)),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.colorFFFFFFFF,
        ),
        child: Column(
          children: [
            ImageNetwork(
              image: "http://127.0.0.1:4002${item.image}",
              height: 150,
              width: 150,
              duration: 1500,
              curve: Curves.easeIn,
              onPointer: true,
              debugPrint: false,
              fullScreen: false,
              fitAndroidIos: BoxFit.cover,
              fitWeb: BoxFitWeb.cover,
              // borderRadius: BorderRadius.circular(4),
              onLoading: const CircularProgressIndicator(
                color: Colors.indigoAccent,
              ),
              onError: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            Text(
              item.title,
              style: TextStyles.regularBlackS16,
            ),
            Text(
              "${item.price.formatCurrency()} đ",
              style: TextStyles.regularBlackS16
                  .copyWith(color: AppColors.colorFFf7472f),
            ),
          ],
        ),
      ),
    );
  }
}
