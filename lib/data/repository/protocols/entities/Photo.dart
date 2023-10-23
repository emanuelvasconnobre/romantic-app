
class PhotoEntity {
  final String imageUrl;
  final String description;
  final String originalName;
  final String fileName;
  final DateTime uploadAt;
  final double size;
  final String userId;

  PhotoEntity(this.imageUrl, this.description, this.originalName, this.fileName,
      this.uploadAt, this.size, this.userId);

  @override
  String toString() {
    return 'PhotoEntity{imageUrl: $imageUrl, description: $description, '
        'originalName: $originalName, '
        'fileName: $fileName, uploadAt: ${uploadAt.toIso8601String()}, '
        'size: $size, userId: $userId}';
  }
}
