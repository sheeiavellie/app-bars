import 'package:bars/core/resources/data_state.dart';
import 'package:bars/core/usecase/usecase.dart';
import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:bars/features/map/domain/repository/bar_repository.dart';

class GetBarsUseCase implements UseCase<DataState<List<BarEntity>>, void> {
  final BarRepository _barRepository;

  GetBarsUseCase(this._barRepository);
  
  @override
  Future<DataState<List<BarEntity>>> call({void params}) {
    return _barRepository.getBars();
  }
}

class GetBarByIDUseCase implements UseCase<DataState<BarEntity>, int> {
  final BarRepository _barRepository;

  GetBarByIDUseCase(this._barRepository);
  
  @override
  Future<DataState<BarEntity>> call({int? params}) {
    final barId = params;

    return _barRepository.getBarByID(barId!);
  }  
}
