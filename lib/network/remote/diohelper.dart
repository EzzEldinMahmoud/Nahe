import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:project/models/AUTH MODELS/LOGIN_model.dart';
import 'package:project/network/remote/end_points.dart';
import 'package:project/network/remote/local/cachehelper.dart';
import 'package:project/screens/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/AUTH MODELS/user_info.dart';
import '../../models/errorsmodel/LoginERRORmodel.dart';
import '../../screens/states/loginstates.dart';

class diohelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://nahe.dhulfiqar.com/',
        contentType: 'application/json',
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          if (status == 403) {
            String errorfinallyhere = 'No such user exists';
            StorageUtil.putString('error', errorfinallyhere);
            print("failed to login");
          } else {
            String welcomemessage = 'Welcome';
            StorageUtil.putString('error', welcomemessage);
            print("failed to login");
          }
          return true;
        }));
  }

  static Future<Response?> getData(
      {required String Url,
      required Map<String, dynamic> query,
      required Token}) async {
    diohelper.dio?.options.headers["Authorization"] =
        "token ${StorageUtil.getString('token')}";
    print(Token);
    return await dio?.get(Url, queryParameters: query);
  }

  static Future<Response?> postData(
      {required String Url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      Token}) async {
    diohelper.dio?.options.headers["Authorization"] =
        "token ${StorageUtil.getString('token')}";
    return await dio?.post(Url, queryParameters: query, data: data);
  }
}
