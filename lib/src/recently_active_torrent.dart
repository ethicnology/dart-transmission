import 'package:transmission/transmission.dart';

class RecentlyActiveTorrent {
  final List<Torrent> torrents;
  final List<int> removed;

  RecentlyActiveTorrent(this.torrents, this.removed);
}
