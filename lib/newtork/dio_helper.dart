import 'package:dio/dio.dart';

import 'end_points.dart';
class DioHelper
{
   static Dio? dio;
   static init()
  {
   dio= Dio(
     BaseOptions(
       baseUrl: 'http://10.0.2.2/corssphp',
       receiveDataWhenStatusError: true,
     ),
   );

  }
  static Future<Response>getData({
    required String? url ,
     Map<String,dynamic>?query ,
    String lang='en',
    String? token,
  })async
   {
     dio?.options.headers={
       'lang':lang,
        'Content-Type':'application/json',
       'Authorization':token,
     };
     return await dio!.get( url!, queryParameters:query );
   }
   
   static Future<Response>postData({
     required String? url ,
     Map<String,dynamic>?query ,
     required Map<String,dynamic> data,
     String lang='en',
      String? token,
   })async
   {
     dio?.options.headers={
       'lang':lang,
       'Content-Type':'application/json',
       'Authorization':token,
     };
     return await dio!.post(url!,queryParameters:query,data: data);
   }
}


