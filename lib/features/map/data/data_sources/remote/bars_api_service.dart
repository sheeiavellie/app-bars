import 'package:bars/core/constants/constants.dart';
import 'package:bars/features/map/data/models/bar.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'bars_api_service.g.dart';

@RestApi(baseUrl: barsApiBaseUrl)
abstract class BarsApiService {
  factory BarsApiService(Dio dio) = _BarsApiService;

  @GET('/bars')
  Future<HttpResponse<List<BarModel>>> getBars();

  @GET('/bars/{id}')
  Future<HttpResponse<BarModel>> getBarByID({@Path('id') required int barId});
}
