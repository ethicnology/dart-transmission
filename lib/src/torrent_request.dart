enum TorrentAction {
  start('torrent-start'),
  startNow('torrent-start-now'),
  stop('torrent-stop'),
  verify('torrent-verify'),
  verifyForce('torrent-verify-force'),
  reannounce('torrent-reannounce'),
  set('torrent-set'),
  get('torrent-get'),
  add('torrent-add'),
  remove('torrent-remove'),
  setLocation('torrent-set-location'),
  renamePath('torrent-rename-path');

  const TorrentAction(this.name);
  final String name;
}

class TorrentRequest {
  final TorrentAction method;
  final Map<String, dynamic>? arguments;
  final String? tag;

  TorrentRequest(this.method, {this.arguments, this.tag});

  Map<String, dynamic> toJSON() {
    return {
      'method': method.name,
      if (arguments != null) 'arguments': arguments,
      if (tag != null) 'tag': tag,
    };
  }
}
