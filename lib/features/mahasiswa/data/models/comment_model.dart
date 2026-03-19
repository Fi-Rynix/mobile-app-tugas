class MahasiswaCommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  MahasiswaCommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory MahasiswaCommentModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaCommentModel(
      postId: json['postId'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}
