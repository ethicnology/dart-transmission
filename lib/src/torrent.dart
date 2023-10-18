import 'package:transmission/transmission.dart';

/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `activityDate` | number | tr_stat
/// | `addedDate` | number | tr_stat
/// | `availability` | array (see below)| tr_torrentAvailability()
/// | `bandwidthPriority` | number | tr_priority_t
/// | `comment` | string | tr_torrent_view
/// | `corruptEver`| number | tr_stat
/// | `creator`| string | tr_torrent_view
/// | `dateCreated`| number| tr_torrent_view
/// | `desiredAvailable`| number| tr_stat
/// | `doneDate`| number | tr_stat
/// | `downloadDir` | string  | tr_torrent
/// | `downloadedEver` | number  | tr_stat
/// | `downloadLimit` | number  | tr_torrent
/// | `downloadLimited` | boolean | tr_torrent
/// | `editDate` | number | tr_stat
/// | `error` | number | tr_stat
/// | `errorString` | string | tr_stat
/// | `eta` | number | tr_stat
/// | `etaIdle` | number | tr_stat
/// | `file-count` | number | tr_info
/// | `files`| array (see below)| n/a
/// | `fileStats`| array (see below)| n/a
/// | `group`| string| n/a
/// | `hashString`| string| tr_torrent_view
/// | `haveUnchecked`| number| tr_stat
/// | `haveValid`| number| tr_stat
/// | `honorsSessionLimits`| boolean| tr_torrent
/// | `id` | number | tr_torrent
/// | `isFinished` | boolean| tr_stat
/// | `isPrivate` | boolean| tr_torrent
/// | `isStalled` | boolean| tr_stat
/// | `labels` | array of strings | tr_torrent
/// | `leftUntilDone` | number| tr_stat
/// | `magnetLink` | string| n/a
/// | `manualAnnounceTime` | number| tr_stat
/// | `maxConnectedPeers` | number| tr_torrent
/// | `metadataPercentComplete` | double| tr_stat
/// | `name` | string| tr_torrent_view
/// | `peer-limit` | number| tr_torrent
/// | `peers` | array (see below)| n/a
/// | `peersConnected` | number| tr_stat
/// | `peersFrom` | object (see below)| n/a
/// | `peersGettingFromUs` | number| tr_stat
/// | `peersSendingToUs` | number| tr_stat
/// | `percentComplete` | double | tr_stat
/// | `percentDone` | double | tr_stat
/// | `pieces` | string (see below)| tr_torrent
/// | `pieceCount`| number| tr_torrent_view
/// | `pieceSize`| number| tr_torrent_view
/// | `priorities`| array (see below)| n/a
/// | `primary-mime-type`| string| tr_torrent
/// | `queuePosition`| number| tr_stat
/// | `rateDownload`| number| tr_stat
/// | `rateUpload`| number| tr_stat
/// | `recheckProgress`| double| tr_stat
/// | `secondsDownloading`| number| tr_stat
/// | `secondsSeeding`| number| tr_stat
/// | `seedIdleLimit`| number| tr_torrent
/// | `seedIdleMode`| number| tr_inactivelimit
/// | `seedRatioLimit`| double| tr_torrent
/// | `seedRatioMode`| number| tr_ratiolimit
/// | `sequentialDownload`| boolean| tr_torrent
/// | `sizeWhenDone`| number| tr_stat
/// | `startDate`| number| tr_stat
/// | `status`| number (see below)| tr_stat
/// | `trackers`| array (see below)| n/a
/// | `trackerList` | string | string of announce URLs, one per line, with a blank line between tiers
/// | `trackerStats`| array (see below)| n/a
/// | `totalSize`| number| tr_torrent_view
/// | `torrentFile`| string| tr_info
/// | `uploadedEver`| number| tr_stat
/// | `uploadLimit`| number| tr_torrent
/// | `uploadLimited`| boolean| tr_torrent
/// | `uploadRatio`| double| tr_stat
/// | `wanted`| array (see below)| n/a
/// | `webseeds`| array of strings | tr_tracker_view
/// | `webseedsSendingToUs`| number| tr_stat
class Torrent {
  int? activityDate;
  int? addedDate;
  List<int>? availability;
  int? bandwidthPriority;
  String? comment;
  int? corruptEver;
  String? creator;
  int? dateCreated;
  int? desiredAvailable;
  int? doneDate;
  String? downloadDir;
  int? downloadedEver;
  int? downloadLimit;
  bool? downloadLimited;
  int? editDate;
  int? error;
  String? errorString;
  int? eta;
  int? etaIdle;
  int? fileCount;
  List<File>? files;
  List<FileStats>? fileStats;
  String? group;
  String? hash;
  int? haveUnchecked;
  int? haveValid;
  bool? honorsSessionLimits;
  int? id;
  bool? isFinished;
  bool? isPrivate;
  bool? isStalled;
  List<String>? labels;
  int? leftUntilDone;
  String? magnetLink;
  int? manualAnnounceTime;
  int? maxConnectedPeers;
  double? metadataPercentComplete;
  String? name;
  int? peerLimit;
  List<Peer>? peers;
  int? peersConnected;
  PeersFrom? peersFrom;
  int? peersGettingFromUs;
  int? peersSendingToUs;
  double? percentComplete;
  double? percentDone;
  String? pieces;
  int? pieceCount;
  int? pieceSize;
  List<int>? priorities;
  String? primaryMimeType;
  int? queuePosition;
  int? rateDownload;
  int? rateUpload;
  double? recheckProgress;
  int? secondsDownloading;
  int? secondsSeeding;
  int? seedIdleLimit;
  int? seedIdleMode;
  double? seedRatioLimit;
  int? seedRatioMode;
  bool? sequentialDownload;
  int? sizeWhenDone;
  int? startDate;
  Status? status;
  List<Tracker>? trackers;
  List<String>? trackerList;
  List<TrackerStats>? trackerStats;
  int? totalSize;
  String? torrentFile;
  int? uploadedEver;
  int? uploadLimit;
  bool? uploadLimited;
  double? uploadRatio;
  List<int>? wanted;
  List<String>? webseeds;
  int? webseedsSendingToUs;

  Torrent();

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent()
      ..activityDate = json['activityDate']
      ..addedDate = json['addedDate']
      ..availability = List<int>.from(json['availability'] ?? [])
      ..bandwidthPriority = json['bandwidthPriority']
      ..comment = json['comment']
      ..corruptEver = json['corruptEver']
      ..creator = json['creator']
      ..dateCreated = json['dateCreated']
      ..desiredAvailable = json['desiredAvailable']
      ..doneDate = json['doneDate']
      ..downloadDir = json['downloadDir']
      ..downloadedEver = json['downloadedEver']
      ..downloadLimit = json['downloadLimit']
      ..downloadLimited = json['downloadLimited']
      ..editDate = json['editDate']
      ..error = json['error']
      ..errorString = json['errorString']
      ..eta = json['eta']
      ..etaIdle = json['etaIdle']
      ..fileCount = json['file-count']
      ..files = List<File>.from(
        (json['files'] ?? []).map((file) => File.fromJson(file)),
      )
      ..fileStats = List<FileStats>.from(
        (json['fileStats'] ?? [])
            .map((fileStat) => FileStats.fromJson(fileStat)),
      )
      ..group = json['group']
      ..hash = json['hashString']
      ..haveUnchecked = json['haveUnchecked']
      ..haveValid = json['haveValid']
      ..honorsSessionLimits = json['honorsSessionLimits']
      ..id = json['id']
      ..isFinished = json['isFinished']
      ..isPrivate = json['isPrivate']
      ..isStalled = json['isStalled']
      ..labels = List<String>.from(json['labels'] ?? [])
      ..leftUntilDone = json['leftUntilDone']
      ..magnetLink = json['magnetLink']
      ..manualAnnounceTime = json['manualAnnounceTime']
      ..maxConnectedPeers = json['maxConnectedPeers']
      ..metadataPercentComplete =
          double.tryParse(json['metadataPercentComplete'].toString())
      ..name = json['name']
      ..peerLimit = json['peer-limit']
      ..peers = List<Peer>.from(
        (json['peers'] ?? []).map((peer) => Peer.fromJson(peer)),
      )
      ..peersConnected = json['peersConnected']
      ..peersFrom = PeersFrom.fromJson(json['peersFrom'] ?? {})
      ..peersGettingFromUs = json['peersGettingFromUs']
      ..peersSendingToUs = json['peersSendingToUs']
      ..percentComplete = double.tryParse(json['percentComplete'].toString())
      ..percentDone = double.tryParse(json['percentDone'].toString())
      ..pieces = json['pieces']
      ..pieceCount = json['pieceCount']
      ..pieceSize = json['pieceSize']
      ..priorities = List<int>.from(json['priorities'] ?? [])
      ..primaryMimeType = json['primary-mime-type']
      ..queuePosition = json['queuePosition']
      ..rateDownload = json['rateDownload']
      ..rateUpload = json['rateUpload']
      ..recheckProgress = double.tryParse(json['recheckProgress'].toString())
      ..secondsDownloading = json['secondsDownloading']
      ..secondsSeeding = json['secondsSeeding']
      ..seedIdleLimit = json['seedIdleLimit']
      ..seedIdleMode = json['seedIdleMode']
      ..seedRatioLimit = double.tryParse(json['seedRatioLimit'].toString())
      ..seedRatioMode = json['seedRatioMode']
      ..sequentialDownload = json['sequentialDownload']
      ..sizeWhenDone = json['sizeWhenDone']
      ..startDate = json['startDate']
      ..status = Status.fromCode(json['status'])
      ..trackers = List<Tracker>.from(
        (json['trackers'] ?? []).map((tracker) => Tracker.fromJson(tracker)),
      )
      ..trackerList = json['trackerList'].split('\n\n')
      ..trackerStats = List<TrackerStats>.from(
        (json['trackerStats'] ?? [])
            .map((trackerStats) => TrackerStats.fromJson(trackerStats)),
      )
      ..totalSize = json['totalSize']
      ..torrentFile = json['torrentFile']
      ..uploadedEver = json['uploadedEver']
      ..uploadLimit = json['uploadLimit']
      ..uploadLimited = json['uploadLimited']
      ..uploadRatio = double.tryParse(json['uploadRatio'].toString())
      ..wanted = List<int>.from(json['wanted'] ?? [])
      ..webseeds = List<String>.from(json['webseeds'] ?? [])
      ..webseedsSendingToUs = json['webseedsSendingToUs'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'activityDate': activityDate,
      'addedDate': addedDate,
      'availability': availability,
      'bandwidthPriority': bandwidthPriority,
      'comment': comment,
      'corruptEver': corruptEver,
      'creator': creator,
      'dateCreated': dateCreated,
      'desiredAvailable': desiredAvailable,
      'doneDate': doneDate,
      'downloadDir': downloadDir,
      'downloadedEver': downloadedEver,
      'downloadLimit': downloadLimit,
      'downloadLimited': downloadLimited,
      'editDate': editDate,
      'error': error,
      'errorString': errorString,
      'eta': eta,
      'etaIdle': etaIdle,
      'file-count': fileCount,
      'files': files?.map((file) => file.toJson()).toList(),
      'fileStats': fileStats?.map((fileStat) => fileStat.toJson()).toList(),
      'group': group,
      'hashString': hash,
      'haveUnchecked': haveUnchecked,
      'haveValid': haveValid,
      'honorsSessionLimits': honorsSessionLimits,
      'id': id,
      'isFinished': isFinished,
      'isPrivate': isPrivate,
      'isStalled': isStalled,
      'labels': labels,
      'leftUntilDone': leftUntilDone,
      'magnetLink': magnetLink,
      'manualAnnounceTime': manualAnnounceTime,
      'maxConnectedPeers': maxConnectedPeers,
      'metadataPercentComplete': metadataPercentComplete,
      'name': name,
      'peer-limit': peerLimit,
      'peers': peers?.map((peer) => peer.toJson()).toList(),
      'peersConnected': peersConnected,
      'peersFrom': peersFrom?.toJson(),
      'peersGettingFromUs': peersGettingFromUs,
      'peersSendingToUs': peersSendingToUs,
      'percentComplete': percentComplete,
      'percentDone': percentDone,
      'pieces': pieces,
      'pieceCount': pieceCount,
      'pieceSize': pieceSize,
      'priorities': priorities,
      'primary-mime-type': primaryMimeType,
      'queuePosition': queuePosition,
      'rateDownload': rateDownload,
      'rateUpload': rateUpload,
      'recheckProgress': recheckProgress,
      'secondsDownloading': secondsDownloading,
      'secondsSeeding': secondsSeeding,
      'seedIdleLimit': seedIdleLimit,
      'seedIdleMode': seedIdleMode,
      'seedRatioLimit': seedRatioLimit,
      'seedRatioMode': seedRatioMode,
      'sequentialDownload': sequentialDownload,
      'sizeWhenDone': sizeWhenDone,
      'startDate': startDate,
      'status': status?.code,
      'trackers': trackers?.map((tracker) => tracker.toJson()).toList(),
      'trackerList': trackerList?.join('\n\n'),
      'trackerStats':
          trackerStats?.map((trackerStats) => trackerStats.toJson()).toList(),
      'totalSize': totalSize,
      'torrentFile': torrentFile,
      'uploadedEver': uploadedEver,
      'uploadLimit': uploadLimit,
      'uploadLimited': uploadLimited,
      'uploadRatio': uploadRatio,
      'wanted': wanted,
      'webseeds': webseeds,
      'webseedsSendingToUs': webseedsSendingToUs,
    };
  }

  String? get prettyRateDownload => _prettySize(rateDownload);
  String? get prettyRateUpload => _prettySize(rateUpload);
  String? get prettyTotalSize => _prettySize(totalSize);
  String? get prettyLeftUntilDone => _prettySize(leftUntilDone);
  String? _prettySize(int? bytes, {decimal = 2}) {
    if (bytes == null) return null;
    if (bytes < 1000) {
      return '$bytes B';
    } else if (bytes >= 1000 && bytes < 1000000) {
      return '${(bytes / 1000).toStringAsFixed(decimal)} Kb';
    } else if (bytes >= 1000000 && bytes < 1000000000) {
      return '${(bytes / 1000000).toStringAsFixed(decimal)} Mb';
    } else {
      return '${(bytes / 1000000000).toStringAsFixed(decimal)} Gb';
    }
  }
}
