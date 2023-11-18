import 'dart:io';

import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:dio/dio.dart';
import 'package:bars/core/resources/data_state.dart';
import 'package:bars/features/map/data/data_sources/remote/bars_api_service.dart';
import 'package:bars/features/map/data/models/bar.dart';
import 'package:bars/features/map/domain/repository/bar_repository.dart';

class BarRepositoryImpl implements BarRepository {
  final BarsApiService _barsApiService;

  BarRepositoryImpl(this._barsApiService);

  @override
  Future<DataState<List<BarModel>>> getBars() async {
    try {
      final httpResponse = await _barsApiService.getBars();

      if(httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse, 
            requestOptions: httpResponse.response.requestOptions,
          )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }    
  }

  @override
  Future<DataState<BarEntity>> getBarByID(int barId) async {
    try {
      final httpResponse = await _barsApiService.getBarByID(barId: barId);

      if(httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse, 
            requestOptions: httpResponse.response.requestOptions,
          )
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }
}
