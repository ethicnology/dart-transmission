class TorrentLight {
  final Map<String, dynamic>? _rawData;

  TorrentLight(this._rawData);

  int? get id => _rawData!['id'];

  String? get name => _rawData!['name'];

  String? get hash => _rawData!['hashString'];

  @override
  String toString() {
    return 'TorrentLight{_rawData: $_rawData}';
  }
}
