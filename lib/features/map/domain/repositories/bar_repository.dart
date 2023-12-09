import 'package:bars/core/resources/data_state.dart';
import 'package:bars/features/map/domain/entities/bar.dart';

abstract class BarRepository {

  Future<DataState<List<BarEntity>>> getBars();

  Future<DataState<BarEntity>> getBarByID(int barId);
}
