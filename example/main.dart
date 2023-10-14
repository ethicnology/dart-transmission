import 'package:transmission/transmission.dart';

main() async {
  final transmission =
      Transmission(baseUrl: 'http://192.168.1.35:9091/transmission/rpc');

  try {
    final torrents = await transmission.get();
    print(torrents);
  } catch (err) {
    print('can\'t load torrent because of $err');
  }
}
