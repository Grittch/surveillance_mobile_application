class DetectionEntity {
  final String detectionId;
  final int dateTime;
  final String deviceId;
  final bool isFavorite;
  final String name;
  final String note;
  final String tag;

  DetectionEntity({
    required this.detectionId,
    required this.dateTime,
    required this.deviceId,
    required this.isFavorite,
    required this.name,
    required this.note,
    required this.tag,
  });
}
