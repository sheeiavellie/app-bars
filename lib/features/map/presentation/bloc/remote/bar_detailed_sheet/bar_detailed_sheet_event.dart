part of 'bar_detailed_sheet_bloc.dart';

sealed class BarDetailedSheetEvent extends Equatable {
  const BarDetailedSheetEvent();

  @override
  List<Object> get props => [];
}

class UpdateBarDetailedSheet extends BarDetailedSheetEvent {
  final int barId;

  const UpdateBarDetailedSheet({required this.barId});

  @override
  List<Object> get props => [barId];
}
