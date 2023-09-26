import 'dart:convert';


List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? github;
  String? linkedin;
  String? twitter;
  String? userID;
  String? technology;
  String? imageUrl;


  UserModel(this.name, this.email, this.phone, this.github, this.linkedin,
      this.twitter, this.userID, this.technology, this.imageUrl);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'github': github,
        'linkedin': linkedin,
        'twitter': twitter,
        'userID': userID,
        'technology': technology,
        'imageUrl': imageUrl ,
      };

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['username']! as String;
    email = json['email']! as String;
    phone = json['phone']! as String;
    github = json['github']! as String;
    linkedin = json['linkedin']! as String;
    twitter = json['twitter']! as String;
    userID = json['userID']! as String;
    technology = json['technology']! as String;
    imageUrl = json['imageUrl'] ?? "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png" as String;

  }
}
//how to intergrate bank payment in flutter?
