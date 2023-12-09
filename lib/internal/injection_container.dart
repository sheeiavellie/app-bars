import 'package:bars/features/map/data/data_sources/remote/bars_api_service.dart';
import 'package:bars/features/map/data/repositories/bar_repository.dart';
import 'package:bars/features/map/data/services/location_service.dart';
import 'package:bars/features/map/domain/repositories/bar_repository.dart';
import 'package:bars/features/map/domain/services/location_service.dart';
import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bars/features/map/presentation/bloc/remote/bar_map_objects/bar_map_objects_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  getIt.registerSingleton<Dio>(
    Dio()
  );
  
  //Dependencies
  getIt.registerSingleton<BarsApiService>(
    BarsApiService(getIt())
  );

  getIt.registerSingleton<BarRepository>(
    BarRepositoryImpl(getIt())
  );

  //UseCases
  getIt.registerSingleton<GetBarsUseCase>(
    GetBarsUseCase(getIt())
  );

  getIt.registerSingleton<GetBarByIDUseCase>(
    GetBarByIDUseCase(getIt())
  );

  //Services
  getIt.registerSingleton<LocationService>(
    LocationServiceImpl()
  );

  //Blocs
  getIt.registerFactory<BarMapObjectsBloc>(
    () => BarMapObjectsBloc(getIt())
  );

}
