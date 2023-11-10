class CreateOneDatasourceInput {
  final String imageUrl;
  final String description;
  final String originalName;
  final String fileName;
  final DateTime uploadAt;
  final double size;
  final String userId;

  CreateOneDatasourceInput(
      {required this.imageUrl,
      required this.description,
      required this.originalName,
      required this.fileName,
      required this.uploadAt,
      required this.size,
      required this.userId});
}
