class PostModel
{
  String userId ;
  String userName ;
  String userImage ;
  String postDate ;
  String postText ;
  String postImage ;
  PostModel({this.postImage,this.postDate,this.postText,this.userId,this.userImage,this.userName}) ;
  PostModel.FromJson(Map<String,dynamic>json)
  {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    postDate = json['postDate'];
    postText = json['postText'];
    postImage = json['postImage'];
  }
  Map<String,dynamic> toMap()
  {
    return
        {
          'userId':userId ,
          'userName':userName ,
          'userImage':userImage ,
          'postDate':postDate ,
          'postText':postText ,
          'postImage':postImage ,
        };
  }
}