import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lekra/data/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constants.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    try {
      baseUrl = appBaseUrl;
      timeout = const Duration(seconds: 30);
      token = sharedPreferences.getString(AppConstants.token) ?? '';
      if (kDebugMode) {
        log('Token: $token');
        log('BaseUrl: $baseUrl');
      }
      _mainHeaders = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } catch (e) {
      log('******** ${e.toString()} ********+', name: "ERROR AT ApiClient()");
    }
  }

  void updateHeader(String? token) {
    _mainHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        log('====> GetX Call: $uri\nToken: $token');
      }
      Response response = await get(
        uri,
        contentType: contentType,
        query: query,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
      );
      JsonEncoder jsonEncoder = const JsonEncoder();
      checkForUnauthorized(response);
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n');
      return response;
    } catch (e) {
      return Response(statusCode: 1, body: {'message': e.toString()});
    }
  }

  Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
  }) async {
    try {
      if (kDebugMode) {
        log('====> GetX Call: $uri\nToken: $token');
        log('====> GetX Body: ${body is FormData ? body.fields : body}', name: uri);
      }
      Response response = await post(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      JsonEncoder jsonEncoder = const JsonEncoder();
      checkForUnauthorized(response);
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${jsonEncoder.convert(response.body)}');
      log('====> GetX Response: [${response.statusCode}] $uri');

      return response;
    } catch (e) {
      log('$e', name: 'ERROR AT POST');
      return Response(statusCode: 1, body: {'message': e.toString()});
    }
  }

  Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
  }) async {
    try {
      if (kDebugMode) {
        print('====> GetX Call: $uri\nToken: $token');
        print('====> GetX Body: $body');
      }
      Response response = await put(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      return response;
    } catch (e) {
      return Response(statusCode: 1, body: {'message': e.toString()});
    }
  }

  Future<Response> patchData(
    String uri,
    dynamic body, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
    Function(double)? uploadProgress,
  }) async {
    try {
      if (kDebugMode) {
        print('====> GetX Call: $uri\nToken: $token');
        print('====> GetX Body: $body');
      }
      Response response = await patch(
        uri,
        body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      return response;
    } catch (e) {
      return Response(statusCode: 1, body: {'message': e.toString()});
    }
  }

  Future<Response> deleteData(
    String uri, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
  }) async {
    try {
      if (kDebugMode) {
        print('====> GetX Call: $uri\nToken: $token');
      }
      Response response = await delete(
        uri,
        headers: headers ?? _mainHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder,
      );
      response = handleResponse(response);
      log('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      return response;
    } catch (e) {
      return Response(statusCode: 1, body: {'message': e.toString()});
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if (_response.hasError && _response.body == null) {
      log(_response.statusCode.toString(), name: "STATUS CODE");
      _response = const Response(statusCode: 0, body: {'message': 'Connection to API server failed due to internet connection'});
    }
    return _response;
  }

  void checkForUnauthorized(Response response) async {
    if (response.statusCode == 401) {
      Get.find<AuthRepo>().clearSharedData();
      // Navigator.pushAndRemoveUntil(navigatorKey.currentContext!, getCustomRoute(child: const LoginScreen()), (route) => false);
      // showCustomToast(msg: 'Unauthenticated!', toastType: ToastType.error);
    }
  }
}
