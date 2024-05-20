import 'dart:developer';
import 'package:ecommerce_flutter/app/network/exceptions/bad_request_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../core/models/user.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(const HomeState());

  final HomeRepository _repo;

  final SpeechToText _speechToText = SpeechToText();

  void init() async {
    emit(state.copyWith(message: null, isLoading: true));
    final pre = await SharedPreferences.getInstance();
    final userId = pre.getString("userId");
    final lastName = pre.getString("lastName");
    final firstName = pre.getString("firstName");
    final email = pre.getString("email");
    final mobile = pre.getString("mobile");
    if (userId == null ||
        lastName == null ||
        firstName == null ||
        email == null ||
        mobile == null) return;
    final user = User(
      id: userId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      district: '',
      province: '',
      street: '',
      ward: '',
      dob: DateTime.now(),
      password: '',
      position: -1,
    );
    emit(state.copyWith(user: user, isLoading: false));
    _speechToText.initialize();
  }

  void startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 5),
    );
  }

  void stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    // setState(() {
    //   _lastWords = result.recognizedWords;
    // });
    emit(state.copyWith(searchKey: result.recognizedWords));
    log(state.searchKey ?? '');
    search(state.searchKey ?? '');
  }

  void search(String key) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res = await _repo.search(key: key);
      emit(state.copyWith(products: res, isLoading: false));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: "Đã có lỗi xảy ra!", isLoading: false));
        return;
      }
      rethrow;
    }
  }

  void setFilter(String filter) {
    emit(state.copyWith(filter: filter));
  }

  // void test() {
  //   String baseUrl = html.window.location.origin;
  //   final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
  //     url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
  //     version: '2.1.0',
  //     tmnCode: 'VVBTXMVT',
  //     txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
  //     orderInfo: 'Pay 30.000 VND',
  //     amount: 30000,
  //     returnUrl: "$baseUrl/#payment_paypal_cancel",
  //     ipAdress: '127.0.0.1',
  //     vnpayHashKey: '2CFWJDHQ74Q9T70XGGMWLK5RD0PF6RIA',
  //     vnPayHashType: VNPayHashType.SHA256,
  //   );
  //   log(paymentUrl);
  //   VNPAYFlutter.instance.show(
  //     paymentUrl: paymentUrl,
  //     onPaymentSuccess: (params) {
  //       log("oke");
  //     },
  //     onPaymentError: (params) {
  //       log("fail");
  //     },
  //     onWebPaymentComplete: () {
  //       log("oke2");
  //     },
  //   );
  // }
}
