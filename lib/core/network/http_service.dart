import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; // Añade esta dependencia
import 'package:http_parser/http_parser.dart'; // Añade esta dependencia

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
        final formatToken = 'Bearer ${_getToken(authorizationValue)}';
        print('token name: $authorizationValue');
        print('formatted token: $formatToken');
        additionalHeaders['Authorization'] = formatToken;
      }
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  void _saveToken(String tokenName, String token) {
    print('Guardando token: $tokenName -> $token');
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
        final authorizationValue = response.headers['authorization'];
        if (authorizationValue != null) {
          _saveToken(tokenName, authorizationValue.split('Bearer ').last);
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
  }) async => _multipartRequest('POST', endpoint, headers: headers, fields: fields, files: files);

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
  }) async => _multipartRequest('PUT', endpoint, headers: headers, fields: fields, files: files);

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
      
      // Agregar headers (sin Content-Type para multipart)
      if (headers != null) {
        final customHeaders = Map<String, String>.from(headers);
        
        // Formatear token si existe
        final authorizationValue = customHeaders['Authorization'];
        if (authorizationValue != null) {
          final token = _getToken(authorizationValue);
          if (token != null) {
            customHeaders['Authorization'] = 'Bearer $token';
          }
        }
        
        request.headers.addAll(customHeaders);
      }

      // Agregar archivos con contentType correcto
      if (files != null) {
        for (var entry in files.entries) {
          final file = entry.value;
          final fieldName = entry.key;
          final filePath = file.path;
          
          // Detectar el MIME type del archivo
          final mimeType = lookupMimeType(filePath);
          
          print('📎 Agregando archivo:');
          print('  - Campo: $fieldName');
          print('  - Path: $filePath');
          print('  - MIME Type: $mimeType');
          
          if (mimeType == null) {
            throw Exception('No se pudo determinar el tipo MIME del archivo: $filePath');
          }
          
          // Separar el MIME type en tipo y subtipo
          final mimeTypeParts = mimeType.split('/');
          
          request.files.add(
            await http.MultipartFile.fromPath(
              fieldName,
              filePath,
              filename: filePath.split('/').last,
              contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
            ),
          );
        }
      }
      
      // Agregar campos
      if (fields != null) {
        print('📝 Campos form-data: $fields');
        request.fields.addAll(fields);
      }

      print('🚀 Enviando petición $method a: $uri');
      
      final streamedResponse = await request.send().timeout(timeOut);

      final response = await http.Response.fromStream(streamedResponse);
      
      print('📥 Respuesta recibida:');
      print('  - Status: ${response.statusCode}');
      print('  - Body: ${response.body}');

      return response;
    } catch (e) {
      print('❌ Error en petición $method FormData: $e');
      throw Exception('Ocurrio un error en la peticion $method FormData: $e');
    }
  }
}