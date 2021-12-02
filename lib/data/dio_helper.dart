import 'package:dio/dio.dart';
import 'package:salla_shop_app/data/end_points.dart';

class DioHelper {
  static late Dio dio;
  static var postResponse ;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData({
    required String endPoint,
    required Map<String, dynamic> query,
    String lang = 'ar',
    String token = "",
  }) async {
    dio.options.headers = {
      'lang' : lang,
      'Authorization': token
    } ;
    var response =await dio.get(endPoint,queryParameters: query);
    return response;
  }

  static Future<Response> postData({
    required String endpoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    String lang = 'ar',
    String token = "",
  }) async {
    dio.options.headers = {
      'lang' : lang,
      'Authorization': token
    } ;
    var response = await dio.post(endpoint,data: body);
    postResponse = response.data['message'];
    return response;
  }

}
