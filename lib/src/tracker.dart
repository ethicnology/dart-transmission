/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `announce` | string | tr_tracker_view
/// | `id` | number | tr_tracker_view
/// | `scrape` | string | tr_tracker_view
/// | `sitename` | string | tr_tracker_view
/// | `tier` | number | tr_tracker_view
class Tracker {
  String? announce;
  int? id;
  String? scrape;
  String? sitename;
  int? tier;

  Tracker({
    this.announce,
    this.id,
    this.scrape,
    this.sitename,
    this.tier,
  });

  factory Tracker.fromJson(Map<String, dynamic> json) {
    return Tracker(
      announce: json['announce'],
      id: json['id'],
      scrape: json['scrape'],
      sitename: json['sitename'],
      tier: json['tier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'announce': announce,
      'id': id,
      'scrape': scrape,
      'sitename': sitename,
      'tier': tier,
    };
  }
}
