import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:transmission/transmission.dart';

const csrfProtectionHeader = 'X-Transmission-Session-Id';
const basicAuthentication = 'Authorization';
const proxyBasicAuthentication = 'Proxy-Authorization';

const methodAddTorrent = 'torrent-add';
const methodRemoveTorrent = 'torrent-remove';
const methodRenameTorrent = 'torrent-rename-path';
const methodMoveTorrent = 'torrent-set-location';
const methodGetTorrent = 'torrent-get';
const methodSetTorrent = 'torrent-set';
const methodSetSession = 'session-set';
const methodGetSession = 'session-get';

const methodStartTorrent = 'torrent-start';
const methodStartNowTorrent = 'torrent-start-now';
const methodStopTorrent = 'torrent-stop';
const methodUpdateTorrent = 'torrent-reannounce';
const methodVerifyTorrent = 'torrent-verify';

extension RequestOptionsExtension on RequestOptions {
  Options toOptions() {
    return Options(
      responseType: responseType,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      contentType: contentType,
      extra: extra,
      followRedirects: followRedirects,
      headers: headers,
      listFormat: listFormat,
      maxRedirects: maxRedirects,
      method: method,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      validateStatus: validateStatus,
    );
  }
}

/// Transmission object to interact with a remote instance
/// Documentation about the API at https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md
class Transmission {
  final bool enableLog;
  final bool proxified;
  final Dio _dio;
  final Dio _tokenDio = Dio();

  Transmission._(this._dio, this.proxified, this.enableLog) {
    _tokenDio.options = _dio.options;
    String? csrfToken;
    if (enableLog) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      if (csrfToken != null) {
        options.headers[csrfProtectionHeader] = csrfToken;
      }
      handler.next(options);
    }, onError: (DioError error, handler) async {
      if (error.response?.statusCode == 409) {
        _dio.lock();
        final options = error.requestOptions;
        // If the token has been updated, repeat directly.
        if (csrfToken != options.headers[csrfProtectionHeader]) {
          options.headers[csrfProtectionHeader] = csrfToken;
        } else {
          csrfToken = error.response!.headers[csrfProtectionHeader]!.first;
          options.headers[csrfProtectionHeader] = csrfToken;
        }
        //repeat
        try {
          final response = await _tokenDio.request(
            options.path,
            options: options.toOptions(),
            data: options.data,
            cancelToken: options.cancelToken,
            onReceiveProgress: options.onReceiveProgress,
            onSendProgress: options.onSendProgress,
            queryParameters: options.queryParameters,
          );
          _dio.unlock();
          handler.resolve(response);
        } on DioError catch (err) {
          _dio.unlock();
          handler.reject(err);
        } catch (err) {
          print(err);
          _dio.unlock();
          handler.reject(error);
        }
        return;
      }
      handler.next(error);
    }));
  }

  /// Documentation about the API at https://github.com/transmission/transmission/blob/master/extras/rpc-spec.txt
  /// [baseUrl] url of the transmission server instance, default to http://localhost:9091/transmission/rpc
  /// [proxyUrl] url use as a proxy, urls will be added at the end before request, default to null
  /// [enableLog] boolean to show http logs or not
  factory Transmission(
      {String? baseUrl,
      String? proxyUrl,
      bool enableLog = false,
      String? username,
      String? password}) {
    baseUrl ??= 'http://localhost:9091/transmission/rpc';
    Dio client = Dio(BaseOptions(
        baseUrl: proxyUrl == null
            ? baseUrl
            : proxyUrl + Uri.encodeComponent(baseUrl)));
    if (username != null && password != null) {
      String auth = base64.encode(utf8.encode('$username:$password'));
      if (proxyUrl != null) {
        client.options.headers[proxyBasicAuthentication] = 'Basic $auth';
      } else {
        client.options.headers[basicAuthentication] = 'Basic $auth';
      }
    }
    return Transmission._(client, proxyUrl != null, enableLog);
  }

  /// close all connexions
  void dispose() {
    _dio.close();
    _tokenDio.close();
  }

  /// Remove torrents by their given ids
  /// [ids] integer identifier list of the torrents to remove
  /// [deleteLocalData] boolean to also delete local data, default false
  /// Throws [TransmissionException] if errors
  Future<void> removeTorrents(
    List<int> ids, {
    bool deleteLocalData = false,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodRemoveTorrent, arguments: {
          'ids': ids,
          'delete-local-data': deleteLocalData,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Move torrents by their given ids
  /// [ids] integer identifier list of the torrents to remove
  /// [location] new location to move the torrent
  /// [move] if true, move from previous location otherwise, search "location" for files, default false
  /// Throws [TransmissionException] if errors
  Future<void> moveTorrents(
    List<int> ids,
    String location, {
    bool move = false,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodMoveTorrent, arguments: {
          'ids': ids,
          'location': location,
          'move': move,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Rename torrent by given id
  /// [id] of the torrent to rename
  /// [name] new name
  /// [path] old name
  /// Throws [TransmissionException] if errors
  Future<void> renameTorrent(
    int id, {
    String? name,
    String? path,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodRenameTorrent, arguments: {
          'ids': id,
          if (path != null) 'path': path,
          if (name != null) 'name': name,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Add torrent to transmission
  /// [filename] optional filename or URL of the .torrent file
  /// [metaInfo] optional base64-encoded .torrent content
  /// [downloadDir] optional directory where to download the torrent
  /// [cookies] optional pointer to a string of one or more cookies
  /// [paused] optional boolean to paused the torrent when added
  /// Returns [TorrentLight] light torrent info if added successfully
  /// Throws [AddTorrentException] if errors
  Future<TorrentLight> addTorrent({
    String? filename,
    String? metaInfo,
    String? downloadDir,
    String? cookies,
    bool? paused,
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodAddTorrent, arguments: {
          if (filename != null) 'filename': filename,
          if (metaInfo != null) 'metainfo': metaInfo,
          if (downloadDir != null) 'download-dir': downloadDir,
          if (cookies != null) 'cookies': cookies,
          if (paused != null) 'paused': paused,
        }).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    if (response.isSuccess) {
      if (response.arguments!['torrent-duplicate'] != null) {
        throw AddTorrentException(
            response.copyWith(result: 'Torrent duplicated'),
            TorrentLight(response.arguments!['torrent-duplicate']));
      } else {
        return TorrentLight(response.arguments!['torrent-added']);
      }
    } else {
      throw AddTorrentException(
          response, TorrentLight(response.arguments!['torrent-duplicate']));
    }
  }

  /// Stop torrents by given ids
  /// [ids] integer identifier list of the torrents to remove
  /// Throws [TransmissionException] if errors
  Future<void> stopTorrents(List<int> ids) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodStopTorrent, arguments: {
          'ids': ids,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Start torrents now by given ids
  /// [ids] integer identifier list of the torrents to remove
  /// Throws [TransmissionException] if errors
  Future<void> startNowTorrents(List<int> ids) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodStartNowTorrent, arguments: {
          'ids': ids,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Start torrents by given ids
  /// [ids] integer identifier list of the torrents to remove
  /// Throws [TransmissionException] if errors
  Future<void> startTorrents(List<int> ids) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodStartTorrent, arguments: {
          'ids': ids,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Verify torrents by given ids
  /// [ids] integer identifier list of the torrents to remove
  /// Throws [TransmissionException] if errors
  Future<void> verifyTorrents(List<int> ids) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodVerifyTorrent, arguments: {
          'ids': ids,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  /// Ask for more peers for torrents by given ids
  /// [ids] integer identifier list of the torrents to remove
  /// Throws [TransmissionException] if errors
  Future<void> askForMorePeers(List<int> ids) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodUpdateTorrent, arguments: {
          'ids': ids,
        }).toJSON());
    _checkResults(TransmissionResponse.fromJSON(results.data));
  }

  void _checkResults(TransmissionResponse response) {
    if (!response.isSuccess) {
      throw TransmissionException(response);
    }
  }

  /// Get recently torrents activity
  /// [fields] list of fields to retrieve
  /// Returns list of [RecentlyActiveTorrent] that contain removed torrent ids or torrents update info
  /// Throws [TransmissionException] if errors
  Future<RecentlyActiveTorrent> getRecentlyActive({
    List<String> fields = const [
      'id',
      'name',
      'eta',
      'queuePosition',
      'downloadDir',
      'isFinished',
      'isStalled',
      'leftUntilDone',
      'metadataPercentComplete',
      'error',
      'errorString',
      'percentDone',
      'totalSize',
      'peersConnected',
      'sizeWhenDone',
      'status',
      'rateDownload',
      'rateUpload',
      'peersGettingFromUs',
      'peersSendingToUs',
    ],
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodGetTorrent, arguments: {
          'fields': fields,
          'ids': 'recently-active',
        }).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    _checkResults(response);
    final torrentsData = response.arguments!['torrents'];
    final torrentsRemoved = response.arguments!['removed'];
    return RecentlyActiveTorrent(
      torrentsData
          .map((data) => Torrent(data))
          .cast<Torrent>()
          .toList(growable: false),
      torrentsRemoved?.cast<int>(),
    );
  }

  /// Get data session, fields can be provided to get only needed information
  /// [fields] to retrieve, can be checked at https://github.com/transmission/transmission/blob/master/extras/rpc-spec.txt
  /// Returns [Map] of the session's data
  /// Throws [TransmissionException] if errors
  Future<Map<String, dynamic>> getSession({
    List<String> fields = const [
      'alt-speed-enabled',
      'speed-limit-down-enabled',
      'speed-limit-up-enabled',
      'download-dir',
      'speed-limit-down',
      'speed-limit-up',
      'alt-speed-down',
      'alt-speed-up',
      'version',
    ],
  }) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(methodGetSession, arguments: {
          'fields': fields,
        }).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    _checkResults(response);
    return response.arguments!;
  }

  /// Set data session
  /// [fields] to set, can be checked at https://github.com/transmission/transmission/blob/master/extras/rpc-spec.txt
  /// Throws [TransmissionException] if errors
  Future<void> setSession(Map<String, dynamic> fields) async {
    final results = await _dio.post('/',
        data:
            TransmissionRequest(methodSetSession, arguments: fields).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    _checkResults(response);
  }

  /// Sets various properties for a torrent.
  ///
  /// [arguments]: A map of arguments with keys representing the property names and values as follows:
  ///
  /// - "bandwidthPriority": The bandwidth priority of this torrent (tr_priority_t).
  /// - "downloadLimit": The maximum download speed for the torrent in KBps.
  /// - "downloadLimited": A boolean indicating whether the download speed limit is honored.
  /// - "filesUnwanted": An array of indices representing file(s) to exclude from downloading.
  /// - "filesWanted": An array of indices representing file(s) to download.
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
  /// - "trackerAdd": DEPRECATED - Use "trackerList" instead. An array of tracker URLs to add.
  /// - "trackerList": A string containing announce URLs, one per line, with a blank line between tiers.
  /// - "trackerRemove": DEPRECATED - Use "trackerList" instead. An array of tracker URLs to remove.
  /// - "trackerReplace": DEPRECATED - Use "trackerList" instead. An array of tracker URLs to replace.
  /// - "uploadLimit": The maximum upload speed for the torrent in KBps.
  /// - "uploadLimited": A boolean indicating whether the upload speed limit is honored.
  ///
  /// Returns: The result of setting the torrent properties.
  ///
  /// Example:
  /// ```dart
  /// var result = setTorrent({
  ///   "ids": '001d83eb39e7a31a21a4f229524ab484118b0665', //hash
  ///   "bandwidthPriority": 1,
  ///   "downloadLimit": 1024,
  ///   "downloadLimited": true,
  ///   "filesUnwanted": [2, 5, 7],
  ///   // ... other parameters ...
  /// });
  /// ```
  setTorrents({required Map<String, dynamic> args}) async {
    final results = await _dio.post('/',
        data: TransmissionRequest(
          methodSetTorrent,
          arguments: args,
        ).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    _checkResults(response);
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
  ///   "ids": ['001d83eb39e7a31a21a4f229524ab484118b0665', '2c1d0b8497d1f7e3250790633b2aa870ee8d8c2a'],
  ///   "fields": ["id", "name", "status", "percentDone"],
  ///   "format": 'objects',
  /// );
  /// ```
  Future<List<Torrent>> getTorrents({
    List<String>? ids,
    List<String> fields = const [
      "activityDate",
      "addedDate",
      "availability",
      "bandwidthPriority",
      "comment",
      "corruptEver",
      "creator",
      "dateCreated",
      "desiredAvailable",
      "doneDate",
      "downloadDir",
      "downloadedEver",
      "downloadLimit",
      "downloadLimited",
      "editDate",
      "error",
      "errorString",
      "eta",
      "etaIdle",
      "file-count",
      "files",
      "fileStats",
      "group",
      "hashString",
      "haveUnchecked",
      "haveValid",
      "honorsSessionLimits",
      "id",
      "isFinished",
      "isPrivate",
      "isStalled",
      "labels",
      "leftUntilDone",
      "magnetLink",
      "manualAnnounceTime",
      "maxConnectedPeers",
      "metadataPercentComplete",
      "name",
      "peer-limit",
      "peers",
      "peersConnected",
      "peersFrom",
      "peersGettingFromUs",
      "peersSendingToUs",
      "percentComplete",
      "percentDone",
      "pieces",
      "pieceCount",
      "pieceSize",
      "priorities",
      "primary-mime-type",
      "queuePosition",
      "rateDownload (B/s)",
      "rateUpload (B/s)",
      "recheckProgress",
      "secondsDownloading",
      "secondsSeeding",
      "seedIdleLimit",
      "seedIdleMode",
      "seedRatioLimit",
      "seedRatioMode",
      "sequentialDownload",
      "sizeWhenDone",
      "startDate",
      "status",
      "trackers",
      "trackerList",
      "trackerStats",
      "totalSize",
      "torrentFile",
      "uploadedEver",
      "uploadLimit",
      "uploadLimited",
      "uploadRatio",
      "wanted",
      "webseeds",
      "webseedsSendingToUs",
    ],
  }) async {
    var arguments = {'fields': fields, 'format': 'objects'};
    if (ids != null) arguments['ids'] = ids;
    final results = await _dio.post('/',
        data: TransmissionRequest(
          methodGetTorrent,
          arguments: arguments,
        ).toJSON());
    final response = TransmissionResponse.fromJSON(results.data);
    _checkResults(response);
    final torrentsData = response.arguments!['torrents'];
    return torrentsData
        .map((data) => Torrent(data))
        .cast<Torrent>()
        .toList(growable: false);
  }
}
