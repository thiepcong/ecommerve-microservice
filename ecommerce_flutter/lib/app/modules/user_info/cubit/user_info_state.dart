import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/address.dart';
import '../../../core/models/user.dart';

part 'user_info_state.freezed.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const UserInfoState._();

  const factory UserInfoState({
    @Default(false) bool isLoading,
    @Default(0) int filter,
    @Default([]) List<Address> addresses,
    User? user,
    String? message,
    Error? error,
  }) = _UserInfoState;
}
