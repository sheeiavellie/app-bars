part of 'bar_map_objects_bloc.dart';

sealed class BarMapObjectsState extends Equatable {  

  const BarMapObjectsState();

  @override
  List<Object?> get props => [];
}

class BarMapObjectsLoading extends BarMapObjectsState {
  const BarMapObjectsLoading();
}

class BarMapObjectsDone extends BarMapObjectsState {
  final List<BarEntity> ? bars;

  const BarMapObjectsDone({required this.bars});

  @override
  List<Object?> get props => [bars];
}

class BarMapObjectsException extends BarMapObjectsState {
  final DioException ? exception;

  const BarMapObjectsException({required this.exception});

  @override
  List<Object?> get props => [exception];
}
