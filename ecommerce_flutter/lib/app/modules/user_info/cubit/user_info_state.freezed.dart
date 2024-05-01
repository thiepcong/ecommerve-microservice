// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserInfoState {
  bool get isLoading => throw _privateConstructorUsedError;
  int get filter => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserInfoStateCopyWith<UserInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoStateCopyWith<$Res> {
  factory $UserInfoStateCopyWith(
          UserInfoState value, $Res Function(UserInfoState) then) =
      _$UserInfoStateCopyWithImpl<$Res, UserInfoState>;
  @useResult
  $Res call(
      {bool isLoading, int filter, User? user, String? message, Error? error});
}

/// @nodoc
class _$UserInfoStateCopyWithImpl<$Res, $Val extends UserInfoState>
    implements $UserInfoStateCopyWith<$Res> {
  _$UserInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? filter = null,
    Object? user = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoStateImplCopyWith<$Res>
    implements $UserInfoStateCopyWith<$Res> {
  factory _$$UserInfoStateImplCopyWith(
          _$UserInfoStateImpl value, $Res Function(_$UserInfoStateImpl) then) =
      __$$UserInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, int filter, User? user, String? message, Error? error});
}

/// @nodoc
class __$$UserInfoStateImplCopyWithImpl<$Res>
    extends _$UserInfoStateCopyWithImpl<$Res, _$UserInfoStateImpl>
    implements _$$UserInfoStateImplCopyWith<$Res> {
  __$$UserInfoStateImplCopyWithImpl(
      _$UserInfoStateImpl _value, $Res Function(_$UserInfoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? filter = null,
    Object? user = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$UserInfoStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
    ));
  }
}

/// @nodoc

class _$UserInfoStateImpl extends _UserInfoState {
  const _$UserInfoStateImpl(
      {this.isLoading = false,
      this.filter = 0,
      this.user,
      this.message,
      this.error})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int filter;
  @override
  final User? user;
  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'UserInfoState(isLoading: $isLoading, filter: $filter, user: $user, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, filter, user, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoStateImplCopyWith<_$UserInfoStateImpl> get copyWith =>
      __$$UserInfoStateImplCopyWithImpl<_$UserInfoStateImpl>(this, _$identity);
}

abstract class _UserInfoState extends UserInfoState {
  const factory _UserInfoState(
      {final bool isLoading,
      final int filter,
      final User? user,
      final String? message,
      final Error? error}) = _$UserInfoStateImpl;
  const _UserInfoState._() : super._();

  @override
  bool get isLoading;
  @override
  int get filter;
  @override
  User? get user;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$UserInfoStateImplCopyWith<_$UserInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
