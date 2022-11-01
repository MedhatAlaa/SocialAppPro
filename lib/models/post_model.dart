class PostModel {
  String? name;
  String? image;
  String? text;
  String? postImage;
  String? dateTime;
  String? uid;

  PostModel({
    this.postImage,
    this.text,
    this.image,
    this.name,
    this.dateTime,
    this.uid,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
      'uid': uid,
    };
  }
}
