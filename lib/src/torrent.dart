class Torrent {
  final Map<String, dynamic> _rawData;

  Torrent(this._rawData);

  Map<String, dynamic> get rawData => _rawData;

  int? get id => _rawData['id'];

  String? get name => _rawData['name'];

  String? get hash => _rawData['hashString'];

  String? get downloadDir => _rawData['downloadDir'];

  int? get error => _rawData['error'];

  String? get errorString => _rawData['errorString'];

  bool? get isFinished => _rawData['isFinished'];

  bool? get isStalled => _rawData['isStalled'];

  int? get totalSize => _rawData['totalSize'];

  int? get eta => _rawData['eta'];

  int? get status => _rawData['status'];

  String get statusDescription {
    if (error != 0) {
      return 'Error';
    }
    switch (status) {
      case 0:
        return 'Stopped';
      case 1:
        return 'Check waiting';
      case 2:
        return 'Checking';
      case 3:
        return 'Download waiting';
      case 4:
        return 'Downloading';
      case 5:
        return 'Seed waiting';
      case 6:
        return 'Seeding';
    }
    return 'Unkown';
  }

  double? get metadataPercentComplete =>
      _rawData['metadataPercentComplete'] * 100.0;

  int? get sizeWhenDone => _rawData['sizeWhenDone'];

  int? get leftUntilDone => _rawData['leftUntilDone'];

  int? get rateUpload => _rawData['rateUpload'];

  int? get rateDownload => _rawData['rateDownload'];

  String get prettyRateDownload =>
      _prettySize(rateDownload!, decimal: 1) + '/s';

  String get prettyRateUpload => _prettySize(rateUpload!, decimal: 1) + '/s';

  int? get queuePosition => _rawData['queuePosition'];

  double? get percentDone => _rawData['percentDone'] * 100.0;

  bool get isMetadataDownloaded => _rawData['metadataPercentComplete'] == 1;

  int? get peersSendingToUs => _rawData['peersSendingToUs'];

  int? get peersGettingFromUs => _rawData['peersGettingFromUs'];

  int? get peersConnected => _rawData['peersConnected'];

  String get prettyTotalSize {
    return _prettySize(totalSize!);
  }

  String get prettyLeftUntilDone {
    return _prettySize(leftUntilDone!);
  }

  String get prettyCurrentSize {
    return _prettySize(totalSize! - leftUntilDone!);
  }

  String _prettySize(int sizeInOctet, {decimal = 2}) {
    if (sizeInOctet < 1000) {
      return '${sizeInOctet} o';
    } else if (sizeInOctet >= 1000 && sizeInOctet < 1000000) {
      return (sizeInOctet / 1000).toStringAsFixed(decimal) + ' Ko';
    } else if (sizeInOctet >= 1000000 && sizeInOctet < 1000000000) {
      return (sizeInOctet / 1000000).toStringAsFixed(decimal) + ' Mo';
    } else {
      return (sizeInOctet / 1000000000).toStringAsFixed(decimal) + ' Go';
    }
  }

  dynamic operator [](String name) {
    return _rawData[name];
  }

  @override
  String toString() {
    return 'Torrent: $_rawData';
  }
}
