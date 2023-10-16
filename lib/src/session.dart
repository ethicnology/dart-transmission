class Session {
  int? altSpeedDown;
  bool? altSpeedEnabled;
  int? altSpeedTimeBegin;
  int? altSpeedTimeDay;
  bool? altSpeedTimeEnabled;
  int? altSpeedTimeEnd;
  int? altSpeedUp;
  bool? blocklistEnabled;
  int? blocklistSize;
  String? blocklistUrl;
  int? cacheSizeMb;
  String? configDir;
  String? defaultTrackers;
  bool? dhtEnabled;
  String? downloadDir;
  int? downloadDirFreeSpace;
  bool? downloadQueueEnabled;
  int? downloadQueueSize;
  String? encryption;
  int? idleSeedingLimit;
  bool? idleSeedingLimitEnabled;
  String? incompleteDir;
  bool? incompleteDirEnabled;
  bool? lpdEnabled;
  int? peerLimitGlobal;
  int? peerLimitPerTorrent;
  int? peerPort;
  bool? peerPortRandomOnStart;
  bool? pexEnabled;
  bool? portForwardingEnabled;
  bool? queueStalledEnabled;
  int? queueStalledMinutes;
  bool? renamePartialFiles;
  int? rpcVersion;
  int? rpcVersionMinimum;
  String? rpcVersionSemver;
  bool? scriptTorrentAddedEnabled;
  String? scriptTorrentAddedFilename;
  bool? scriptTorrentDoneEnabled;
  String? scriptTorrentDoneFilename;
  bool? scriptTorrentDoneSeedingEnabled;
  String? scriptTorrentDoneSeedingFilename;
  bool? seedQueueEnabled;
  int? seedQueueSize;
  int? seedRatioLimit;
  bool? seedRatioLimited;
  String? sessionId;
  int? speedLimitDown;
  bool? speedLimitDownEnabled;
  int? speedLimitUp;
  bool? speedLimitUpEnabled;
  bool? startAddedTorrents;
  bool? trashOriginalTorrentFiles;
  Units? units;
  bool? utpEnabled;
  String? version;

  Session({
    this.altSpeedDown,
    this.altSpeedEnabled,
    this.altSpeedTimeBegin,
    this.altSpeedTimeDay,
    this.altSpeedTimeEnabled,
    this.altSpeedTimeEnd,
    this.altSpeedUp,
    this.blocklistEnabled,
    this.blocklistSize,
    this.blocklistUrl,
    this.cacheSizeMb,
    this.configDir,
    this.defaultTrackers,
    this.dhtEnabled,
    this.downloadDir,
    this.downloadDirFreeSpace,
    this.downloadQueueEnabled,
    this.downloadQueueSize,
    this.encryption,
    this.idleSeedingLimit,
    this.idleSeedingLimitEnabled,
    this.incompleteDir,
    this.incompleteDirEnabled,
    this.lpdEnabled,
    this.peerLimitGlobal,
    this.peerLimitPerTorrent,
    this.peerPort,
    this.peerPortRandomOnStart,
    this.pexEnabled,
    this.portForwardingEnabled,
    this.queueStalledEnabled,
    this.queueStalledMinutes,
    this.renamePartialFiles,
    this.rpcVersion,
    this.rpcVersionMinimum,
    this.rpcVersionSemver,
    this.scriptTorrentAddedEnabled,
    this.scriptTorrentAddedFilename,
    this.scriptTorrentDoneEnabled,
    this.scriptTorrentDoneFilename,
    this.scriptTorrentDoneSeedingEnabled,
    this.scriptTorrentDoneSeedingFilename,
    this.seedQueueEnabled,
    this.seedQueueSize,
    this.seedRatioLimit,
    this.seedRatioLimited,
    this.sessionId,
    this.speedLimitDown,
    this.speedLimitDownEnabled,
    this.speedLimitUp,
    this.speedLimitUpEnabled,
    this.startAddedTorrents,
    this.trashOriginalTorrentFiles,
    this.units,
    this.utpEnabled,
    this.version,
  });

  Session.fromJson(Map<String, dynamic> json) {
    altSpeedDown = json['alt-speed-down'];
    altSpeedEnabled = json['alt-speed-enabled'];
    altSpeedTimeBegin = json['alt-speed-time-begin'];
    altSpeedTimeDay = json['alt-speed-time-day'];
    altSpeedTimeEnabled = json['alt-speed-time-enabled'];
    altSpeedTimeEnd = json['alt-speed-time-end'];
    altSpeedUp = json['alt-speed-up'];
    blocklistEnabled = json['blocklist-enabled'];
    blocklistSize = json['blocklist-size'];
    blocklistUrl = json['blocklist-url'];
    cacheSizeMb = json['cache-size-mb'];
    configDir = json['config-dir'];
    defaultTrackers = json['default-trackers'];
    dhtEnabled = json['dht-enabled'];
    downloadDir = json['download-dir'];
    downloadDirFreeSpace = json['download-dir-free-space'];
    downloadQueueEnabled = json['download-queue-enabled'];
    downloadQueueSize = json['download-queue-size'];
    encryption = json['encryption'];
    idleSeedingLimit = json['idle-seeding-limit'];
    idleSeedingLimitEnabled = json['idle-seeding-limit-enabled'];
    incompleteDir = json['incomplete-dir'];
    incompleteDirEnabled = json['incomplete-dir-enabled'];
    lpdEnabled = json['lpd-enabled'];
    peerLimitGlobal = json['peer-limit-global'];
    peerLimitPerTorrent = json['peer-limit-per-torrent'];
    peerPort = json['peer-port'];
    peerPortRandomOnStart = json['peer-port-random-on-start'];
    pexEnabled = json['pex-enabled'];
    portForwardingEnabled = json['port-forwarding-enabled'];
    queueStalledEnabled = json['queue-stalled-enabled'];
    queueStalledMinutes = json['queue-stalled-minutes'];
    renamePartialFiles = json['rename-partial-files'];
    rpcVersion = json['rpc-version'];
    rpcVersionMinimum = json['rpc-version-minimum'];
    rpcVersionSemver = json['rpc-version-semver'];
    scriptTorrentAddedEnabled = json['script-torrent-added-enabled'];
    scriptTorrentAddedFilename = json['script-torrent-added-filename'];
    scriptTorrentDoneEnabled = json['script-torrent-done-enabled'];
    scriptTorrentDoneFilename = json['script-torrent-done-filename'];
    scriptTorrentDoneSeedingEnabled =
        json['script-torrent-done-seeding-enabled'];
    scriptTorrentDoneSeedingFilename =
        json['script-torrent-done-seeding-filename'];
    seedQueueEnabled = json['seed-queue-enabled'];
    seedQueueSize = json['seed-queue-size'];
    seedRatioLimit = json['seedRatioLimit'];
    seedRatioLimited = json['seedRatioLimited'];
    sessionId = json['session-id'];
    speedLimitDown = json['speed-limit-down'];
    speedLimitDownEnabled = json['speed-limit-down-enabled'];
    speedLimitUp = json['speed-limit-up'];
    speedLimitUpEnabled = json['speed-limit-up-enabled'];
    startAddedTorrents = json['start-added-torrents'];
    trashOriginalTorrentFiles = json['trash-original-torrent-files'];
    units = json['units'] != null ? Units.fromJson(json['units']) : null;
    utpEnabled = json['utp-enabled'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alt-speed-down'] = altSpeedDown;
    data['alt-speed-enabled'] = altSpeedEnabled;
    data['alt-speed-time-begin'] = altSpeedTimeBegin;
    data['alt-speed-time-day'] = altSpeedTimeDay;
    data['alt-speed-time-enabled'] = altSpeedTimeEnabled;
    data['alt-speed-time-end'] = altSpeedTimeEnd;
    data['alt-speed-up'] = altSpeedUp;
    data['blocklist-enabled'] = blocklistEnabled;
    data['blocklist-size'] = blocklistSize;
    data['blocklist-url'] = blocklistUrl;
    data['cache-size-mb'] = cacheSizeMb;
    data['config-dir'] = configDir;
    data['default-trackers'] = defaultTrackers;
    data['dht-enabled'] = dhtEnabled;
    data['download-dir'] = downloadDir;
    data['download-dir-free-space'] = downloadDirFreeSpace;
    data['download-queue-enabled'] = downloadQueueEnabled;
    data['download-queue-size'] = downloadQueueSize;
    data['encryption'] = encryption;
    data['idle-seeding-limit'] = idleSeedingLimit;
    data['idle-seeding-limit-enabled'] = idleSeedingLimitEnabled;
    data['incomplete-dir'] = incompleteDir;
    data['incomplete-dir-enabled'] = incompleteDirEnabled;
    data['lpd-enabled'] = lpdEnabled;
    data['peer-limit-global'] = peerLimitGlobal;
    data['peer-limit-per-torrent'] = peerLimitPerTorrent;
    data['peer-port'] = peerPort;
    data['peer-port-random-on-start'] = peerPortRandomOnStart;
    data['pex-enabled'] = pexEnabled;
    data['port-forwarding-enabled'] = portForwardingEnabled;
    data['queue-stalled-enabled'] = queueStalledEnabled;
    data['queue-stalled-minutes'] = queueStalledMinutes;
    data['rename-partial-files'] = renamePartialFiles;
    data['rpc-version'] = rpcVersion;
    data['rpc-version-minimum'] = rpcVersionMinimum;
    data['rpc-version-semver'] = rpcVersionSemver;
    data['script-torrent-added-enabled'] = scriptTorrentAddedEnabled;
    data['script-torrent-added-filename'] = scriptTorrentAddedFilename;
    data['script-torrent-done-enabled'] = scriptTorrentDoneEnabled;
    data['script-torrent-done-filename'] = scriptTorrentDoneFilename;
    data['script-torrent-done-seeding-enabled'] =
        scriptTorrentDoneSeedingEnabled;
    data['script-torrent-done-seeding-filename'] =
        scriptTorrentDoneSeedingFilename;
    data['seed-queue-enabled'] = seedQueueEnabled;
    data['seed-queue-size'] = seedQueueSize;
    data['seedRatioLimit'] = seedRatioLimit;
    data['seedRatioLimited'] = seedRatioLimited;
    data['session-id'] = sessionId;
    data['speed-limit-down'] = speedLimitDown;
    data['speed-limit-down-enabled'] = speedLimitDownEnabled;
    data['speed-limit-up'] = speedLimitUp;
    data['speed-limit-up-enabled'] = speedLimitUpEnabled;
    data['start-added-torrents'] = startAddedTorrents;
    data['trash-original-torrent-files'] = trashOriginalTorrentFiles;
    if (units != null) {
      data['units'] = units!.toJson();
    }
    data['utp-enabled'] = utpEnabled;
    data['version'] = version;
    return data;
  }
}

class Units {
  int? memoryBytes;
  List<String>? memoryUnits;
  int? sizeBytes;
  List<String>? sizeUnits;
  int? speedBytes;
  List<String>? speedUnits;

  Units(
      {this.memoryBytes,
      this.memoryUnits,
      this.sizeBytes,
      this.sizeUnits,
      this.speedBytes,
      this.speedUnits});

  Units.fromJson(Map<String, dynamic> json) {
    memoryBytes = json['memory-bytes'];
    memoryUnits = json['memory-units'].cast<String>();
    sizeBytes = json['size-bytes'];
    sizeUnits = json['size-units'].cast<String>();
    speedBytes = json['speed-bytes'];
    speedUnits = json['speed-units'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memory-bytes'] = memoryBytes;
    data['memory-units'] = memoryUnits;
    data['size-bytes'] = sizeBytes;
    data['size-units'] = sizeUnits;
    data['speed-bytes'] = speedBytes;
    data['speed-units'] = speedUnits;
    return data;
  }
}
