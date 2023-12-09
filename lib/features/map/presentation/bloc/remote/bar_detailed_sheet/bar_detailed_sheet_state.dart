part of 'bar_detailed_sheet_bloc.dart';

sealed class BarDetailedSheetState extends Equatable {
  const BarDetailedSheetState();
  
  @override
  List<Object> get props => [];
}

final class BarDetailedSheetInitial extends BarDetailedSheetState {}
