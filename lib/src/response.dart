import 'package:transmission/transmission.dart';

class TransmissionResponse {
  final String? result;
  final Map<String, dynamic>? arguments;
  final String? tag;

  TransmissionResponse(this.result, {this.arguments, this.tag});

  factory TransmissionResponse.fromJSON(Map<String, dynamic> data) {
    return TransmissionResponse(
      data['result'],
      arguments: data['arguments'],
      tag: data['tag'],
    );
  }

  TransmissionResponse copyWith({String? result}) {
    return TransmissionResponse(result, arguments: arguments, tag: tag);
  }

  bool get isSuccess => result == 'success';
  void check() => !isSuccess ? throw TransmissionException(this) : null;
}
