import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
abstract class DataState<T> with _$DataState<T> {
  const factory DataState.loading() = DataStateLoading;
  const factory DataState.loaded(List<T> data) = DataStateLoaded;
  const factory DataState.error(Object? e, [StackTrace? stack]) =
      DataStateError;
  const factory DataState.onGoingLoading(List<T> data) = OnGoingLoading;
  const factory DataState.onGoingError(List<T> data, Object? e,
      [StackTrace? stack]) = OnGoingError;
}
