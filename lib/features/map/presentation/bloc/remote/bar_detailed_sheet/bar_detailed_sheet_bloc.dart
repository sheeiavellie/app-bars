import 'package:bars/core/resources/data_state.dart';
import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'bar_detailed_sheet_event.dart';
part 'bar_detailed_sheet_state.dart';

class BarDetailedSheetBloc extends Bloc<BarDetailedSheetEvent, BarDetailedSheetState> {

  final GetBarByIDUseCase _getBarByIDUseCase;

  BarDetailedSheetBloc(this._getBarByIDUseCase) : super(const BarDetailedSheetLoading()) {
    on <UpdateBarDetailedSheet> (onUpdateBarDetailedSheet);
  }

  void onUpdateBarDetailedSheet(UpdateBarDetailedSheet event, Emitter<BarDetailedSheetState> emit) async {
    final dataState = await _getBarByIDUseCase(params: event.barId);

    emit(
      const BarDetailedSheetLoading()
    );

    if(dataState is DataSuccess && dataState.data!.id != 0) {
      emit(
        BarDetailedSheetDone(bar: dataState.data!)
      );
    }

    if(dataState is DataFailed) {
      emit(
        BarDetailedSheetException(exception: dataState.error!)
      );
    }
  }
}
