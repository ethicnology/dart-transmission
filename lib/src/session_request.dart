import 'package:dio/dio.dart';
import 'package:transmission/transmission.dart';

class SessionRequest {
  final Dio _dio;
  SessionRequest(this._dio);

  Future<Session> get({
    List<String> fields = sessionGetAllFields,
  }) async {
    final results = await _dio.post(
      '/',
      data:
          TransmissionRequest(Method.getSession, arguments: {'fields': fields})
              .toJSON(),
    );
    final response = TransmissionResponse.fromJSON(results.data);
    response.check();
    return Session.fromJson(response.arguments!);
  }

  Future<void> set(Session session) async {
    final results = await _dio.post(
      '/',
      data: TransmissionRequest(
        Method.setSession,
        arguments: session.toJson(),
      ).toJSON(),
    );
    TransmissionResponse.fromJSON(results.data).check();
  }
}
