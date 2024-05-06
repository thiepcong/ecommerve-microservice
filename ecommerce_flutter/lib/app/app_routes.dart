abstract class Routes {
  const Routes._();
  static const login = _Paths.login;

  static const register = _Paths.register;

  static const home = _Paths.home;

  static const productDetail = _Paths.productDetail;

  static const cart = _Paths.cart;

  static const userInfo = _Paths.userInfo;

  static const order = _Paths.order;
}

abstract class _Paths {
  static const login = 'login';

  static const register = 'register';

  static const home = 'home';

  static const cart = 'cart';

  static const productDetail = 'product_detail';

  static const userInfo = 'user_info';

  static const order = 'order';
}
