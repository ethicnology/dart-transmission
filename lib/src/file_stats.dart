/// `fileStats`: a file's non-constant properties. An array of `tr_info.filecount` objects, each containing:
///
/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `bytesCompleted` | number | tr_file_view
/// | `wanted` | number | tr_file_view (**Note:** For backwards compatibility, this is serialized as an array of `0` or `1` that should be treated as booleans)
/// | `priority` | number | tr_file_view
class FileStats {
  int? bytesCompleted;
  bool? wanted;
  int? priority;

  FileStats({
    this.bytesCompleted,
    this.wanted,
    this.priority,
  });

  factory FileStats.fromJson(Map<String, dynamic> json) {
    return FileStats(
      bytesCompleted: json['bytesCompleted'],
      wanted: json['wanted'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bytesCompleted': bytesCompleted,
      'wanted': wanted,
      'priority': priority,
    };
  }
}
