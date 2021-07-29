

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/modules/sociallogin/cubit/states.dart';


class SocialLoginCubit  extends Cubit <SocialLoginStates> {
  SocialLoginCubit ():super(SocialLoginInitialState()) ;
  static SocialLoginCubit get (context)=>BlocProvider.of(context) ;

  void User_Login(
  {
  @required String email ,
  @required String password ,
}
      )
  {
    emit(SocialLoginLoadingState()) ;
    FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print (value.user.uid) ;
      emit(SocialLoginSuccessState(value.user.uid)) ;
    })
    .catchError((error){

      print (error.toString()) ;
      emit(SocialLoginErrorState()) ;
    }) ;
  }
}