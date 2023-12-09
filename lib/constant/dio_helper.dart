import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constant/shared_pref.dart';

class dioHelper{

  static Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
        headers: {
          'lang' : 'en',
          'Content-Type' : 'application/json',
          'Authorization' : CacheHelper.getData(key: 'token'),
        }
      ),
    );
  }

  static Future<Response>postData({
    @required String url,
    Map<String , dynamic>data
})async{
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response>postNewData({
    @required String url,
    Map<String , dynamic>data
  })async{
    return await dio.post(
      url,
      data: data,
    );
  }


  static Future<Response>getBanner({
    @required String url,
  })async{
    return await dio.get(
      url,
    );
  }


  static Future<Response>getCategory({
    @required String url,
  })async{
    return await dio.get(
      url,
    );
  }

  static Future<Response>getCategoryProducts({
    @required String url,
    Map<String , dynamic>query
  })async{
    return await dio.get(
      url,
      queryParameters: query
    );
  }

  static Future<Response>getProducts({
    @required String url,
    Map<String , dynamic>query
  })async{
    return await dio.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response>postFav({
    @required String url,
    Map<String , dynamic> data
})async{
    return await dio.post(
    url,
    data: data,
    );
}


  static Future<Response>getFav({
    @required String url,
  })async{
    return await dio.get(
      url,
    );
  }




  static Future<Response>postCart({
    @required String url,
    Map<String , dynamic> data
  })async{
    return await dio.post(
      url,
      data: data,
    );
  }


  static Future<Response>getCart({
    @required String url,
  })async{
    return await dio.get(
      url,
    );
  }

  static Future<Response>postSearch({
  @required url,
    Map<String , dynamic> data
})async{
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response>logOut({
  String url,
    Map<String , dynamic>data
})async{
    return dio.post(
      url,
      data: data,
    );
  }



}
