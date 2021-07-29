import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/models/chatmodel/chatmodel.dart';
import 'package:socialapplication/models/postmodel/postmodel.dart';
import 'package:socialapplication/models/usermodel/usermodel.dart';
import 'package:socialapplication/modules/chats/chats_screen.dart';
import 'package:socialapplication/modules/feeds/feeds_screen.dart';
import 'package:socialapplication/modules/post/post_screen.dart';
import 'package:socialapplication/modules/settings/settings_screen.dart';
import 'package:socialapplication/modules/users/users_screen.dart';
import 'package:socialapplication/shared/components/components.dart';
import 'package:socialapplication/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialLayoutCubit extends Cubit <SocialLayoutStates> {
  SocialLayoutCubit() :super(SocialInitialState());

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.FromJson(value.data());
      print(value.data());
      emit(SocialGetUserDataSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorState());
    });
  }

  List <Widget> Screens =
  [
    Feeds(),
    Chat(),
    PostScreen(),
    Users(),
    Setting()
  ];
  List <String> Titles =
  [
    'Home',
    'Chat',
    'Post',
    'Users',
    'Settings',
  ];


  int current_index = 0;

  void changeNavBarBotton(int index, context) {
    if (index==1)
      getAllUsers() ;
    if (index == 2) {
      Navigateto(context, PostScreen());
    }
    else {
      current_index = index;
      emit(SocialChangeNavBarState());
    }
  }


  File profileImage;
  final picker = ImagePicker();

  Future <void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else {
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverImage;


  Future <void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else {
      emit(SocialProfileImagePickedErrorState());
    }
  }

  uploadProfileImage({
    @required name,
    @required phone,
    @required bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage.toString())
        .pathSegments
        .last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
        print(value);
        emit(SocialUploadProfileImageSuccessState());
      })
          .catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  uploadCoverImage({
    @required name,
    @required phone,
    @required bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage.toString())
        .pathSegments
        .last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        emit(SocialUploadCoverImageSuccessState());
      })
          .catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    @required name,
    @required phone,
    @required bio,
    String image,
    String cover,
  }) {
    UserModel userModel2 = UserModel(
        name: name,
        bio: bio,
        phone: phone,
        cover: cover ?? userModel.cover,
        image: image ?? userModel.image,
        isEmailVerified: false,
        password: userModel.password,
        email: userModel.email,
        uid: userModel.uid
    );
    emit(SocialUpdateProfileUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .update(userModel2.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUpdateProfileUserErrorState());
    });
  }

  File postImage;
  Future <void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialGetPostImageSuccessState());
    }
    else {
      emit(SocialGetPostImageErrorState());
    }
  }

  void removePostImage()
  {
    postImage=null ;
    emit(SocialRemovePostImageState()) ;
  }


  void uploadPostImage(
      {
        @required String date ,
        @required String text ,
      }
      )
  {
     emit(SocialUploadPostImageLoadingState())  ;
     FirebaseStorage.instance
     .ref()
     .child('posts/${Uri.file(postImage.toString()).pathSegments.last}')
     .putFile(postImage)
     .then((value){
       value.ref.getDownloadURL()
           .then((value){
             createPost(date: date, text: text , image: value) ;
       })
           .catchError((error){
             emit(SocialCreatePostErrorState()) ;
       }) ;
     })
     .catchError((error){
       emit(SocialCreatePostErrorState()) ;
     }) ;
  }
  void createPost(
  {
    @required String date ,
    @required String text ,
     String image ,
}
      )
  {
    emit(SocialCreatePostLoadingState()) ;
    PostModel postModel = PostModel(postDate: date,postImage: image??'',postText: text,userId: userModel.uid,userImage: userModel.image,userName: userModel.name) ;
    FirebaseFirestore.instance
    .collection('posts')
    .add(postModel.toMap())
    .then((value){

      emit(SocialCreatePostSuccessState()) ;
    })
    .catchError((error){
      print(error.toString()) ;
      emit(SocialCreatePostErrorState()) ;
    }) ;
  }

  List<PostModel> posts = [] ;
  List<String> postId = [] ;
 // List<int> postLikes = [] ;
  Future <void> getPosts()
  {
    posts = [] ;
    emit(SocialGetPostsLoadingState()) ;
    FirebaseFirestore.instance
    .collection('posts')
    .get()
    .then((value){
      value.docs.forEach((element) {
        // element.reference.collection('likes')
        // .get()
        // .then((value) {
        //   //postLikes.add(value.docs.length) ;
        // })
        // .catchError((error)
        // {
        //
        // }) ;
        postId.add(element.id) ;
        posts.add(PostModel.FromJson(element.data())) ;
      }) ;
      emit(SocialGetPostsSuccessState()) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(SocialGetPostsErrorState()) ;
    }) ;
  }


  void likePost(String postId)
  {
   emit(SocialPostLikeLoadingState()) ;
   FirebaseFirestore.instance
   .collection('posts')
   .doc(postId)
   .collection('likes')
   .doc(userModel.uid)
   .set({
     'like':true
   })
   .then((value){
     emit(SocialPostLikeSuccessState()) ;
   })
   .catchError((error){
     print (error.toString()) ;
     emit(SocialPostLikeErrorState()) ;
   }) ;
  }

  List <UserModel> users = [] ;
  void getAllUsers()
  {
    users=[] ;
    emit(SocialGetAllUsersLoadingState()) ;
    FirebaseFirestore.instance
    .collection('users')
    .get()
    .then((value){
      value.docs.forEach((element) {
        if (userModel.uid!=element.data()['uid'])
          users.add(UserModel.FromJson(element.data())) ;
        emit(SocialGetAllUsersSuccessState()) ;
      }) ;
    })
    .catchError((error){
      print(error.toString()) ;
      emit(SocialGetAllUsersErrorState()) ;
    }) ;
  }

  void sendMessage(
  {
  @required String date ,
  @required String reciever_id ,
  @required String message ,
}
      )
  {
    ChatModel chatModel = ChatModel(datetime: date,recieverId: reciever_id , senderId: userModel.uid,text: message) ;
    emit(SocialSendMessageLoadingState()) ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.uid)
    .collection('chats')
    .doc(reciever_id)
    .collection('message')
    .add(chatModel.toMap())
    .then((value){
      emit(SocialSendMessageSuccessState()) ;
    })
    .catchError((error)
        {
          print(error.toString()) ;
          emit(SocialSendMessageErrorState()) ;
        }) ;

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciever_id)
        .collection('chats')
        .doc(userModel.uid)
        .collection('message')
        .add(chatModel.toMap())
        .then((value){
      emit(SocialSendMessageSuccessState()) ;
    })
        .catchError((error)
    {
      print(error.toString()) ;
      emit(SocialSendMessageErrorState()) ;
    }) ;


  }
  
  List<ChatModel> chats = [] ;
  void getMessage(
  {
  @required reciever_id ,
}
      )
  {

    emit (SocialGetMessageLoadingState()) ; 
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.uid)
    .collection('chats')
    .doc(reciever_id)
    .collection('message')
    .orderBy('datetime')
    .snapshots()
    .listen((event) {
      chats=[] ;
      event.docs.forEach((element) {
        chats.add(ChatModel.FromJson(element.data())) ;
      });
      emit(SocialGetMessageSuccessState()) ;
    }) ;

  }

}