part of 'data_plane_bloc.dart';

sealed class DataPlaneEvent extends Equatable {
  const DataPlaneEvent();

  @override
  List<Object> get props => [];
}

class DataPlanPost extends DataPlaneEvent {
  final DataPlanFormModel data;
  const DataPlanPost(this.data);

  @override
  List<Object> get props => [data];
}
