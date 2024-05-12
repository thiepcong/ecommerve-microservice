// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderState {
  List<Address> get addresses => throw _privateConstructorUsedError;
  Address? get currentAddress => throw _privateConstructorUsedError;
  List<Carrier> get carriers => throw _privateConstructorUsedError;
  Carrier? get currentCarrier => throw _privateConstructorUsedError;
  List<CartItemModel> get carts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Error? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderStateCopyWith<OrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
          OrderState value, $Res Function(OrderState) then) =
      _$OrderStateCopyWithImpl<$Res, OrderState>;
  @useResult
  $Res call(
      {List<Address> addresses,
      Address? currentAddress,
      List<Carrier> carriers,
      Carrier? currentCarrier,
      List<CartItemModel> carts,
      bool isLoading,
      String? message,
      Error? error});
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res, $Val extends OrderState>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? currentAddress = freezed,
    Object? carriers = null,
    Object? currentCarrier = freezed,
    Object? carts = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      addresses: null == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      currentAddress: freezed == currentAddress
          ? _value.currentAddress
          : currentAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      carriers: null == carriers
          ? _value.carriers
          : carriers // ignore: cast_nullable_to_non_nullable
              as List<Carrier>,
      currentCarrier: freezed == currentCarrier
          ? _value.currentCarrier
          : currentCarrier // ignore: cast_nullable_to_non_nullable
              as Carrier?,
      carts: null == carts
          ? _value.carts
          : carts // ignore: cast_nullable_to_non_nullable
              as List<CartItemModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$OrderStateImplCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
  factory _$$OrderStateImplCopyWith(
          _$OrderStateImpl value, $Res Function(_$OrderStateImpl) then) =
      __$$OrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Address> addresses,
      Address? currentAddress,
      List<Carrier> carriers,
      Carrier? currentCarrier,
      List<CartItemModel> carts,
      bool isLoading,
      String? message,
      Error? error});
}

/// @nodoc
class __$$OrderStateImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderStateImpl>
    implements _$$OrderStateImplCopyWith<$Res> {
  __$$OrderStateImplCopyWithImpl(
      _$OrderStateImpl _value, $Res Function(_$OrderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? currentAddress = freezed,
    Object? carriers = null,
    Object? currentCarrier = freezed,
    Object? carts = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$OrderStateImpl(
      addresses: null == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      currentAddress: freezed == currentAddress
          ? _value.currentAddress
          : currentAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      carriers: null == carriers
          ? _value._carriers
          : carriers // ignore: cast_nullable_to_non_nullable
              as List<Carrier>,
      currentCarrier: freezed == currentCarrier
          ? _value.currentCarrier
          : currentCarrier // ignore: cast_nullable_to_non_nullable
              as Carrier?,
      carts: null == carts
          ? _value._carts
          : carts // ignore: cast_nullable_to_non_nullable
              as List<CartItemModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$OrderStateImpl extends _OrderState {
  const _$OrderStateImpl(
      {final List<Address> addresses = const [],
      this.currentAddress,
      final List<Carrier> carriers = const [],
      this.currentCarrier,
      final List<CartItemModel> carts = const [],
      this.isLoading = false,
      this.message,
      this.error})
      : _addresses = addresses,
        _carriers = carriers,
        _carts = carts,
        super._();

  final List<Address> _addresses;
  @override
  @JsonKey()
  List<Address> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  @override
  final Address? currentAddress;
  final List<Carrier> _carriers;
  @override
  @JsonKey()
  List<Carrier> get carriers {
    if (_carriers is EqualUnmodifiableListView) return _carriers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_carriers);
  }

  @override
  final Carrier? currentCarrier;
  final List<CartItemModel> _carts;
  @override
  @JsonKey()
  List<CartItemModel> get carts {
    if (_carts is EqualUnmodifiableListView) return _carts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_carts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? message;
  @override
  final Error? error;

  @override
  String toString() {
    return 'OrderState(addresses: $addresses, currentAddress: $currentAddress, carriers: $carriers, currentCarrier: $currentCarrier, carts: $carts, isLoading: $isLoading, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStateImpl &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            (identical(other.currentAddress, currentAddress) ||
                other.currentAddress == currentAddress) &&
            const DeepCollectionEquality().equals(other._carriers, _carriers) &&
            (identical(other.currentCarrier, currentCarrier) ||
                other.currentCarrier == currentCarrier) &&
            const DeepCollectionEquality().equals(other._carts, _carts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_addresses),
      currentAddress,
      const DeepCollectionEquality().hash(_carriers),
      currentCarrier,
      const DeepCollectionEquality().hash(_carts),
      isLoading,
      message,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      __$$OrderStateImplCopyWithImpl<_$OrderStateImpl>(this, _$identity);
}

abstract class _OrderState extends OrderState {
  const factory _OrderState(
      {final List<Address> addresses,
      final Address? currentAddress,
      final List<Carrier> carriers,
      final Carrier? currentCarrier,
      final List<CartItemModel> carts,
      final bool isLoading,
      final String? message,
      final Error? error}) = _$OrderStateImpl;
  const _OrderState._() : super._();

  @override
  List<Address> get addresses;
  @override
  Address? get currentAddress;
  @override
  List<Carrier> get carriers;
  @override
  Carrier? get currentCarrier;
  @override
  List<CartItemModel> get carts;
  @override
  bool get isLoading;
  @override
  String? get message;
  @override
  Error? get error;
  @override
  @JsonKey(ignore: true)
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
