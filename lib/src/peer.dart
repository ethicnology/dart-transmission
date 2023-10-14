/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `address`            | string     | tr_peer_stat
/// | `clientName`         | string     | tr_peer_stat
/// | `clientIsChoked`     | boolean    | tr_peer_stat
/// | `clientIsInterested` | boolean    | tr_peer_stat
/// | `flagStr`            | string     | tr_peer_stat
/// | `isDownloadingFrom`  | boolean    | tr_peer_stat
/// | `isEncrypted`        | boolean    | tr_peer_stat
/// | `isIncoming`         | boolean    | tr_peer_stat
/// | `isUploadingTo`      | boolean    | tr_peer_stat
/// | `isUTP`              | boolean    | tr_peer_stat
/// | `peerIsChoked`       | boolean    | tr_peer_stat
/// | `peerIsInterested`   | boolean    | tr_peer_stat
/// | `port`               | number     | tr_peer_stat
/// | `progress`           | double     | tr_peer_stat
/// | `rateToClient` (B/s) | number     | tr_peer_stat
/// | `rateToPeer` (B/s)   | number     | tr_peer_stat
class Peer {
  String? address;
  String? clientName;
  bool? clientIsChoked;
  bool? clientIsInterested;
  String? flagStr;
  bool? isDownloadingFrom;
  bool? isEncrypted;
  bool? isIncoming;
  bool? isUploadingTo;
  bool? isUTP;
  bool? peerIsChoked;
  bool? peerIsInterested;
  int? port;
  double? progress;
  int? rateToClient;
  int? rateToPeer;

  Peer({
    this.address,
    this.clientName,
    this.clientIsChoked,
    this.clientIsInterested,
    this.flagStr,
    this.isDownloadingFrom,
    this.isEncrypted,
    this.isIncoming,
    this.isUploadingTo,
    this.isUTP,
    this.peerIsChoked,
    this.peerIsInterested,
    this.port,
    this.progress,
    this.rateToClient,
    this.rateToPeer,
  });

  factory Peer.fromJson(Map<String, dynamic> json) {
    return Peer(
      address: json['address'],
      clientName: json['clientName'],
      clientIsChoked: json['clientIsChoked'],
      clientIsInterested: json['clientIsInterested'],
      flagStr: json['flagStr'],
      isDownloadingFrom: json['isDownloadingFrom'],
      isEncrypted: json['isEncrypted'],
      isIncoming: json['isIncoming'],
      isUploadingTo: json['isUploadingTo'],
      isUTP: json['isUTP'],
      peerIsChoked: json['peerIsChoked'],
      peerIsInterested: json['peerIsInterested'],
      port: json['port'],
      progress: double.parse(json['progress'].toString()),
      rateToClient: json['rateToClient'],
      rateToPeer: json['rateToPeer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'clientName': clientName,
      'clientIsChoked': clientIsChoked,
      'clientIsInterested': clientIsInterested,
      'flagStr': flagStr,
      'isDownloadingFrom': isDownloadingFrom,
      'isEncrypted': isEncrypted,
      'isIncoming': isIncoming,
      'isUploadingTo': isUploadingTo,
      'isUTP': isUTP,
      'peerIsChoked': peerIsChoked,
      'peerIsInterested': peerIsInterested,
      'port': port,
      'progress': progress,
      'rateToClient': rateToClient,
      'rateToPeer': rateToPeer,
    };
  }
}
