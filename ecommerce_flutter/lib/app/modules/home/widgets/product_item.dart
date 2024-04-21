import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.colorFFFFFFFF,
        ),
        child: Column(
          children: [
            ImageNetwork(
              image:
                  "https://dictionary.cambridge.org/images/thumb/butter_noun_001_02096.jpg?version=5.0.390",
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
              onTap: () {
                debugPrint("©gabriel_patrick_souza");
              },
            ),
            const Text(
              "label",
              style: TextStyles.regularBlackS16,
            ),
            Text(
              "100.000 VNĐ",
              style: TextStyles.regularBlackS16
                  .copyWith(color: AppColors.colorFFf7472f),
            ),
          ],
        ),
      ),
    );
  }
}
