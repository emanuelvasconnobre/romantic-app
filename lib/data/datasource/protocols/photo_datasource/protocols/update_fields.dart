class UpdateOneDatasourceInput {
  final String description;

  UpdateOneDatasourceInput({
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
    };
  }
}
