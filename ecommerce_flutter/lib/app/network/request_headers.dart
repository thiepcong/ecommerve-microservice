import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getInt("userId");
    var customHeaders = {
      'content-type': 'application/json',
      'Accept': "application/json"
    };
    if (userId != null) {
      customHeaders.addAll({
        'Authorization': "Bearer ${token(userId)}",
      });
    }

    return customHeaders;
  }

  String token(int userId) {
    final jwt = JWT(
      // Payload
      {
        "user_id": userId,
      },
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

// Sign it (default with HS256 algorithm)
    final token = jwt.sign(SecretKey('@Helios'));
    return token;
  }
}
