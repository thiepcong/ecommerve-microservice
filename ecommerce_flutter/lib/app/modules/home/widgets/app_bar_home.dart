import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import 'tooltip_shape.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key, this.onSearch});

  final void Function(String)? onSearch;

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  final _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.colorFFf7472f,
      ),
      child: Row(
        children: [
          const SizedBox(width: 240),
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _searchController,
                cursorColor: AppColors.colorFF000000,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập từ khoá để tìm kiếm!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.colorFFFFFFFF,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Nhập để tìm kiếm...',
                  suffixIcon: InkWell(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.onSearch?.call(_searchController.text);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: const BoxDecoration(
                        color: AppColors.colorFFf7472f,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: AppColors.colorFFFFFFFF,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 120),
          PopupMenuButton(
            // constraints: const BoxConstraints(maxHeight: 83),
            shape: const TooltipShape(),
            padding: EdgeInsets.zero,
            tooltip: "Giỏ hàng",
            offset: const Offset(0, 50),
            color: AppColors.colorFFFFFFFF,
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColors.colorFFFFFFFF,
            ),
            onSelected: (value) async {
              switch (value) {
                // case 1:
                //   onTapDownload();
                //   break;
                case 2:
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                const PopupMenuItem(
                  // height: 30,
                  padding: EdgeInsets.zero,
                  value: 2,
                  child: CartPopupItem(),
                ),
                const PopupMenuItem(
                  // height: 30,
                  padding: EdgeInsets.zero,
                  value: 2,
                  child: CartPopupItem(),
                ),
                // const PopupMenuItem(
                //   // height: 30,
                //   padding: EdgeInsets.zero,
                //   value: 2,
                //   child: CartPopupItem(),
                // ),
                // const PopupMenuItem(
                //   // height: 30,
                //   padding: EdgeInsets.zero,
                //   value: 2,
                //   child: CartPopupItem(),
                // ),
                // const PopupMenuItem(
                //   // height: 30,
                //   padding: EdgeInsets.zero,
                //   value: 2,
                //   child: CartPopupItem(),
                // ),
                PopupMenuItem(
                  // height: 30,
                  padding: EdgeInsets.zero,
                  value: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "70 sản phẩm",
                          style: TextStyles.regularBlackS14
                              .copyWith(color: AppColors.colorFFC5C5C5),
                        ),
                        InkWell(
                          onTap: () => context.pushRoute(const CartViewRoute()),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            color: AppColors.colorFFf7472f,
                            child: Text(
                              "Xem giỏ hàng",
                              style: TextStyles.regularBlackS14
                                  .copyWith(color: AppColors.colorFFFFFFFF),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class CartPopupItem extends StatelessWidget {
  const CartPopupItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          ImageNetwork(
            image:
                "https://dictionary.cambridge.org/images/thumb/butter_noun_001_02096.jpg?version=5.0.390",
            height: 48,
            width: 48,
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
          const SizedBox(width: 8),
          const Expanded(
              child: Text(
            "label",
            style: TextStyles.regularBlackS14,
          )),
          const SizedBox(width: 8),
          Text(
            "100.000 đ",
            style: TextStyles.regularBlackS14
                .copyWith(color: AppColors.colorFFf7472f),
          )
        ],
      ),
    );
  }
}
