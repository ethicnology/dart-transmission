import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:transmission/transmission.dart';

const csrfProtectionHeader = 'X-Transmission-Session-Id';
const basicAuthentication = 'Authorization';
const proxyBasicAuthentication = 'Proxy-Authorization';

extension RequestOptionsExtension on RequestOptions {
  Options toOptions() {
    return Options(
      responseType: responseType,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      contentType: contentType,
      extra: extra,
      followRedirects: followRedirects,
      headers: headers,
      listFormat: listFormat,
      maxRedirects: maxRedirects,
      method: method,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      validateStatus: validateStatus,
    );
  }
}

/// Transmission object to interact with a remote instance
/// Documentation about the API at https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md
class Transmission {
  final bool _log;
  final Dio _dio;
  final Dio _token = Dio();
  late TorrentRequest torrent;
  late SessionRequest session;

  Transmission._private(this._dio, this._log) {
    _token.options = _dio.options;
    String? csrfToken;
    if (_log) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      if (csrfToken != null) {
        options.headers[csrfProtectionHeader] = csrfToken;
      }
      handler.next(options);
    }, onError: (DioException error, handler) async {
      if (error.response?.statusCode == 409) {
        // _dio.lock();
        final options = error.requestOptions;
        // If the _token has been updated, repeat directly.
        if (csrfToken != options.headers[csrfProtectionHeader]) {
          options.headers[csrfProtectionHeader] = csrfToken;
        } else {
          csrfToken = error.response!.headers[csrfProtectionHeader]!.first;
          options.headers[csrfProtectionHeader] = csrfToken;
        }
        //repeat
        try {
          final response = await _token.request(
            options.path,
            options: options.toOptions(),
            data: options.data,
            cancelToken: options.cancelToken,
            onReceiveProgress: options.onReceiveProgress,
            onSendProgress: options.onSendProgress,
            queryParameters: options.queryParameters,
          );
          // _dio.unlock();
          handler.resolve(response);
        } on DioException catch (err) {
          // _dio.unlock();
          handler.reject(err);
        } catch (err) {
          print(err);
          // _dio.unlock();
          handler.reject(error);
        }
        return;
      }
      handler.next(error);
    }));
    torrent = TorrentRequest(_dio);
    session = SessionRequest(_dio);
  }

  /// Documentation about the API at https://github.com/transmission/transmission/blob/master/extras/rpc-spec.txt
  /// [url] url of the transmission server instance, default to http://localhost:9091/transmission/rpc
  /// [proxyUrl] url use as a proxy, urls will be added at the end before request, default to null
  /// [log] boolean to show http logs or not
  factory Transmission({
    String url = 'http://localhost:9091',
    String username = '',
    String password = '',
    String proxyUrl = '',
    bool log = false,
  }) {
    url = '$url/transmission/rpc';

    Dio client = Dio(
      BaseOptions(
        baseUrl: proxyUrl.isEmpty ? url : proxyUrl + Uri.encodeComponent(url),
      ),
    );
    if (username.isNotEmpty && password.isNotEmpty) {
      String auth = base64.encode(utf8.encode('$username:$password'));
      if (!url.startsWith('https')) {
        print('''
Transmission Basic Authentication is UNSECURE using HTTP, consider HTTPS
        ''');
      }

      if (proxyUrl.isNotEmpty) {
        client.options.headers[proxyBasicAuthentication] = 'Basic $auth';
      } else {
        client.options.headers[basicAuthentication] = 'Basic $auth';
      }
    }

    return Transmission._private(client, log);
  }

  /// close all connexions
  void dispose() {
    _dio.close();
    _token.close();
  }
}
