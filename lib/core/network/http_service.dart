import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {
  final String baseURL;
  final Duration timeOut;
  final Map<String, String> _tokens = {};

  HttpService({required this.baseURL, required this.timeOut});

  Map<String, String> _getHeaders({Map<String, String>? additionalHeaders}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (additionalHeaders != null) {
      final authorizationValue = additionalHeaders['Authorization'];
      if (authorizationValue != null) {
        additionalHeaders['Authorization'] =
            'Bearer ${_getToken(authorizationValue)}';
      }
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  void saveToken(String tokenName, String token) {
    _tokens[tokenName] = token;
  }

  String? _getToken(String tokenName) {
    return _tokens[tokenName];
  }

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseURL$endpoint',
      ).replace(queryParameters: queryParameters);

      final response = await http
          .get(uri, headers: _getHeaders(additionalHeaders: headers))
          .timeout(timeOut);

      return response;
    } catch (e) {
      throw Exception('Ocurrio un error en la peticion GET: $e');
    }
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    String? tokenName,
  }) async {
    try {
      final uri = Uri.parse('$baseURL$endpoint');

      final response = await http
          .post(
            uri,
            headers: _getHeaders(additionalHeaders: headers),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeOut);

      if (tokenName != null) {
        final authorizationValue = response.headers['Authorization'];
        if (authorizationValue != null) {
          _tokens[tokenName] = authorizationValue.split('Bearer ').last;
        }
      }

      return response;
    } catch (e) {
      throw Exception('Ocurrio un error en la peticion POST: $e');
    }
  }

  Future<http.Response> postFormData(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    Map<String, File>? files,
  }) async => _multipartRequest('POST', endpoint, fields: fields, files: files);

  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    try {
      final uri = Uri.parse('$baseURL$endpoint');

      final response = await http.put(
        uri,
        headers: _getHeaders(additionalHeaders: headers),
        body: body != null ? jsonEncode(body) : null,
      );

      return response;
    } catch (e) {
      throw Exception('Ocurrio un error en la peticion PUT: $e');
    }
  }

  Future<http.Response> putFormData(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    Map<String, File>? files,
  }) async => _multipartRequest('PUT', endpoint, fields: fields, files: files);

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseURL$endpoint');

      final response = await http.delete(
        uri,
        headers: _getHeaders(additionalHeaders: headers),
      );

      return response;
    } catch (e) {
      throw Exception('Ocurrio un error en la peticion DELETE: $e');
    }
  }

  Future<http.Response> _multipartRequest(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    Map<String, File>? files,
  }) async {
    try {
      if (fields == null && files == null) {
        throw Exception(
          'Almenos 1 parametro debe contener datos: fields || files',
        );
      }

      final uri = Uri.parse('$baseURL$endpoint');

      final request = http.MultipartRequest(method, uri);

      if (headers != null) {
        request.headers.addAll(headers);
      }

      if (files != null) {
        for (var entry in files.entries) {
          final file = entry.value;
          final fieldName = entry.key;

          request.files.add(
            await http.MultipartFile.fromPath(
              fieldName,
              file.path,
              filename: file.path.split('/').last,
            ),
          );
        }
      }

      final streamedResponse = await request.send().timeout(timeOut);

      final response = await http.Response.fromStream(streamedResponse);

      return response;
    } catch (e) {
      throw Exception('Ocurrio un error en la peticion $method FormData: $e');
    }
  }
}
