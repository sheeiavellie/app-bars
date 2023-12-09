part of 'bar_map_objects_bloc.dart';

sealed class BarMapObjectsEvent extends Equatable {
  const BarMapObjectsEvent();

  @override
  List<Object> get props => [];
}

class UpdateBarMapObjects extends BarMapObjectsEvent {
  const UpdateBarMapObjects();
}
