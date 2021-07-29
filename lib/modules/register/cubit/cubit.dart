
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/models/usermodel/usermodel.dart';
import 'package:socialapplication/modules/register/cubit/states.dart';


class SocialRegisterCubit extends Cubit <SocialRegisterState> {
  SocialRegisterCubit():super(SocialRegisterInitialState()) ;
  static SocialRegisterCubit get (context)=>BlocProvider.of(context) ;

  void userRegister(
  {
  @required String name ,
  @required String email ,
  @required String password ,
  @required String phone ,
}
      )
  {
    emit(SocialRegisterLoadingState()) ;
    FirebaseAuth.instance
    .createUserWithEmailAndPassword
      (email: email, password: password)
    .then((value) {
      print (value.user.email);
      print (value.user.uid);
      emit(SocialRegisterSuccessState()) ;
      userCreate(phone: phone,name: name,email: email,password: password,uId: value.user.uid) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(SocialRegisterErrorState()) ;
    });
  }

  void userCreate(
      {
        @required String name ,
        @required String email ,
        @required String password ,
        @required String phone ,
        @required String uId ,
      }
      )
  {
    UserModel userModel = UserModel(email: email , name: name , password:password ,phone: phone,uid: uId, isEmailVerified: false,image: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg' , bio: 'write your bio...' , cover: 'https://t4.ftcdn.net/jpg/02/97/52/81/240_F_297528198_uu6DjM2ZqSp5y0nXMeo2WsUFOhlyeHeO.jpg'  ) ;
    emit(SocialCreateUserLoadingState()) ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .set(userModel.toMap())
    .then((value) {

      emit(SocialCreateUserSuccessState(uId)) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(SocialCreateUserErrorState()) ;
    });
  }
}