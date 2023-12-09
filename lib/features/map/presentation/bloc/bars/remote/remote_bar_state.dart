import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteBarsState extends Equatable {
  final BarEntity? bar;
  final List<BarEntity> ? bars;
  final DioException ? exception;

  const RemoteBarsState({this.bars, this.bar, this.exception});

  @override
  List<Object?> get props => [bars, bar, exception];
}

class RemoteBarsLoading extends RemoteBarsState {
  const RemoteBarsLoading();
}

class RemoteBarsDone extends RemoteBarsState {
  const RemoteBarsDone(List<BarEntity> bars) : super(bars: bars);
}

class RemoteBarDone extends RemoteBarsState {
  const RemoteBarDone(BarEntity bar) : super(bar: bar);
}

class RemoteBarsException extends RemoteBarsState {
  const RemoteBarsException(DioException exception) : super(exception: exception);
}
