import 'package:dio/dio.dart';
import 'package:transmission/transmission.dart';

class TorrentRequest {
  final Dio _dio;
  TorrentRequest(this._dio);

  /// Sets various properties for a torrent.
  ///
  /// [arguments]: A map of arguments with keys representing the property names and values as follows:
  ///
  /// - "bandwidthPriority": The bandwidth priority of this torrent (tr_priority_t).
  /// - "downloadLimit": The maximum download speed for the torrent in KBps.
  /// - "downloadLimited": A boolean indicating whether the download speed limit is honored.
  /// - [MISSING] "filesUnwanted": An array of indices representing file(s) to exclude from downloading.
  /// - [MISSING] "filesWanted": An array of indices representing file(s) to download.
  /// - "group": The name of the torrent's bandwidth group as a string.
  /// - "honorsSessionLimits": A boolean indicating whether session upload limits are honored.
  /// - "ids": An array representing the torrent list, as described in version 3.1.
  /// - "labels": An array of string labels associated with the torrent.
  /// - "location": The new location for the torrent's content as a string.
  /// - "peerLimit": The maximum number of allowed peers for the torrent.
  /// - "priorityHigh": An array of indices representing high-priority file(s).
  /// - "priorityLow": An array of indices representing low-priority file(s).
  /// - "priorityNormal": An array of indices representing normal-priority file(s).
  /// - "queuePosition": The position of the torrent in its queue (0 to n).
  /// - "seedIdleLimit": The torrent-level number of minutes of seeding inactivity.
  /// - "seedIdleMode": The seeding inactivity mode to use (See tr_idlelimit).
  /// - "seedRatioLimit": The torrent-level seeding ratio.
  /// - "seedRatioMode": The seeding ratio mode to use (See tr_ratiolimit).
  /// - "sequentialDownload": A boolean indicating whether to download torrent pieces sequentially.
  /// - "trackerList": A string containing announce URLs, one per line, with a blank line between tiers.
  /// - "uploadLimit": The maximum upload speed for the torrent in KBps.
  /// - "uploadLimited": A boolean indicating whether the upload speed limit is honored.
  ///
  /// Returns: The result of setting the torrent properties.
  ///
  /// Example:
  /// ```dart
  /// var result = set({
  ///   ids: '001d83eb39e7a31a21a4f229524ab484118b0665',
  ///   bandwidthPriority: 1,
  ///   downloadLimit: 1024,
  ///   downloadLimited: true,
  ///   filesUnwanted: [2, 5, 7],
  ///   // ... other parameters ...
  /// });
  /// ```
  set({
    // The bandwidth priority of this torrent
    int? bandwidthPriority,
    // The maximum download speed for the torrent in KBps.
    int? downloadLimit,
    // A boolean indicating whether the download speed limit is honored.
    bool? downloadLimited,
    // The name of the torrent's bandwidth group as a string
    String? group,
    // A boolean indicating whether session upload limits are honored
    bool? honorsSessionLimits,
    // An array representing the torrent list, as described
    List<String>? ids,
    // An array of string labels associated with the torrent
    List<String>? labels,
    // The new location for the torrent's content as a string
    String? location,
    // The maximum number of allowed peers for the torrent
    int? peerLimit,
    // An array of indices representing high-priority file(s)
    List<int>? priorityHigh,
    // An array of indices representing low-priority file(s)
    List<int>? priorityLow,
    // An array of indices representing normal-priority file(s)
    List<int>? priorityNormal,
    // The position of the torrent in its queue (0 to n).
    int? queuePosition,
    // The torrent-level seeding ratio
    int? seedIdleLimit,
    // The seeding inactivity mode to use (See tr_idlelimit)
    int? seedIdleMode,
    // The torrent-level seeding ratio
    double? seedRatioLimit,
    // The seeding ratio mode to use (See tr_ratiolimit)
    int? seedRatioMode,
    // A string containing announce URLs, one per line, with a blank line between tiers.
    List<String>? trackerList,
    //The maximum upload speed for the torrent in KBps.
    int? uploadLimit,
    // A boolean indicating whether the upload speed limit is honored
    bool? uploadLimited,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(Method.set, arguments: {
          if (bandwidthPriority != null) 'bandwidthPriority': bandwidthPriority,
          if (downloadLimit != null) 'downloadLimit': downloadLimit,
          if (downloadLimited != null) 'downloadLimited': downloadLimited,
          if (group != null) 'group': group,
          if (honorsSessionLimits != null)
            'honorsSessionLimits': honorsSessionLimits,
          if (ids != null) 'ids': ids,
          if (labels != null) 'labels': labels,
          if (location != null) 'location': location,
          if (peerLimit != null) 'peer-limit': peerLimit,
          if (priorityHigh != null) 'priority-high': priorityHigh,
          if (priorityLow != null) 'priority-low': priorityLow,
          if (priorityNormal != null) 'priority-normal': priorityNormal,
          if (queuePosition != null) 'queuePosition': queuePosition,
          if (seedIdleLimit != null) 'seedIdleLimit': seedIdleLimit,
          if (seedIdleMode != null) 'seedIdleMode': seedIdleMode,
          if (seedRatioLimit != null) 'seedRatioLimit': seedRatioLimit,
          if (seedRatioMode != null) 'seedRatioMode': seedRatioMode,
          if (trackerList != null) 'trackerList': trackerList.join('\n\n'),
          if (uploadLimit != null) 'uploadLimit': uploadLimit,
          if (uploadLimited != null) 'uploadLimited': uploadLimited,
        }).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    response.check();
    return response;
  }

  /// Retrieves information for one or more torrents based on the provided arguments.
  ///
  /// - "activityDate": The last time the torrent activity was recorded (tr_stat).
  /// - "addedDate": The date when the torrent was added (tr_stat).
  /// - "availability": An array representing torrent availability (tr_torrentAvailability).
  /// - "bandwidthPriority": The bandwidth priority of the torrent (tr_priority_t).
  /// - "comment": The comment associated with the torrent (tr_torrent_view).
  /// - "corruptEver": The number of corrupt bytes downloaded for the torrent (tr_stat).
  /// - "creator": The creator of the torrent (tr_torrent_view).
  /// - "dateCreated": The date when the torrent was created (tr_torrent_view).
  /// - "desiredAvailable": The desired availability of the torrent (tr_stat).
  /// - "doneDate": The date when the torrent completed downloading (tr_stat).
  /// - "downloadDir": The directory where the torrent is downloaded (tr_torrent).
  /// - "downloadedEver": The total amount downloaded for the torrent (tr_stat).
  /// - "downloadLimit": The maximum download speed for the torrent in KBps (tr_torrent).
  /// - "downloadLimited": A boolean indicating whether the download speed limit is honored (tr_torrent).
  /// - "editDate": The date when the torrent was last edited (tr_stat).
  /// - "error": The error code associated with the torrent (tr_stat).
  /// - "errorString": The error message associated with the torrent (tr_stat).
  /// - "eta": The estimated time remaining for the torrent in seconds (tr_stat).
  /// - "etaIdle": The estimated idle time remaining for the torrent in seconds (tr_stat).
  /// - "file-count": The number of files in the torrent (tr_info).
  /// - "files": An array representing torrent files (tr_info).
  /// - "fileStats": An array representing file statistics (tr_info).
  /// - "group": The name of the torrent's bandwidth group as a string.
  /// - "hashString": The hash of the torrent (tr_torrent_view).
  /// - "haveUnchecked": The number of bytes that have been downloaded but not checked (tr_stat).
  /// - "haveValid": The number of bytes that have been downloaded and checked (tr_stat).
  /// - "honorsSessionLimits": A boolean indicating whether session upload limits are honored (tr_torrent).
  /// - "id": The ID of the torrent (tr_torrent).
  /// - "isFinished": A boolean indicating whether the torrent has finished downloading (tr_stat).
  /// - "isPrivate": A boolean indicating whether the torrent is marked as private (tr_torrent).
  /// - "isStalled": A boolean indicating whether the torrent is stalled (tr_stat).
  /// - "labels": An array of string labels associated with the torrent (tr_torrent).
  /// - "leftUntilDone": The amount of data left to download in bytes (tr_stat).
  /// - "magnetLink": The magnet link associated with the torrent (n/a).
  /// - "manualAnnounceTime": The manual announce time for the torrent (tr_stat).
  /// - "maxConnectedPeers": The maximum number of connected peers for the torrent (tr_torrent).
  /// - "metadataPercentComplete": The percentage of metadata completion for the torrent (tr_stat).
  /// - "name": The name of the torrent (tr_torrent_view).
  /// - "peer-limit": The maximum number of allowed peers for the torrent (tr_torrent).
  /// - "peers": An array representing torrent peers (n/a).
  /// - "peersConnected": The number of peers connected to the torrent (tr_stat).
  /// - "peersFrom": An object representing peers from (n/a).
  /// - "peersGettingFromUs": The number of peers getting data from us (tr_stat).
  /// - "peersSendingToUs": The number of peers sending data to us (tr_stat).
  /// - "percentComplete": The percentage of completion for the torrent (tr_stat).
  /// - "percentDone": The percentage of completion for the torrent (tr_stat).
  /// - "pieces": The pieces of the torrent (tr_torrent).
  /// - "pieceCount": The number of pieces in the torrent (tr_torrent_view).
  /// - "pieceSize": The size of pieces in the torrent (tr_torrent_view).
  /// - "priorities": An array representing torrent priorities (n/a).
  /// - "primary-mime-type": The primary MIME type of the torrent (tr_torrent).
  /// - "queuePosition": The position of the torrent in its queue (tr_stat).
  /// - "rateDownload (B/s)": The download rate in bytes per second (tr_stat).
  /// - "rateUpload (B/s)": The upload rate in bytes per second (tr_stat).
  /// - "recheckProgress": The progress of rechecking the torrent (tr_stat).
  /// - "secondsDownloading": The number of seconds the torrent has been downloading (tr_stat).
  /// - "secondsSeeding": The number of seconds the torrent has been seeding (tr_stat).
  /// - "seedIdleLimit": The torrent-level number of minutes of seeding inactivity (tr_torrent).
  /// - "seedIdleMode": The seeding inactivity mode to use (tr_inactivelimit).
  /// - "seedRatioLimit": The torrent-level seeding ratio (tr_torrent).
  /// - "seedRatioMode": The seeding ratio mode to use (tr_ratiolimit).
  /// - "sequentialDownload": A boolean indicating whether to download torrent pieces sequentially (tr_torrent).
  /// - "sizeWhenDone": The total size of the torrent when it's completed (tr_stat).
  /// - "startDate": The date when the torrent started (tr_stat).
  /// - "status": The status of the torrent (tr_stat).
  /// - "trackers": An array representing torrent trackers (n/a).
  /// - "trackerList": A string containing announce URLs, one per line, with a blank line between tiers (string).
  /// - "trackerStats": An array representing tracker statistics (n/a).
  /// - "totalSize": The total size of the torrent (tr_torrent_view).
  /// - "torrentFile": The torrent file associated with the torrent (tr_info).
  /// - "uploadedEver": The total amount uploaded for the torrent (tr_stat).
  /// - "uploadLimit": The maximum upload speed for the torrent in KBps (tr_torrent).
  /// - "uploadLimited": A boolean indicating whether the upload speed limit is honored (tr_torrent).
  /// - "uploadRatio": The upload ratio for the torrent (tr_stat).
  /// - "wanted": An array representing wanted files (n/a).
  /// - "webseeds": An array of webseeds associated with the torrent (tr_tracker_view).
  /// - "webseedsSendingToUs": The number of webseeds sending data to us (tr_stat).
  ///
  /// Returns: A list of [Torrent] objects containing the requested torrent information.
  ///
  /// Example:
  /// ```dart
  /// var torrents = await getTorrents(
  ///   ids: ['001d83eb39e7a31a21a4f229524ab484118b0665', '2c1d0b8497d1f7e3250790633b2aa870ee8d8c2a'],
  ///   fields: ["id", "name", "status", "percentDone"],
  /// );
  /// ```
  Future<List<Torrent>> get({
    List<String>? ids,
    List<String> fields = torrentGetAllFields,
    bool recentlyActive = false,
  }) async {
    var arguments = {'fields': fields, 'format': 'objects'};
    if (ids != null) arguments['ids'] = ids;
    if (recentlyActive) arguments['ids'] = 'recently-active';

    final results = await _dio.post('/',
        data: TransmissionRequest(Method.get, arguments: arguments).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    response.check();
    final torrentsData = response.arguments!['torrents'];
    return torrentsData
        .map((data) => Torrent.fromJson(data))
        .cast<Torrent>()
        .toList(growable: false);
  }

  /// Add torrent to transmission
  /// [cookies] pointer to a string of one or more cookies.
  /// [downloadDir] path to download the torrent to
  /// [filename] filename or URL of the .torrent file
  /// [metainfo] optional base64-encoded .torrent content
  /// [paused] if true, don't start the torrent
  /// [peerLimit] maximum number of peers
  /// [bandwidthPriority] torrent's bandwidth tr_priority_t
  /// Returns [TorrentLight] light torrent info if added successfully
  /// Throws [AddTorrentException] if errors
  Future<TorrentLight> add({
    String? cookies,
    String? downloadDir,
    String? filename,
    String? metainfo,
    bool? paused,
    int? peerLimit,
    int? bandwidthPriority,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(Method.add, arguments: {
          if (cookies != null) 'cookies': cookies,
          if (downloadDir != null) 'download-dir': downloadDir,
          if (filename != null) 'filename': filename,
          if (metainfo != null) 'metainfo': metainfo,
          if (paused != null) 'paused': paused,
          if (peerLimit != null) 'peer-limit': peerLimit,
          if (bandwidthPriority != null) 'bandwidthPriority': bandwidthPriority,
        }).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    if (response.isSuccess) {
      if (response.arguments!['torrent-duplicate'] != null) {
        throw AddTorrentException(
            response.copyWith(result: 'Torrent duplicated'),
            TorrentLight.fromJson(response.arguments!['torrent-duplicate']));
      } else {
        return TorrentLight.fromJson(response.arguments!['torrent-added']);
      }
    } else {
      throw AddTorrentException(
        response,
        TorrentLight.fromJson(response.arguments!['torrent-duplicate']),
      );
    }
  }

  /// Remove torrents by their given ids
  /// [ids] SHA1 hash list of the torrents
  /// [deleteLocalData] delete local data. (default: false)
  /// Throws [TransmissionException] if errors
  Future<void> remove(
      {required List<String> ids, bool deleteLocalData = false}) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(Method.remove,
                arguments: {'ids': ids, 'delete-local-data': deleteLocalData})
            .toJSON());
    TransmissionResponse.fromJSON(results.data).check();
  }

  /// Move torrents by their given ids
  /// [ids] SHA1 hash list of the torrents
  /// [location] the new torrent location
  /// [move] if true, move from previous location. otherwise, search "location" for files (default: false)
  /// Throws [TransmissionException] if errors
  Future<void> move({
    required List<String> ids,
    required String location,
    bool move = false,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(Method.setLocation, arguments: {
          'ids': ids,
          'location': location,
          'move': move,
        }).toJSON());
    TransmissionResponse.fromJSON(results.data).check();
  }

  /// Rename torrent by given id
  /// [id] of the torrent to rename
  /// [path] the path to the file or folder that will be renamed
  /// [name] the file or folder's new name
  /// Throws [TransmissionException] if errors
  Future<void> renamePath({
    required String id,
    String? path,
    String? name,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(Method.renamePath, arguments: {
          'ids': id,
          if (path != null) 'path': path,
          if (name != null) 'name': name,
        }).toJSON());
    TransmissionResponse.fromJSON(results.data).check();
  }

  /// Torrent action requests
  /// | Method name            | libtransmission function
  /// |:--|:--
  /// | `torrent-start`        | tr_torrentStart
  /// | `torrent-start-now`    | tr_torrentStartNow
  /// | `torrent-stop`         | tr_torrentStop
  /// | `torrent-verify`       | tr_torrentVerify
  /// | `torrent-verify-force` | tr_torrentVerifyForce
  /// | `torrent-reannounce`   | tr_torrentManualUpdate ("ask tracker for more peers")
  Future<void> _action(List<String>? ids, Method method) async {
    Map<String, dynamic> arguments = {};
    if (ids != null) arguments['ids'] = ids;

    print(method.name);

    final results = await _dio.post('/',
        data: TransmissionRequest(method, arguments: arguments).toJSON());
    TransmissionResponse.fromJSON(results.data).check();
  }

  Future<void> start({List<String>? ids}) async {
    _action(ids, Method.start);
  }

  Future<void> startNow({List<String>? ids}) async {
    _action(ids, Method.startNow);
  }

  Future<void> stop({List<String>? ids}) async {
    _action(ids, Method.stop);
  }

  Future<void> verify({List<String>? ids}) async {
    _action(ids, Method.verify);
  }

  Future<void> verifyForce({List<String>? ids}) async {
    _action(ids, Method.verifyForce);
  }

  Future<void> reannounce({List<String>? ids}) async {
    _action(ids, Method.reannounce);
  }
}
