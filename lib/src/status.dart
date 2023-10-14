/// `status`: A number between 0 and 6, where:
///
/// | Value | Meaning
/// |:--|:--
/// | 0 | Torrent is stopped
/// | 1 | Torrent is queued to verify local data
/// | 2 | Torrent is verifying local data
/// | 3 | Torrent is queued to download
/// | 4 | Torrent is downloading
/// | 5 | Torrent is queued to seed
/// | 6 | Torrent is seeding
enum Status {
  stopped(0, 'Stopped'),
  verifyQueued(1, 'Queued to verify'),
  verifying(2, 'Verifying'),
  downloadQueued(3, 'Queued to download'),
  downloading(4, 'Downloading'),
  seedQueued(5, 'Queued to seed'),
  seeding(6, 'Seeding');

  final int code;
  final String meaning;
  const Status(this.code, this.meaning);

  static Status? fromCode(int code) {
    switch (code) {
      case 0:
        return Status.stopped;
      case 1:
        return Status.verifyQueued;
      case 2:
        return Status.verifying;
      case 3:
        return Status.downloadQueued;
      case 4:
        return Status.downloading;
      case 5:
        return Status.seedQueued;
      case 6:
        return Status.seeding;
      default:
        return null;
    }
  }
}
