class PaginatedGenericType<T> {
  final List<T> items;
  final int countPage;

  PaginatedGenericType({required this.items, required this.countPage});
}