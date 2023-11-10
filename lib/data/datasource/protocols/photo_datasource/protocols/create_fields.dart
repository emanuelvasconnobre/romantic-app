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

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'description': description,
      'originalName': originalName,
      'fileName': fileName,
      'uploadAt': uploadAt.toIso8601String(), // Convertendo a data para uma representação de string
      'size': size,
      'userId': userId,
    };
  }
}
