import 'package:transmission/transmission.dart';
import 'package:dotenv/dotenv.dart';

main() async {
  // fill .env.example and rename it .env
  var env = DotEnv(includePlatformEnvironment: true)..load();
  if (!env.isEveryDefined(['URL', 'USER', 'PASS'])) return;

  // without credentials
  var transmission = Transmission(url: env['URL']!);

  // with basic auth credentials –> use HTTPS or SSH tunnels
  transmission = Transmission(
      url: env['URL']!, username: env['USER']!, password: env['PASS']!);

  const hash = '001d83eb39e7a31a21a4f229524ab484118b0665';

  // get all torrents
  List<Torrent> torrents = await transmission.torrent.get();
  print('torrents: ${torrents.length}');

  // get a specific torrents based on their SHA1 hashString
  torrents = await transmission.torrent.get(ids: <String>[hash]);
  print('torrents: ${torrents.length}');

  // get recently active torrents
  torrents = await transmission.torrent.get(recentlyActive: true);
  print('torrents: ${torrents.length}');

  // start specific torrents
  await transmission.torrent.start(ids: [hash]);
  await transmission.torrent.stop(ids: [hash]);
  await transmission.torrent.verify(ids: [hash]);
  await transmission.torrent.startNow(ids: [hash]);

  // using directly TorrentRequest from transmission.torrent
  TorrentRequest torrent = transmission.torrent;
  await torrent.reannounce(ids: [hash]);

  // I leave the next-ones commented because I'm executing this file
  // as a test on my own server and i don't want to move, rename or remove torrents

  // await torrent.verifyForce(ids: [hash]);
  // await torrent.renamePath(id: 'hash', path: '/path/to', name: 'something');
  // await torrent.move(ids: ['hash'], location: '/path/to', move: false);
  // await torrent.remove(ids: ['hash'], deleteLocalData: false);

  // set a tracker for two torrents
  await torrent.set(
      ids: <String>[hash],
      trackerList: ['udp://public.popcorn-tracker.org:6969/announce']);

  // get session
  var mySession = await transmission.session.get(fields: sessionGetAllFields);
  print(mySession.downloadDir);

  // update session parameters
  mySession.altSpeedEnabled = false;
  await transmission.session.set(mySession);
}
