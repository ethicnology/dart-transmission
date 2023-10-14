/// * On success, a `torrent-added` object in the form of one of 3.3's torrent objects with the fields for `id`, `name`, and `hashString`.
///
/// * When attempting to add a duplicate torrent, a `torrent-duplicate` object in the same form is returned, but the response's `result` value is still `success`.
class TorrentLight {
  int? id;
  String? name;
  String? hashString;

  TorrentLight({this.id, this.name, this.hashString});

  factory TorrentLight.fromJson(Map<String, dynamic> json) {
    return TorrentLight(
      id: json['id'],
      name: json['name'],
      hashString: json['hashString'],
    );
  }
}
