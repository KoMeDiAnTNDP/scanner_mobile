import 'dart:io';
import 'package:dio/dio.dart';

import '../../models/models.dart' as models;
import '../../models/http/models.dart' as http_models;

enum HttpMethod {
  GET,
  POST,
}

class HttpService {
  static const _protocol = 'http';
  static const _host = '127.0.0.1:5000';

  static final HttpService _httpService = HttpService._internal();

  late final Dio _dio;
  String? _token;

  factory HttpService() {
    return _httpService;
  }

  HttpService._internal({String? token}) {
    _dio = _createDioClient(token: token);
  }

  static const Map<String, String> _defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  static Map<String, String> _authHeaders(String token) => {
    'Authorization': 'Bearer $token'
  };

  Dio _createDioClient({String? token}) {
    BaseOptions options = BaseOptions(
      baseUrl: '$_protocol://$_host',
      connectTimeout: 5000,
      // receiveTimeout: 3000,
      headers: _defaultHeaders,
    );

    if (token != null) {
      options.headers = {...options.headers, ..._authHeaders(token)};
    }

    return Dio(options);
  }

  Future<http_models.BaseResponse<T>> makeRequest<T>(
      HttpMethod method,
      String path, {
        String? token,
        Map<String, String>? body,
        Map<String, dynamic>? params,
        bool isMultipart = false,
        List<models.File>? files,
        bool advance = false
      }) async {
    Response response;

    switch (method) {
      case HttpMethod.GET:
        response = await _makeGetRequest(path, params: params);
        break;
      case HttpMethod.POST:
        response = await _makePostRequest(
            path,
            body: body,
            multipart: isMultipart,
            files: files,
            advance: advance,
        );
    }

    Map<String, dynamic> json = {
      'status': response.statusCode,
    };

    if (response.statusCode != HttpStatus.ok) {
      json['error'] = response.data as String;

      return http_models.BaseResponse<String>.fromJson(json) as http_models.BaseResponse<T>;
    }

    json['data'] = response.data;

    return http_models.BaseResponse<T>.fromJson(json);
  }

  void setToken(String? token) {
    if (token == null) {
      _token = token;
      return;
    }

    _dio.options.headers = {..._dio.options.headers, ..._authHeaders(token)};
    _token = token;
  }

  Future<Response> _makeGetRequest(
      String path, {
        Map<String, dynamic>? params
      }) async {
    Response response = await _dio.get(path, queryParameters: params);

    return response;
  }

  Future<Response> _sendMultipartData(String path, List<models.File> files, bool advance) async {
    List<MultipartFile> multipartFiles = files
        .map((models.File file) => MultipartFile.fromFileSync(file.path, filename: file.name))
        .toList();
    Map<String, dynamic> mapData = {
      'files': multipartFiles
    };

    if (advance) {
      mapData['advance'] = advance.toString();
    }

    FormData data = FormData.fromMap(mapData);
    
    return await _dio.post(path, data: data);
  }

  Future<Response> _makePostRequest(
      String path,
      {
        Map<String, dynamic>? body,
        bool multipart = false,
        List<models.File>? files,
        bool advance = false,
      }) async {
    if (multipart && files != null) {
      return await _sendMultipartData(path, files, advance);
    }

    return await _dio.post(path, data: body);
  }
}
