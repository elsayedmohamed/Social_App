class SocialUserModel {
  String? name;
  String? email;

  String? uId;
  String? image;
  String? cover;
  String? bio;
  String? phone;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.phone,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    phone = json['phone'];

    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
