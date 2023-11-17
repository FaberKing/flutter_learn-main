part of 'data_plane_bloc.dart';

sealed class DataPlaneState extends Equatable {
  const DataPlaneState();

  @override
  List<Object> get props => [];
}

final class DataPlaneInitial extends DataPlaneState {}

final class DataPlaneLoading extends DataPlaneState {}

final class DataPlaneFailed extends DataPlaneState {
  final String e;
  const DataPlaneFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class DataPlaneSuccess extends DataPlaneState {}
