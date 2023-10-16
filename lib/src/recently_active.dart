import 'package:transmission/transmission.dart';

class RecentlyActive {
  final List<Torrent> torrents;
  final List<int> removed;

  RecentlyActive(this.torrents, this.removed);
}
