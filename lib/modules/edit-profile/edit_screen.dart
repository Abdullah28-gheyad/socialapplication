import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/shared/components/components.dart';
import 'package:socialapplication/shared/styles/iconbroken.dart';

class EditProfile extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
          var cubit = SocialLayoutCubit.get(context) ;
          var profileImage = cubit.profileImage ;
          var coverImage = cubit.coverImage ;
          nameController.text = cubit.userModel.name ;
          phoneController.text = cubit.userModel.phone ;
          bioController.text = cubit.userModel.bio ;
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(onPressed: (){
                  cubit.updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text) ;
                }, child: Text('UPDATE')) ,
                SizedBox(width: 15,) ,
              ],
              leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2),onPressed: (){Navigator.pop(context) ; },),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUpdateProfileUserLoadingState)
                    LinearProgressIndicator() ,
                    if (state is SocialUpdateProfileUserLoadingState)
                      SizedBox(height: 10,) ,

                    Container(
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:  coverImage==null?NetworkImage(cubit.userModel.cover):FileImage(coverImage),
                                          fit: BoxFit.cover,
                                        )
                                    )
                                ),
                              ),
                              CircleAvatar(
                                radius: 15.0,
                                child: IconButton(icon: Icon(IconBroken.Camera ,size: 15,),onPressed: (){
                                  cubit.getCoverImage() ;
                                },),

                              ) ,
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor:Colors.white ,
                            radius: 62.0,

                          ) ,
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundImage:  profileImage==null?NetworkImage(cubit.userModel.image):FileImage(profileImage),
                                radius: 60.0,

                              ),
                              CircleAvatar(
                                radius: 15.0,
                                child: IconButton(icon: Icon(IconBroken.Camera ,size: 15,),onPressed: (){
                                  cubit.getProfileImage() ;
                                },),

                              ) ,
                            ],
                          ) ,

                        ],
                      ),
                    ) ,
                    SizedBox(height: 20.0,) ,
                    if (profileImage!=null||coverImage!=null)
                      Row(
                        children: [
                          if (profileImage!=null)
                             Expanded(
                            child: default_button(function: (){
                              cubit.uploadProfileImage(name:nameController.text, phone: phoneController.text, bio: bioController.text) ;
                              cubit.profileImage=profileImage=null ;
                              cubit.coverImage=coverImage=null ;
                            }, text: 'Upload Profile'),
                          ) , 
                          SizedBox(width: 10.0,) ,
                          if (coverImage!=null)
                            Expanded(
                            child: default_button(function: (){
                              cubit.uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text) ;
                            }, text: 'Upload Cover'),
                          )
                        ],
                      ) ,
                    if (profileImage!=null||coverImage!=null)
                      SizedBox(height: 20.0,)  , 
                    default_Edit_text(
                        Validate: (String value){
                          if (value.isEmpty)
                            return'Name cannot be empty' ;
                          return null ;
                        },
                        controller: nameController,
                        type: TextInputType.text ,
                    hint: 'Name' ,
                      prefix: IconBroken.User ,
                    ) ,
                    SizedBox(height: 10,) ,
                    default_Edit_text(
                      Validate: (String value){
                        if (value.isEmpty)
                          return'Bio cannot be empty' ;
                        return null ;
                      },
                      controller: bioController,
                      type: TextInputType.text ,
                      hint: 'Bio' ,
                      prefix: IconBroken.Info_Circle ,
                    ) ,
                    SizedBox(height: 10,) ,
                    default_Edit_text(
                      Validate: (String value){
                        if (value.isEmpty)
                          return'Phone cannot be empty' ;
                        return null ;
                      },
                      controller: phoneController,
                      type: TextInputType.number ,
                      hint: 'Phone' ,
                      prefix: IconBroken.Call ,
                    ) ,
                  ],
                ),
              ),
            ),
          ) ;
        },

    );
  }
}
