class ChatModel
{
  String senderId ;
  String recieverId ;
  String datetime ;
  String text ;
  ChatModel({
    this.text,this.datetime,this.recieverId,this.senderId
}) ;

  ChatModel.FromJson(Map<String,dynamic>json)
  {
    senderId = json['senderId'];
    recieverId = json['recieverId'];
    datetime = json['datetime'];
    text = json['text'];
  }
  Map<String,dynamic> toMap()
  {
    return
        {
          'senderId':senderId ,
          'recieverId':recieverId ,
          'datetime':datetime ,
          'text':text ,
        };
  }
}