class PostModel {
  final String userId;
  final String id;
  final String title;
  final String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromMap(Map map) => PostModel(
        userId: (map['userId'] ?? '').toString(),
        id: (map['id'] ?? '').toString(),
        title: (map['title'] ?? '').toString(),
        body: (map['body'] ?? '').toString(),
      );
}
