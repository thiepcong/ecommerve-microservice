import 'dart:convert';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../core/models/models.dart';

class PaypalPayment {
  final PaypalSecret paypalSecret;

  PaypalPayment({required this.paypalSecret});
  _baseUrl(PaypalSecret paypalSecret) {
    String baseUrl = paypalSecret.paymentMode == PaymentMode.sandbox
        ? "https://api-m.sandbox.paypal.com"
        : 'https://api.paypal.com';
    return baseUrl;
  }

  Future<Token> getAccessToken(PaypalSecret paypalSecret) async {
    var client = AuthClient(paypalSecret.clientId, paypalSecret.clientSecret);
    var response = await client.post(
      Uri.parse(
          "${_baseUrl(paypalSecret)}/v1/oauth2/token?grant_type=client_credentials"),
      // Uri.parse(
      //     "https://api-m.sandbox.paypal.com/v1/oauth2/token?grant_type=client_credentials"),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print(body);

      return Token(
        token: body['access_token'],
        message: 'access granted',
      );
    }
    return Token(token: null, message: 'access denied');
  }

  // Future<Payment> createPaymnet()
  Future<Payment> createPayment(
    Map<String, dynamic> transactions,
    String accessToken,
  ) async {
    try {
      var response = await http.post(
        // Uri.parse('https://api-m.sandbox.paypal.com/v2/checkout/orders'),
        Uri.parse("${_baseUrl(paypalSecret)}/v2/checkout/orders"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(transactions),
      );

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(data['links']);
        if (data["links"] != null && data["links"].length > 0) {
          List links = data["links"];

          String approvalUrl = "";
          final item = links.firstWhere(
            (o) => o["rel"] == "payer-action",
            orElse: () => null,
          );
          if (item != null) {
            approvalUrl = item["href"];
          }
          // print(approvalUrl);

          return Payment(
            status: true,
            approvalUrl: approvalUrl,
          );
        }
      }
    } catch (e) {
      log('Error creating payment: $e');
    }

    return Payment(status: false);
  }
}

class AuthClient extends http.BaseClient {
  final String paypalClientId;
  final String paypalClientSecret;
  final http.Client _inner;
  final String _authString;

  AuthClient(this.paypalClientId, this.paypalClientSecret, {http.Client? inner})
      : _authString = _getAuthString(paypalClientId, paypalClientSecret),
        _inner = inner ?? http.Client();
  static String _getAuthString(String username, String password) {
    final token = base64.encode(latin1.encode('$username:$password'));

    final authstr = 'Basic ${token.trim()}';

    return authstr;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Authorization'] = _authString;

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
