import 'package:flutter/material.dart';

class SocialUserModel{
  String ?email;
  String?password;
  String?uid;
  String?phone;
  String?name;
  String?bio;
  String?photo;
  String?photo_cover;
  bool? isEmailVerified;
  SocialUserModel({
    this.email,
    this.password,
    this.uid,
    this.phone,
    this.name,
    this.bio,
    this.photo,
    this.photo_cover,
    this.isEmailVerified,

  });
  SocialUserModel.fromjson(Map<String,dynamic>json){
    email=json['email'];
    password=json['password'];
    uid=json['uid'];
    phone=json['phone'];
    name=json['name'];
    bio=json['bio'];
    photo=json['photo'];
    photo_cover=json['photo_cover'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String, dynamic>ToMap(){
    return{
      'email':email,
      'password':password,
      'uid':uid,
      'phone':phone,
      'name':name,
      'bio':bio,
      'photo':photo,
      'photo_cover':photo_cover,
      'isEmailVerified':isEmailVerified,
    };
  }
}