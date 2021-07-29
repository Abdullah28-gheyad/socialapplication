import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/modules/edit-profile/edit_screen.dart';
import 'package:socialapplication/shared/components/components.dart';
import 'package:socialapplication/shared/styles/iconbroken.dart';

class Setting extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
     listener: (context,state){},
     builder: (context,state){
       var cubit = SocialLayoutCubit.get(context) ;
       return ConditionalBuilder(
          condition: cubit.userModel.cover!=null,
         builder: (context){
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(cubit.userModel.cover),
                                    fit: BoxFit.cover,
                                  )
                              )
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:Colors.white ,
                          radius: 62.0,

                        ) ,
                        CircleAvatar(
                          backgroundImage:  NetworkImage(cubit.userModel.image),
                          radius: 60.0,

                        ) ,

                      ],
                    ),
                  ) ,
                  SizedBox(height: 10.0,) ,
                  Text(cubit.userModel.name) ,
                  Text(cubit.userModel.bio ,style: Theme.of(context).textTheme.caption,) ,
                  SizedBox(height: 10.0,) ,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('100') ,
                            SizedBox(height: 5.0,),
                            Text('Posts' ,style: Theme.of(context).textTheme.caption,) ,
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('265') ,
                            SizedBox(height: 5.0,),

                            Text('Photoes' ,style: Theme.of(context).textTheme.caption,) ,
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('10k') ,
                            SizedBox(height: 5.0,),

                            Text('Followers' ,style: Theme.of(context).textTheme.caption,) ,
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('64') ,
                            SizedBox(height: 5.0,),

                            Text('Following' ,style: Theme.of(context).textTheme.caption,) ,
                          ],
                        ),
                      )
                    ],
                  ) ,
                  SizedBox(height: 20.0,) ,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: (){},
                            child: Text('Add Photos',style: TextStyle(color: Colors.blue),)),
                      ),
                      SizedBox(width: 5.0,) ,
                      OutlinedButton(
                        onPressed: (){
                          Navigateto(context, EditProfile()) ;
                        },
                        child: Icon(IconBroken.Edit,size: 15,),
                      )
                    ],
                  )
                ],
              ),
            ) ;
         },
         fallback: (context)=>Center(child: CircularProgressIndicator()),
       ) ;
     },
   );
  }
}
