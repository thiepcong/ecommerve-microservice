import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/values/app_theme.dart';
import 'main_router.dart';
import 'modules/cart/api/cart_api.dart';
import 'modules/cart/repository/cart_repository.dart';
import 'modules/home/api/home_api.dart';
import 'modules/home/repository/home_repository.dart';
import 'modules/login/api/login_api.dart';
import 'modules/login/repository/login_repository.dart';
import 'modules/product_detail/api/product_detail_api.dart';
import 'modules/product_detail/repository/product_detail_repository.dart';
import 'modules/user_info/api/user_info_api.dart';
import 'modules/user_info/repository/user_info_repository.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class RouteApp extends StatefulWidget {
  const RouteApp({super.key});

  @override
  State<RouteApp> createState() => _RouteAppState();
}

class _RouteAppState extends State<RouteApp> {
  @override
  void initState() {
    super.initState();
    _appRouter = MainRouter(
      navigatorKey: navigatorKey,
    );
  }

  late MainRouter _appRouter;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginRepository>(
          create: (context) => LoginRepository(LoginApi()),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(HomeApi()),
        ),
        RepositoryProvider<UserInfoRepository>(
          create: (context) => UserInfoRepository(UserInfoApi()),
        ),
        RepositoryProvider<ProductDetailRepository>(
          create: (context) => ProductDetailRepository(ProductDetailApi()),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(CartApi()),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(
          navigatorObservers: () => [
            AutoRouteObserver(),
          ],
        ),
        theme: appTheme,
        localizationsDelegates: const [],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
