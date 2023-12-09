import 'package:bars/core/resources/data_state.dart';
import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'bar_map_objects_event.dart';
part 'bar_map_objects_state.dart';

class BarMapObjectsBloc extends Bloc<BarMapObjectsEvent, BarMapObjectsState> {
  
  final GetBarsUseCase _getBarsUseCase;

  BarMapObjectsBloc(this._getBarsUseCase) : super(const BarMapObjectsLoading()) {
    on <GetBarMapObjects> (onGetBars);
  }

  void onGetBars(GetBarMapObjects event, Emitter<BarMapObjectsState> emit) async {
    final dataState = await _getBarsUseCase();

    emit(
      const BarMapObjectsLoading()
    );

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        BarMapObjectsDone(bars: dataState.data!)
      );
    }

    if(dataState is DataFailed) {
      emit(
        BarMapObjectsException(exception: dataState.error!)
      );
    }
  }
}
