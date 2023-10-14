/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `announceState`           | number     | tr_tracker_view
/// | `announce`                | string     | tr_tracker_view
/// | `downloadCount`           | number     | tr_tracker_view
/// | `hasAnnounced`            | boolean    | tr_tracker_view
/// | `hasScraped`              | boolean    | tr_tracker_view
/// | `host`                    | string     | tr_tracker_view
/// | `id`                      | number     | tr_tracker_view
/// | `isBackup`                | boolean    | tr_tracker_view
/// | `lastAnnouncePeerCount`   | number     | tr_tracker_view
/// | `lastAnnounceResult`      | string     | tr_tracker_view
/// | `lastAnnounceStartTime`   | number     | tr_tracker_view
/// | `lastAnnounceSucceeded`   | boolean    | tr_tracker_view
/// | `lastAnnounceTime`        | number     | tr_tracker_view
/// | `lastAnnounceTimedOut`    | boolean    | tr_tracker_view
/// | `lastScrapeResult`        | string     | tr_tracker_view
/// | `lastScrapeStartTime`     | number     | tr_tracker_view
/// | `lastScrapeSucceeded`     | boolean    | tr_tracker_view
/// | `lastScrapeTime`          | number     | tr_tracker_view
/// | `lastScrapeTimedOut`      | boolean    | tr_tracker_view
/// | `leecherCount`            | number     | tr_tracker_view
/// | `nextAnnounceTime`        | number     | tr_tracker_view
/// | `nextScrapeTime`          | number     | tr_tracker_view
/// | `scrapeState`             | number     | tr_tracker_view
/// | `scrape`                  | string     | tr_tracker_view
/// | `seederCount`             | number     | tr_tracker_view
/// | `sitename`                | string     | tr_tracker_view
/// | `tier`                    | number     | tr_tracker_view
class TrackerStats {
  int? announceState;
  String? announce;
  int? downloadCount;
  bool? hasAnnounced;
  bool? hasScraped;
  String? host;
  int? id;
  bool? isBackup;
  int? lastAnnouncePeerCount;
  String? lastAnnounceResult;
  int? lastAnnounceStartTime;
  bool? lastAnnounceSucceeded;
  int? lastAnnounceTime;
  bool? lastAnnounceTimedOut;
  String? lastScrapeResult;
  int? lastScrapeStartTime;
  bool? lastScrapeSucceeded;
  int? lastScrapeTime;
  bool? lastScrapeTimedOut;
  int? leecherCount;
  int? nextAnnounceTime;
  int? nextScrapeTime;
  int? scrapeState;
  String? scrape;
  int? seederCount;
  String? sitename;
  int? tier;

  TrackerStats({
    this.announceState,
    this.announce,
    this.downloadCount,
    this.hasAnnounced,
    this.hasScraped,
    this.host,
    this.id,
    this.isBackup,
    this.lastAnnouncePeerCount,
    this.lastAnnounceResult,
    this.lastAnnounceStartTime,
    this.lastAnnounceSucceeded,
    this.lastAnnounceTime,
    this.lastAnnounceTimedOut,
    this.lastScrapeResult,
    this.lastScrapeStartTime,
    this.lastScrapeSucceeded,
    this.lastScrapeTime,
    this.lastScrapeTimedOut,
    this.leecherCount,
    this.nextAnnounceTime,
    this.nextScrapeTime,
    this.scrapeState,
    this.scrape,
    this.seederCount,
    this.sitename,
    this.tier,
  });

  factory TrackerStats.fromJson(Map<String, dynamic> json) {
    return TrackerStats(
      announceState: json['announceState'],
      announce: json['announce'],
      downloadCount: json['downloadCount'],
      hasAnnounced: json['hasAnnounced'],
      hasScraped: json['hasScraped'],
      host: json['host'],
      id: json['id'],
      isBackup: json['isBackup'],
      lastAnnouncePeerCount: json['lastAnnouncePeerCount'],
      lastAnnounceResult: json['lastAnnounceResult'],
      lastAnnounceStartTime: json['lastAnnounceStartTime'],
      lastAnnounceSucceeded: json['lastAnnounceSucceeded'],
      lastAnnounceTime: json['lastAnnounceTime'],
      lastAnnounceTimedOut: json['lastAnnounceTimedOut'],
      lastScrapeResult: json['lastScrapeResult'],
      lastScrapeStartTime: json['lastScrapeStartTime'],
      lastScrapeSucceeded: json['lastScrapeSucceeded'],
      lastScrapeTime: json['lastScrapeTime'],
      lastScrapeTimedOut: json['lastScrapeTimedOut'],
      leecherCount: json['leecherCount'],
      nextAnnounceTime: json['nextAnnounceTime'],
      nextScrapeTime: json['nextScrapeTime'],
      scrapeState: json['scrapeState'],
      scrape: json['scrape'],
      seederCount: json['seederCount'],
      sitename: json['sitename'],
      tier: json['tier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'announceState': announceState,
      'announce': announce,
      'downloadCount': downloadCount,
      'hasAnnounced': hasAnnounced,
      'hasScraped': hasScraped,
      'host': host,
      'id': id,
      'isBackup': isBackup,
      'lastAnnouncePeerCount': lastAnnouncePeerCount,
      'lastAnnounceResult': lastAnnounceResult,
      'lastAnnounceStartTime': lastAnnounceStartTime,
      'lastAnnounceSucceeded': lastAnnounceSucceeded,
      'lastAnnounceTime': lastAnnounceTime,
      'lastAnnounceTimedOut': lastAnnounceTimedOut,
      'lastScrapeResult': lastScrapeResult,
      'lastScrapeStartTime': lastScrapeStartTime,
      'lastScrapeSucceeded': lastScrapeSucceeded,
      'lastScrapeTime': lastScrapeTime,
      'lastScrapeTimedOut': lastScrapeTimedOut,
      'leecherCount': leecherCount,
      'nextAnnounceTime': nextAnnounceTime,
      'nextScrapeTime': nextScrapeTime,
      'scrapeState': scrapeState,
      'scrape': scrape,
      'seederCount': seederCount,
      'sitename': sitename,
      'tier': tier,
    };
  }
}
