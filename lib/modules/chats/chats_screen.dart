import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/models/usermodel/usermodel.dart';
import 'package:socialapplication/modules/chatdetails/chatdetails.dart';
import 'package:socialapplication/shared/components/components.dart';

class Chat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialLayoutCubit.get(context) ;
        return ConditionalBuilder(
          builder: (context)=>Expanded(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>createItemMessanger(context,cubit.users[index]),
                    separatorBuilder: (context,index)=>Column(
                      children: [
                        SizedBox(height: 10.0,),
                        Container(width: double.infinity,
                          height: 1,
                          color: Colors.grey[300],),
                        SizedBox(height: 10.0,),
                      ],
                    ),
                    itemCount:cubit.users.length)
            ),
          ),
          condition: cubit.users.length>0,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        ) ;
      },
    ) ;
  }
  Widget createItemMessanger(context,UserModel userModel)=>InkWell(
    onTap: (){
      Navigateto(context, ChatDetailsScreen(userModel)) ;
    },
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage:NetworkImage(userModel.image) ,
          radius: 25,
        ) ,
        SizedBox(width: 15,) ,
        Expanded(child: Text(userModel.name)) ,
      ],
    ),
  ) ;
}
