
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/socialscreen.dart';
import 'package:socialapplication/modules/register/register_screen.dart';
import 'package:socialapplication/shared/components/components.dart';
import 'package:socialapplication/shared/network/local/cash_helper.dart';


import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>() ;
  TextEditingController Email_controller = TextEditingController() ;
  TextEditingController Password_controller = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer <SocialLoginCubit ,SocialLoginStates>(
       listener: (context , states){
         if (states is SocialLoginSuccessState)
           {
             CachHelper.saveData(key: 'uId', value: states.uId)
                 .then((value){
                Navigatetoandremove(context, SocialLayout())    ;
             });
           }
       },
        builder: (context , states){
         return Scaffold(
           appBar: AppBar(),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formkey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'LOGIN' , style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black , fontWeight: FontWeight.bold),
                       ),
                       Text(
                         'login to Communicate with Friends' , style: Theme.of(context).textTheme.bodyText1.copyWith(
                           color: Colors.grey
                       ),
                       ) ,
                       SizedBox(height: 30.0,),
                       default_Edit_text(
                           Validate: (String value){
                             if (value.isEmpty)
                               return 'Please Enter Your Email' ;
                             return null ;
                           },
                           controller: Email_controller,
                           type: TextInputType.emailAddress ,
                           prefix: Icons.email,
                           hint: 'Email'
                       ),
                       SizedBox(height: 15.0,),
                       default_Edit_text(
                           Validate: (String value){
                             if (value.isEmpty)
                               return 'Please Enter Your Password' ;
                             return null ;
                           },
                           controller: Password_controller,
                           type: TextInputType.text ,
                           prefix: Icons.lock,
                           suffix: Icons.remove_red_eye,
                           suffixpress: (){},
                           obsecure: true,
                           hint: 'Password' ,
                         onsubmit: (value){
                           if (formkey.currentState.validate())
                           {
                            // shop_app_login_cubit.get(context).User_login(email: Email_controller.text, password: Password_controller.text);
                           }

                         } ,

                       ) ,
                       SizedBox(height: 20.0,) ,
                       Center(
                         child: ConditionalBuilder(
                           condition: states is! SocialLoginLoadingState,
                           fallback:(context)=> CircularProgressIndicator(),
                           builder: (context)=>default_button(
                               function: (){
                                 if (formkey.currentState.validate())
                                   {
                                     SocialLoginCubit.get(context).User_Login(email: Email_controller.text, password: Password_controller.text);
                                   }

                               },
                               text: 'LOGIN'),
                         ),
                       ),
                       SizedBox(height: 20.0,) ,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Don't Have an account? ") ,
                           TextButton(onPressed: (){
                             Navigateto(context, Register_screen()) ;
                           }, child: Text('REGISTER NOW !'))
                         ],
                       )
                     ],
                   ),
                 ),
               ),
             ),
           ),
         ) ;
        },
      ),
    );
  }
}
