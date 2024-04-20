class ImageModel {
  int? albumId;
  int? id;
  String? url;
  String? title;
  String? thumbnailUrl;

  ImageModel({
    this.albumId,
    this.id,
    this.url,
    this.title,
    this.thumbnailUrl,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    data['title'] = title;
    return data;
  }
}
