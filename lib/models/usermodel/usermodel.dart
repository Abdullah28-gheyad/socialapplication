class UserModel
{
  String name ;
  String email ;
  String password ;
  String uid ;
  String phone ;
  bool isEmailVerified ;
  String image ;
  String bio ;
  String cover ;
  UserModel({this.uid,this.email,this.phone,this.name,this.password,this.isEmailVerified,this.cover,this.image,this.bio}) ;
  UserModel.FromJson(Map <String,dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    password=json['password'];
    uid=json['uid'];
    phone=json['phone'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
  }

  Map <String,dynamic> toMap()
  {
    return
      {
        'name':name ,
        'email':email ,
        'password':password ,
        'uid':uid ,
        'phone':phone ,
        'isEmailVerified':isEmailVerified ,
        'image':image ,
        'bio':bio ,
        'cover':cover ,
      };
  }
}