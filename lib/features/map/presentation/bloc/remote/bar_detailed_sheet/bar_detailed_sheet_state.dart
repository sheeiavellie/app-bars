part of 'bar_detailed_sheet_bloc.dart';

sealed class BarDetailedSheetState extends Equatable {
  const BarDetailedSheetState();
  
  @override
  List<Object?> get props => [];
}

final class BarDetailedSheetLoading extends BarDetailedSheetState {
  const BarDetailedSheetLoading();  
}

class BarDetailedSheetDone extends BarDetailedSheetState {
  final BarEntity ? bar;

  const BarDetailedSheetDone({required this.bar});

  @override
  List<Object?> get props => [bar];
}

class BarDetailedSheetException extends BarDetailedSheetState {
  final DioException ? exception;

  const BarDetailedSheetException({required this.exception});

  @override
  List<Object?> get props => [exception];
}
