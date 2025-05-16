// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_jadwal_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddJadwalEvent {
  AddJadwalRequestModel get request => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddJadwalRequestModel request) addJadwal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddJadwalRequestModel request)? addJadwal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddJadwalRequestModel request)? addJadwal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddJadwal value) addJadwal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddJadwal value)? addJadwal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddJadwal value)? addJadwal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddJadwalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddJadwalEventCopyWith<AddJadwalEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddJadwalEventCopyWith<$Res> {
  factory $AddJadwalEventCopyWith(
          AddJadwalEvent value, $Res Function(AddJadwalEvent) then) =
      _$AddJadwalEventCopyWithImpl<$Res, AddJadwalEvent>;
  @useResult
  $Res call({AddJadwalRequestModel request});
}

/// @nodoc
class _$AddJadwalEventCopyWithImpl<$Res, $Val extends AddJadwalEvent>
    implements $AddJadwalEventCopyWith<$Res> {
  _$AddJadwalEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddJadwalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
  }) {
    return _then(_value.copyWith(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as AddJadwalRequestModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddJadwalImplCopyWith<$Res>
    implements $AddJadwalEventCopyWith<$Res> {
  factory _$$AddJadwalImplCopyWith(
          _$AddJadwalImpl value, $Res Function(_$AddJadwalImpl) then) =
      __$$AddJadwalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddJadwalRequestModel request});
}

/// @nodoc
class __$$AddJadwalImplCopyWithImpl<$Res>
    extends _$AddJadwalEventCopyWithImpl<$Res, _$AddJadwalImpl>
    implements _$$AddJadwalImplCopyWith<$Res> {
  __$$AddJadwalImplCopyWithImpl(
      _$AddJadwalImpl _value, $Res Function(_$AddJadwalImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddJadwalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
  }) {
    return _then(_$AddJadwalImpl(
      null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as AddJadwalRequestModel,
    ));
  }
}

/// @nodoc

class _$AddJadwalImpl implements _AddJadwal {
  const _$AddJadwalImpl(this.request);

  @override
  final AddJadwalRequestModel request;

  @override
  String toString() {
    return 'AddJadwalEvent.addJadwal(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddJadwalImpl &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  /// Create a copy of AddJadwalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddJadwalImplCopyWith<_$AddJadwalImpl> get copyWith =>
      __$$AddJadwalImplCopyWithImpl<_$AddJadwalImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddJadwalRequestModel request) addJadwal,
  }) {
    return addJadwal(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddJadwalRequestModel request)? addJadwal,
  }) {
    return addJadwal?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddJadwalRequestModel request)? addJadwal,
    required TResult orElse(),
  }) {
    if (addJadwal != null) {
      return addJadwal(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddJadwal value) addJadwal,
  }) {
    return addJadwal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddJadwal value)? addJadwal,
  }) {
    return addJadwal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddJadwal value)? addJadwal,
    required TResult orElse(),
  }) {
    if (addJadwal != null) {
      return addJadwal(this);
    }
    return orElse();
  }
}

abstract class _AddJadwal implements AddJadwalEvent {
  const factory _AddJadwal(final AddJadwalRequestModel request) =
      _$AddJadwalImpl;

  @override
  AddJadwalRequestModel get request;

  /// Create a copy of AddJadwalEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddJadwalImplCopyWith<_$AddJadwalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddJadwalState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SuccessAddJadwalResponseModel addJadwalResponseSuccess)
        success,
    required TResult Function(
            ErrorAddJadwalResponseModel addJadwalResponseError)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult? Function(ErrorAddJadwalResponseModel addJadwalResponseError)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult Function(ErrorAddJadwalResponseModel addJadwalResponseError)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddJadwalStateCopyWith<$Res> {
  factory $AddJadwalStateCopyWith(
          AddJadwalState value, $Res Function(AddJadwalState) then) =
      _$AddJadwalStateCopyWithImpl<$Res, AddJadwalState>;
}

/// @nodoc
class _$AddJadwalStateCopyWithImpl<$Res, $Val extends AddJadwalState>
    implements $AddJadwalStateCopyWith<$Res> {
  _$AddJadwalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AddJadwalStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AddJadwalState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SuccessAddJadwalResponseModel addJadwalResponseSuccess)
        success,
    required TResult Function(
            ErrorAddJadwalResponseModel addJadwalResponseError)
        error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult? Function(ErrorAddJadwalResponseModel addJadwalResponseError)?
        error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult Function(ErrorAddJadwalResponseModel addJadwalResponseError)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AddJadwalState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AddJadwalStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AddJadwalState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SuccessAddJadwalResponseModel addJadwalResponseSuccess)
        success,
    required TResult Function(
            ErrorAddJadwalResponseModel addJadwalResponseError)
        error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult? Function(ErrorAddJadwalResponseModel addJadwalResponseError)?
        error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult Function(ErrorAddJadwalResponseModel addJadwalResponseError)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AddJadwalState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SuccessAddJadwalResponseModel addJadwalResponseSuccess});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AddJadwalStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addJadwalResponseSuccess = null,
  }) {
    return _then(_$SuccessImpl(
      null == addJadwalResponseSuccess
          ? _value.addJadwalResponseSuccess
          : addJadwalResponseSuccess // ignore: cast_nullable_to_non_nullable
              as SuccessAddJadwalResponseModel,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.addJadwalResponseSuccess);

  @override
  final SuccessAddJadwalResponseModel addJadwalResponseSuccess;

  @override
  String toString() {
    return 'AddJadwalState.success(addJadwalResponseSuccess: $addJadwalResponseSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(
                    other.addJadwalResponseSuccess, addJadwalResponseSuccess) ||
                other.addJadwalResponseSuccess == addJadwalResponseSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addJadwalResponseSuccess);

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SuccessAddJadwalResponseModel addJadwalResponseSuccess)
        success,
    required TResult Function(
            ErrorAddJadwalResponseModel addJadwalResponseError)
        error,
  }) {
    return success(addJadwalResponseSuccess);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult? Function(ErrorAddJadwalResponseModel addJadwalResponseError)?
        error,
  }) {
    return success?.call(addJadwalResponseSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult Function(ErrorAddJadwalResponseModel addJadwalResponseError)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(addJadwalResponseSuccess);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements AddJadwalState {
  const factory _Success(
          final SuccessAddJadwalResponseModel addJadwalResponseSuccess) =
      _$SuccessImpl;

  SuccessAddJadwalResponseModel get addJadwalResponseSuccess;

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorAddJadwalResponseModel addJadwalResponseError});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AddJadwalStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addJadwalResponseError = null,
  }) {
    return _then(_$ErrorImpl(
      null == addJadwalResponseError
          ? _value.addJadwalResponseError
          : addJadwalResponseError // ignore: cast_nullable_to_non_nullable
              as ErrorAddJadwalResponseModel,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.addJadwalResponseError);

  @override
  final ErrorAddJadwalResponseModel addJadwalResponseError;

  @override
  String toString() {
    return 'AddJadwalState.error(addJadwalResponseError: $addJadwalResponseError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.addJadwalResponseError, addJadwalResponseError) ||
                other.addJadwalResponseError == addJadwalResponseError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addJadwalResponseError);

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SuccessAddJadwalResponseModel addJadwalResponseSuccess)
        success,
    required TResult Function(
            ErrorAddJadwalResponseModel addJadwalResponseError)
        error,
  }) {
    return error(addJadwalResponseError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult? Function(ErrorAddJadwalResponseModel addJadwalResponseError)?
        error,
  }) {
    return error?.call(addJadwalResponseError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SuccessAddJadwalResponseModel addJadwalResponseSuccess)?
        success,
    TResult Function(ErrorAddJadwalResponseModel addJadwalResponseError)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(addJadwalResponseError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AddJadwalState {
  const factory _Error(
      final ErrorAddJadwalResponseModel addJadwalResponseError) = _$ErrorImpl;

  ErrorAddJadwalResponseModel get addJadwalResponseError;

  /// Create a copy of AddJadwalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
