class PostModel{
  String?uid;
  String?name;
  String?photo;
  String?data_time;
  String?text;
  String?post_photo;

  PostModel({
    this.uid,
    this.name,
    this.photo,
    this.data_time,
    this.text,
    this.post_photo,

  });
  PostModel.fromjson(Map<String,dynamic>json){
    uid=json['uid'];
    name=json['name'];
    photo=json['photo'];
    data_time=json['data_time'];
    text=json['text'];
    post_photo=json['post_photo'];
  }
  Map<String, dynamic>ToMap(){
    return{
      'uid':uid,
      'name':name,
      'photo':photo,
      'data_time':data_time,
      'text':text,
      'post_photo':post_photo,
    };
  }
}