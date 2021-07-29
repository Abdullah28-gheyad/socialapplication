import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/models/chatmodel/chatmodel.dart';
import 'package:socialapplication/models/usermodel/usermodel.dart';
import 'package:socialapplication/shared/styles/iconbroken.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messageController = TextEditingController() ;
  final UserModel usermodel;
  ChatDetailsScreen(this.usermodel) ; 
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialLayoutCubit.get(context).getMessage(reciever_id: usermodel.uid) ;
        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = SocialLayoutCubit.get(context) ;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2),onPressed: (){
                  Navigator.pop(context) ;
                },),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(usermodel.image),
                    ) ,
                    SizedBox(width: 10,) ,
                    Text(usermodel.name) ,
                  ],
                ),
              ),
              body: ConditionalBuilder(
                builder: (context)=> Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated
                          (itemBuilder: (context,index){
                            if (cubit.userModel.uid==cubit.chats[index].senderId)
                                return build_my_message(cubit.chats[index]) ;
                            return build_message(cubit.chats[index]);
                        },
                            separatorBuilder: (context,index)
                            {
                              return SizedBox(
                                height: 10.0,
                              );
                            },
                            itemCount:cubit.chats.length),
                      ) ,
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300] ,
                            ) ,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            SizedBox(width: 5.0,) ,
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    hintText: 'type your message here ...' ,
                                    border: InputBorder.none
                                ),
                              ),
                            ) ,
                            Container(
                              height: 40,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: (){
                                  cubit.sendMessage(
                                      date: DateTime.now().toString(),
                                      reciever_id: usermodel.uid,
                                      message: messageController.text) ;
                                  messageController.text='' ;
                                } ,
                                minWidth: 1,
                                child: Icon(IconBroken.Send, size: 15, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                condition: cubit.chats.length>=0,
                fallback: (context)=>Center(child: CircularProgressIndicator()),
              ),
            )  ;
          },
        );

      },

    );
  }

  Widget build_message(ChatModel chatModel)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15) ,
              topLeft: Radius.circular(15) ,
              topRight: Radius.circular(15) ,
            )
        ),
        child: Text(chatModel.text)
    ),
  ) ;
  Widget build_my_message(ChatModel chatModel)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15) ,
              topLeft: Radius.circular(15) ,
              topRight: Radius.circular(15) ,
            )
        ),
        child: Text(chatModel.text)
    ),
  );
}
