/// | Key | Value Type | transmission.h source
/// |:--|:--|:--
/// | `bytesCompleted` | number | tr_file_view
/// | `length` | number | tr_file_view
/// | `name` | string | tr_file_view
/// | `beginPiece` | number | tr_file_view
/// | `endPiece` | number | tr_file_view
class File {
  int? bytesCompleted;
  int? length;
  String? name;
  int? beginPiece;
  int? endPiece;

  File({
    this.bytesCompleted,
    this.length,
    this.name,
    this.beginPiece,
    this.endPiece,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      bytesCompleted: json['bytesCompleted'],
      length: json['length'],
      name: json['name'],
      beginPiece: json['beginPiece'],
      endPiece: json['endPiece'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bytesCompleted': bytesCompleted,
      'length': length,
      'name': name,
      'beginPiece': beginPiece,
      'endPiece': endPiece,
    };
  }
}
