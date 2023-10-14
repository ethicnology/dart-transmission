/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `fromCache`    | number     | tr_stat
/// | `fromDht`      | number     | tr_stat
/// | `fromIncoming` | number     | tr_stat
/// | `fromLpd`      | number     | tr_stat
/// | `fromLtep`     | number     | tr_stat
/// | `fromPex`      | number     | tr_stat
/// | `fromTracker`  | number     | tr_stat
class PeersFrom {
  int? fromCache;
  int? fromDht;
  int? fromIncoming;
  int? fromLpd;
  int? fromLtep;
  int? fromPex;
  int? fromTracker;

  PeersFrom({
    this.fromCache,
    this.fromDht,
    this.fromIncoming,
    this.fromLpd,
    this.fromLtep,
    this.fromPex,
    this.fromTracker,
  });

  factory PeersFrom.fromJson(Map<String, dynamic> json) {
    return PeersFrom(
      fromCache: json['fromCache'],
      fromDht: json['fromDht'],
      fromIncoming: json['fromIncoming'],
      fromLpd: json['fromLpd'],
      fromLtep: json['fromLtep'],
      fromPex: json['fromPex'],
      fromTracker: json['fromTracker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromCache': fromCache,
      'fromDht': fromDht,
      'fromIncoming': fromIncoming,
      'fromLpd': fromLpd,
      'fromLtep': fromLtep,
      'fromPex': fromPex,
      'fromTracker': fromTracker,
    };
  }
}
