import '../../../core/base/base_remote_source.dart';
import '../../../core/models/address.dart';
import '../../../core/models/carrier.dart';
import '../../../core/values/api_url_constant.dart';

class OrderApi extends BaseRemoteSource {
  Future<List<Address>> getAllAddress() async {
    final request = dioClient.get(ApiUrlConstants.address);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Address.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Carrier>> getAllCarrier() async {
    final request = dioClient.get(ApiUrlConstants.carrier);
    try {
      return callApiWithErrorParser(request).then((value) =>
          (value.data as List).map((e) => Carrier.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }
}
