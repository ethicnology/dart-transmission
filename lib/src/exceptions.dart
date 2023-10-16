import 'package:transmission/transmission.dart';

class TransmissionException {
  final TransmissionResponse cause;

  TransmissionException(this.cause);

  @override
  String toString() {
    return 'TransmissionException(${cause.result})';
  }
}

class AddTorrentException extends TransmissionException {
  final TorrentLight torrent;

  AddTorrentException(TransmissionResponse cause, this.torrent) : super(cause);

  @override
  String toString() {
    return 'AddTorrentException(${cause.result}, $torrent)';
  }
}
