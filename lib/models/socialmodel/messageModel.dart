class MessageModel{
  String ?senderid;
  String?reciverid;
  String?datetime;
  String?text;

  MessageModel({
    this.senderid,
    this.reciverid,
    this.datetime,
    this.text,
  });
  MessageModel.fromjson(Map<String,dynamic>json){
    senderid=json['senderid'];
    reciverid=json['reciverid'];
    datetime=json['datetime'];
    text=json['text'];
  }
  Map<String, dynamic>ToMap(){
    return{
      'senderid':senderid,
      'reciverid':reciverid,
      'datetime':datetime,
      'text':text,
    };
  }
}