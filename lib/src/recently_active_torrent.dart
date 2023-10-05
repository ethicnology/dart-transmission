import 'package:transmission/src/torrent.dart';

class RecentlyActiveTorrent {
  final List<Torrent>? torrents;
  final List<int>? removed;

  RecentlyActiveTorrent(this.torrents, this.removed);

  @override
  String toString() {
    return 'RecentlyActiveTorrent{torrents: $torrents, removed: $removed}';
  }
}
