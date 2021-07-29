import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/modules/sociallogin/Login.dart';
import 'package:socialapplication/shared/components/components.dart';
import 'package:socialapplication/shared/components/constants.dart';
import 'package:socialapplication/shared/styles/iconbroken.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialLayoutCubit.get(context) ;
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.current_index]),
            actions: [
              IconButton(icon: Icon(IconBroken.Notification), onPressed: (){}) ,
              IconButton(icon:  Icon(IconBroken.Search), onPressed: (){}) ,
              IconButton(icon: Icon(IconBroken.Logout), onPressed: (){
                uId=='' ;
                Navigatetoandremove(context, SocialLoginScreen()) ;
              })
            ],
          ),
          body: ConditionalBuilder(
            condition: SocialLayoutCubit.get(context).userModel!=null,
            builder: (context)=> Column(
              children: [
                    cubit.Screens[cubit.current_index]
              ],
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeNavBarBotton(index,context) ;
            },
            currentIndex: cubit.current_index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home ) , label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat ) , label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper ) , label: 'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location ) , label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting ) , label: 'Settings'
              )
            ],
          ),
        ) ;
      },
    );
  }
}
