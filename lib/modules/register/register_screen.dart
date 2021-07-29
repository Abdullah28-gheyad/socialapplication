import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/socialscreen.dart';
import 'package:socialapplication/modules/register/cubit/cubit.dart';
import 'package:socialapplication/modules/register/cubit/states.dart';
import 'package:socialapplication/shared/components/components.dart';
import 'package:socialapplication/shared/network/local/cash_helper.dart';

class Register_screen extends StatelessWidget {
  var formkey = GlobalKey<FormState>() ;
  TextEditingController Email_controller = TextEditingController() ;
  TextEditingController Password_controller = TextEditingController() ;
  TextEditingController name_controller = TextEditingController() ;
  TextEditingController phone_controller = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit , SocialRegisterState>(
        listener:(context , states) {
          if (states is SocialCreateUserSuccessState)
            {
              CachHelper.saveData(key: 'uId', value: states.uId)
                  .then((value){
                Navigatetoandremove(context, SocialLayout())    ;
              });

            }
        },
        builder: (context , states)=>Scaffold(
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
                        'REGISTER' , style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black , fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'register to Communicate with Friends' , style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey
                      ),
                      ) ,
                      SizedBox(height: 30.0,),
                      default_Edit_text(
                          Validate: (String value){
                            if (value.isEmpty)
                              return 'Please Enter Your name' ;
                            return null ;
                          },
                          controller: name_controller,
                          type: TextInputType.text ,
                          prefix: Icons.person,
                          hint: 'Name'
                      ),
                      SizedBox(height: 20.0,),
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
                      ) ,

                      SizedBox(height: 20.0,),
                      default_Edit_text(
                          Validate: (String value){
                            if (value.isEmpty)
                              return 'Please Enter Your phone' ;
                            return null ;
                          },
                          controller: phone_controller,
                          type: TextInputType.number ,
                          prefix: Icons.phone,
                          hint: 'Phone'
                      ),
                      SizedBox(height: 20.0,) ,
                      Center(
                        child: ConditionalBuilder(
                          condition:states is! SocialRegisterLoadingState,
                          fallback:(context)=> CircularProgressIndicator(),
                          builder: (context)=>default_button(
                              function: (){
                                if (formkey.currentState.validate())
                                {
                                    SocialRegisterCubit.get(context).userRegister(name: name_controller.text, email: Email_controller.text, password: Password_controller.text, phone: phone_controller.text) ;
                                }

                              },
                              text: 'REGISTER'),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
