import 'package:bars/core/resources/data_state.dart';
import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_event.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteBarsBloc extends Bloc<RemoteBarsEvent, RemoteBarsState> {
  
  final GetBarsUseCase _getBarsUseCase;
  final GetBarByIDUseCase _getBarByIDUseCase;

  RemoteBarsBloc(this._getBarsUseCase, this._getBarByIDUseCase) : super(const RemoteBarsLoading()) {
    on <GetBars> (onGetBars);
    on <GetBarByID> (onGetBarByID);
  }

  void onGetBars(GetBars event, Emitter<RemoteBarsState> emit) async {
    final dataState = await _getBarsUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteBarsDone(dataState.data!)
      );
    }

    if(dataState is DataFailed) {
      emit(
        RemoteBarsException(dataState.error!)
      );
    }
  }

  void onGetBarByID(GetBarByID event, Emitter<RemoteBarsState> emit) async {
    final dataState = await _getBarByIDUseCase(params: event.barId);

    if(dataState is DataSuccess && dataState.data!.id != 0) {
      emit(
        RemoteBarDone(dataState.data!)
      );
    }

    if(dataState is DataFailed) {
      emit(
        RemoteBarsException(dataState.error!)
      );
    }
  }
}
