class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? coverImage;
  String? bio;

  SocialUserModel({
    this.uid,
    this.email,
    this.name,
    this.image,
    this.coverImage,
    this.phone,
    this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    coverImage = json['coverImage'];
    phone = json['phone'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
      'coverImage': coverImage,
      'phone': phone,
      'bio': bio,
    };
  }
}
