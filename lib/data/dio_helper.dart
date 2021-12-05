import 'package:dio/dio.dart';
import 'package:salla_shop_app/data/end_points.dart';

class DioHelper {
  static late Dio dio;
  static var postResponse ;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
       ));
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = "",
  }) async {
    dio.options.headers = {
      'lang' : lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    } ;
    var response =await dio.get(endPoint);
   // postResponse = response.data['status'];
  //  print('getData Status =>  '+postResponse);
    return response;
  }

  static Future<Response> postData({
    required String endpoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    String lang = 'en',
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
