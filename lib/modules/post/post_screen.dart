import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/shared/styles/iconbroken.dart';

class PostScreen extends StatelessWidget {

  var textController = TextEditingController() ;
  var datetime = DateTime.now() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){
        if (state is SocialCreatePostSuccessState)
        {
          Fluttertoast.showToast(msg: 'Post Create Successfully' ,backgroundColor: Colors.green ,) ;
          SocialLayoutCubit.get(context).removePostImage() ;
          textController.text='' ;
          SocialLayoutCubit.get(context).getPosts().then((value) {

          }).catchError((error)
            {
              print(error.toString()) ;
            }
          ) ;

        }
        if (state is SocialGetPostsSuccessState)
        {
          Navigator.pop(context) ;
        }
      },
      builder: (context,state){
        var cubit = SocialLayoutCubit.get(context) ;
        return Scaffold(
            appBar: AppBar(
              title: Text('New Post'),
              leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2),onPressed: (){
                Navigator.pop(context) ;
              },),
              actions: [
                TextButton(onPressed: (){
                  if (cubit.postImage!=null)
                    {
                      cubit.uploadPostImage(date: datetime.toString(), text: textController.text) ;
                    }
                  else
                    {
                      cubit.createPost(date: datetime.toString(), text: textController.text) ;
                    }
                }, child: Text('POST'))
              ],
            ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator() ,
                if (state is SocialCreatePostLoadingState)
                  SizedBox(height: 20.0,) ,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(cubit.userModel.image),
                    ) ,
                    SizedBox(width: 15,) ,
                    Expanded(child: Text(cubit.userModel.name))
                  ],

                ) ,
                Expanded(
                  child: TextFormField(
                    controller: textController ,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind...'  ,
                      border: InputBorder.none
                    ),
                  ),
                ) ,
                if (cubit.postImage!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image(
                        image: FileImage(cubit.postImage) ,
                      width: double.infinity,
                      height: 150,
                        fit: BoxFit.cover,
                ),
                      IconButton(icon: Icon(Icons.close , color: Colors.yellow , size: 30,), onPressed: (){
                        cubit.removePostImage() ;
                      })
                    ],
                  ) ,

                Row(
                  children: [
                    Expanded(child: TextButton(onPressed: (){
                      cubit.getPostImage() ;
                    }, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Image) ,
                        SizedBox(width: 5,) ,
                        Text('add photo') ,

                      ],
                    ))) ,

                    Expanded(child: TextButton(onPressed: (){}, child: Text('# tags'))) ,
                  ],
                )
              ],
            ),
          ),
        ) ;
      },
    );
  }
}
