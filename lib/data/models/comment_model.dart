class CommentModel {
  int? postId;
  int? id;
  String? name;
  String? body;
  String? email;

  CommentModel({
    this.postId,
    this.id,
    this.name,
    this.body,
    this.email,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}
