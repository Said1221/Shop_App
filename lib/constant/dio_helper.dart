import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/shared_pref.dart';

class dioHelper{

  static Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response>postData({
    @required String url,
    Map<String , dynamic>data
})async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };

    return await dio.post(
      url,
      data: data,
    );
  }


  static Future<Response>postNewData({
    @required String url,
    Map<String , dynamic>data
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: data,
    );
  }


  static Future<Response>getBanner({
    @required String url,
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
    );
  }



  static Future<Response>getCategory({
    @required String url,
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
    );
  }


  static Future<Response>getCategoryProducts({
    @required String url,
    Map<String , dynamic>query
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query
    );
  }


  static Future<Response>getProducts({
    @required String url,
    Map<String , dynamic>query
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response>postFav({
    @required String url,
    Map<String , dynamic> data
})async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.post(
    url,
    data: data,
    );
}


  static Future<Response>getFav({
    @required String url,
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
    );
  }




  static Future<Response>postCart({
    @required String url,
    Map<String , dynamic> data
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: data,
    );
  }


  static Future<Response>getCart({
    @required String url,
  })async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
    );
  }

  static Future<Response>postSearch({
  @required url,
    Map<String , dynamic> data
})async{

    dio.options.headers =
    {
      'lang':'en',
      'Authorization': CacheHelper.getData(key: 'token'),
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response>logOut({
  String url,
    Map<String , dynamic> data,
})async{

     dio.options.headers =
    {
      'lang':'en',
      'Authorization': 'VX8iROhr86DwheZ7ZHhjzfYe2TUDM85PvKBjOcHhaEnAYXEpsIWHGhZLZ9tTdHUrvd5bPV',
      'Content-Type': 'application/json',
    };
    return dio.post(
      url,
      data : data,
    );
  }



}
