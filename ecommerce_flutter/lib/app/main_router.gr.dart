// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'main_router.dart';

class _$MainRouter extends RootStackRouter {
  _$MainRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    RegisterViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegisterView(),
      );
    },
    ProductDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ProductDetailView(
          key: args.key,
          item: args.item,
        ),
      );
    },
    CartViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CartView(),
      );
    },
    UserInfoViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const UserInfoView(),
      );
    },
    OrderViewRoute.name: (routeData) {
      final args = routeData.argsAs<OrderViewRouteArgs>(
          orElse: () => const OrderViewRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: OrderView(
          key: args.key,
          carts: args.carts,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'login',
          fullMatch: true,
        ),
        RouteConfig(
          LoginViewRoute.name,
          path: 'login',
        ),
        RouteConfig(
          HomeViewRoute.name,
          path: 'home',
        ),
        RouteConfig(
          RegisterViewRoute.name,
          path: 'register',
        ),
        RouteConfig(
          ProductDetailViewRoute.name,
          path: 'product_detail',
        ),
        RouteConfig(
          CartViewRoute.name,
          path: 'cart',
        ),
        RouteConfig(
          UserInfoViewRoute.name,
          path: 'user_info',
        ),
        RouteConfig(
          OrderViewRoute.name,
          path: 'order',
        ),
      ];
}

/// generated route for
/// [LoginView]
class LoginViewRoute extends PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: 'login',
        );

  static const String name = 'LoginViewRoute';
}

/// generated route for
/// [HomeView]
class HomeViewRoute extends PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: 'home',
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [RegisterView]
class RegisterViewRoute extends PageRouteInfo<void> {
  const RegisterViewRoute()
      : super(
          RegisterViewRoute.name,
          path: 'register',
        );

  static const String name = 'RegisterViewRoute';
}

/// generated route for
/// [ProductDetailView]
class ProductDetailViewRoute extends PageRouteInfo<ProductDetailViewRouteArgs> {
  ProductDetailViewRoute({
    Key? key,
    required Product item,
  }) : super(
          ProductDetailViewRoute.name,
          path: 'product_detail',
          args: ProductDetailViewRouteArgs(
            key: key,
            item: item,
          ),
        );

  static const String name = 'ProductDetailViewRoute';
}

class ProductDetailViewRouteArgs {
  const ProductDetailViewRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final Product item;

  @override
  String toString() {
    return 'ProductDetailViewRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [CartView]
class CartViewRoute extends PageRouteInfo<void> {
  const CartViewRoute()
      : super(
          CartViewRoute.name,
          path: 'cart',
        );

  static const String name = 'CartViewRoute';
}

/// generated route for
/// [UserInfoView]
class UserInfoViewRoute extends PageRouteInfo<void> {
  const UserInfoViewRoute()
      : super(
          UserInfoViewRoute.name,
          path: 'user_info',
        );

  static const String name = 'UserInfoViewRoute';
}

/// generated route for
/// [OrderView]
class OrderViewRoute extends PageRouteInfo<OrderViewRouteArgs> {
  OrderViewRoute({
    Key? key,
    List<CartItemModel>? carts,
  }) : super(
          OrderViewRoute.name,
          path: 'order',
          args: OrderViewRouteArgs(
            key: key,
            carts: carts,
          ),
        );

  static const String name = 'OrderViewRoute';
}

class OrderViewRouteArgs {
  const OrderViewRouteArgs({
    this.key,
    this.carts,
  });

  final Key? key;

  final List<CartItemModel>? carts;

  @override
  String toString() {
    return 'OrderViewRouteArgs{key: $key, carts: $carts}';
  }
}
