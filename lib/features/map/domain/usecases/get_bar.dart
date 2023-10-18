import 'package:bars/core/resources/data_state.dart';
import 'package:bars/core/usecase/usecase.dart';
import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:bars/features/map/domain/repository/bar_repository.dart';

class GetBarUseCase implements UseCase<DataState<List<BarEntity>>, void> {
  final BarRepository _barRepository;

  GetBarUseCase(this._barRepository);
  
  @override
  Future<DataState<List<BarEntity>>> call({void params}) {
    return _barRepository.getBars();
  }
}
