class ComplaintModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final String createdAt;

  const ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });
}