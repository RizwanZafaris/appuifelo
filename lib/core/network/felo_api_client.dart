import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'felo_api_client.g.dart';

@RestApi()
abstract class FeloApiClient {
  factory FeloApiClient(Dio dio, {String? baseUrl}) = _FeloApiClient;

  @GET('/health')
  Future<Map<String, dynamic>> health();
}
