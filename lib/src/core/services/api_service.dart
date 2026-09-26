import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'local_storage_service.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://16.16.220.76:5050/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );

  final LocalStorageService _storage;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
    ),
  );

  ApiService(this._storage) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.accessToken;
          final refreshToken = _storage.refreshToken;
          _logger.i("Token: ${token ?? 'NULL'} | Refresh Token: ${refreshToken ?? 'NULL'}");
          
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          _logRequest(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          _logError(e);

          // ─── 401 UNAUTHORIZED / TOKEN EXPIRED LOGIC ───
          if (e.response?.statusCode == 401) {
            final String? currentRefreshToken = _storage.refreshToken;

            if (currentRefreshToken != null && currentRefreshToken.isNotEmpty) {
              try {
                _logger.w("🔄 [TOKEN] 401 Detected. Attempting to refresh access token...");

                // Use a clean Dio instance to avoid interceptor loops
                final refreshRes = await Dio().post(
                  '${_dio.options.baseUrl}/auth/refresh-token',
                  data: {'refreshToken': currentRefreshToken},
                );

                if (refreshRes.statusCode == 200 &&
                    refreshRes.data['success'] == true) {
                  final String newAccessToken =
                      refreshRes.data['data']['accessToken'];

                  _logger.i("✅ [TOKEN] New access token retrieved. Updating storage.");

                  await _storage.saveTokens(
                    newAccessToken,
                    currentRefreshToken,
                  );

                  // Update the header of the original failed request
                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newAccessToken';

                  // Retry the original request
                  _logger.i("🔁 [RETRY] Retrying original request: ${e.requestOptions.path}");
                  final clonedRequest = await _dio.fetch(e.requestOptions);
                  return handler.resolve(clonedRequest);
                }
              } catch (refreshError) {
                _logger.e("🚨 [TOKEN] Refresh failed or Refresh Token expired. Clearing session.");
                await _storage.clear();
              }
            } else {
              _logger.w("🚨 [TOKEN] No refresh token available. User must login again.");
              await _storage.clear();
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  void _logRequest(RequestOptions o) {
    final callerTrace = _getCallerInfo();
    final StringBuffer logMsg = StringBuffer();
    logMsg.writeln('🚀 [API REQUEST] | ${o.method} | ${o.path}');
    if (callerTrace != null) {
      logMsg.writeln('🔗 Called From: $callerTrace');
    }

    if (o.data != null) {
      if (o.data is FormData) {
        final formData = o.data as FormData;
        logMsg.writeln('📦 [BODY - FormData Fields]:');
        for (var field in formData.fields) {
          logMsg.writeln('   ➤ ${field.key}: ${field.value}');
        }
        logMsg.writeln('📂 [BODY - FormData Files]:');
        for (var file in formData.files) {
          logMsg.writeln('   ➤ ${file.key}: ${file.value.filename}');
        }
      } else {
        logMsg.writeln('📦 [BODY]: ${o.data}');
      }
    } else {
      logMsg.writeln('📦 [BODY]: Empty');
    }
    _logger.i(logMsg.toString());
  }

  void _logResponse(Response r) {
    final callerTrace = _getCallerInfo();
    final StringBuffer logMsg = StringBuffer();
    logMsg.writeln('✅ [API RESPONSE] | ${r.statusCode} | ${r.requestOptions.path}');
    if (callerTrace != null) {
      logMsg.writeln('🔗 Called From: $callerTrace');
    }
    logMsg.writeln('📄 Data: ${r.data}');
    _logger.d(logMsg.toString());
  }

  void _logError(DioException e) {
    final callerTrace = _getCallerInfo();
    final StringBuffer logMsg = StringBuffer();
    logMsg.writeln('❌ [API ERROR] | ${e.response?.statusCode} | ${e.requestOptions.path}');
    if (callerTrace != null) {
      logMsg.writeln('🔗 Called From: $callerTrace');
    }
    logMsg.writeln('💬 Response: ${e.response?.data}');
    _logger.e(logMsg.toString(), error: e.error, stackTrace: e.stackTrace);
  }

  String? _getCallerInfo() {
    try {
      final frames = StackTrace.current.toString().split('\n');
      for (var frame in frames) {
        if (!frame.contains('api_service.dart') &&
            !frame.contains('dio') &&
            !frame.contains('Logger') &&
            frame.trim().isNotEmpty) {
          final match = RegExp(r'#\d+\s+(.+)\s+\((.+)\)').firstMatch(frame);
          if (match != null) {
            return '${match.group(1)} (${match.group(2)})';
          }
          return frame.trim();
        }
      }
    } catch (_) {}
    return null;
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: (options ?? Options()).copyWith(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        options: (options ?? Options()).copyWith(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(
        path,
        data: data,
        options: (options ?? Options()).copyWith(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters, options: options);
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        options: (options ?? Options()).copyWith(
          validateStatus: (status) => status != null && status < 500,
        ),
      );
    } on DioException {
      rethrow;
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return ApiService(localStorage);
});
