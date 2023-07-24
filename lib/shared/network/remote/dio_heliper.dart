import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class diohelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      // //shop app base url
      //  baseUrl: 'https://student.valuxapps.com/api/',

      // news base url
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    @required String? method_url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.get(method_url!, queryParameters: query);
  }

  static Future<Response> PostData({
    @required String? method_url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return dio!.post(
      method_url!,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> PutData({
    @required String? method_url,
    Map<String, dynamic>? query,
    @required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return dio!.put(
      method_url!,
      queryParameters: query,
      data: data,
    );
  }
}
