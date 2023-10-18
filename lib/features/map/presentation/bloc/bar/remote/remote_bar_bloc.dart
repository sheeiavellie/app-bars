import 'package:bars/core/resources/data_state.dart';
import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_event.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteBarsBloc extends Bloc<RemoteBarsEvent, RemoteBarsState> {
  
  final GetBarUseCase _getBarUseCase;
  RemoteBarsBloc(this._getBarUseCase) : super(const RemoteBarsLoading()) {
    on <GetBars> (onGetBars);
  }

  void onGetBars(GetBars event, Emitter<RemoteBarsState> emit) async {
    final dataState = await _getBarUseCase();

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
}
