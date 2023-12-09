import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bar_detailed_sheet_event.dart';
part 'bar_detailed_sheet_state.dart';

class BarDetailedSheetBloc extends Bloc<BarDetailedSheetEvent, BarDetailedSheetState> {

  final GetBarByIDUseCase _getBarByIDUseCase;

  BarDetailedSheetBloc(this._getBarByIDUseCase) : super(BarDetailedSheetInitial()) {
    //on <GetBarByID> (onGetBarByID);
  }

  // void onGetBarByID(GetBarByID event, Emitter<RemoteBarsState> emit) async {
  //   final dataState = await _getBarByIDUseCase(params: event.barId);

  //   if(dataState is DataSuccess && dataState.data!.id != 0) {
  //     emit(
  //       RemoteBarDone(dataState.data!)
  //     );
  //   }

  //   if(dataState is DataFailed) {
  //     emit(
  //       RemoteBarsException(dataState.error!)
  //     );
  //   }
  // }
}
