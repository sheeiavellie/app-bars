import 'package:bars/features/map/data/data_sources/remote/bars_api_service.dart';
import 'package:bars/features/map/data/repository/bar_repository.dart';
import 'package:bars/features/map/domain/repository/bar_repository.dart';
import 'package:bars/features/map/domain/usecases/get_bar.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton<Dio>(
    Dio()
  );
  
  //Dependencies
  sl.registerSingleton<BarsApiService>(
    BarsApiService(sl())
  );

  sl.registerSingleton<BarRepository>(
    BarRepositoryImpl(sl())
  );

  //UseCases
  sl.registerSingleton<GetBarUseCase>(
    GetBarUseCase(sl())
  );

  //Blocs
  sl.registerFactory<RemoteBarsBloc>(
    () => RemoteBarsBloc(sl())
  );

}
