// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_handle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderHandleState {
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderHandleStateCopyWith<OrderHandleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderHandleStateCopyWith<$Res> {
  factory $OrderHandleStateCopyWith(
          OrderHandleState value, $Res Function(OrderHandleState) then) =
      _$OrderHandleStateCopyWithImpl<$Res, OrderHandleState>;
  @useResult
  $Res call({String? message, Error? error});
}

/// @nodoc
class _$OrderHandleStateCopyWithImpl<$Res, $Val extends OrderHandleState>
    implements $OrderHandleStateCopyWith<$Res> {
  _$OrderHandleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$OrderHandleStateImplCopyWith<$Res>
    implements $OrderHandleStateCopyWith<$Res> {
  factory _$$OrderHandleStateImplCopyWith(_$OrderHandleStateImpl value,
          $Res Function(_$OrderHandleStateImpl) then) =
      __$$OrderHandleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, Error? error});
}

/// @nodoc
class __$$OrderHandleStateImplCopyWithImpl<$Res>
    extends _$OrderHandleStateCopyWithImpl<$Res, _$OrderHandleStateImpl>
    implements _$$OrderHandleStateImplCopyWith<$Res> {
  __$$OrderHandleStateImplCopyWithImpl(_$OrderHandleStateImpl _value,
      $Res Function(_$OrderHandleStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$OrderHandleStateImpl(
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

class _$OrderHandleStateImpl extends _OrderHandleState {
  const _$OrderHandleStateImpl({this.message, this.error}) : super._();

  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'OrderHandleState(message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHandleStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHandleStateImplCopyWith<_$OrderHandleStateImpl> get copyWith =>
      __$$OrderHandleStateImplCopyWithImpl<_$OrderHandleStateImpl>(
          this, _$identity);
}

abstract class _OrderHandleState extends OrderHandleState {
  const factory _OrderHandleState({final String? message, final Error? error}) =
      _$OrderHandleStateImpl;
  const _OrderHandleState._() : super._();

  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$OrderHandleStateImplCopyWith<_$OrderHandleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
