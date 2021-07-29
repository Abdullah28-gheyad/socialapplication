import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapplication/layout/cubit/cubit.dart';
import 'package:socialapplication/layout/cubit/states.dart';
import 'package:socialapplication/models/postmodel/postmodel.dart';
import 'package:socialapplication/shared/styles/iconbroken.dart';

class Feeds extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialLayoutCubit.get(context) ;
        return ConditionalBuilder(
          builder: (context)=>Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        Image(
                          image: NetworkImage('https://image.freepik.com/free-photo/close-up-portrait-blithesome-girl-with-flower-hair-carefree-black-haired-white-woman_197531-14004.jpg'),
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,

                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('communicate with friends' , style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                        )
                      ],
                    ),
                  ) ,
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>buildPostItem(cubit.posts[index],context,index),
                      separatorBuilder: (context,index)=>SizedBox(height: 8.0,)
                      , itemCount: cubit.posts.length) ,
                  SizedBox(height: 8.0,) ,
                ],
              ),
            ),
          ),
          condition: cubit.posts.length>=0&&cubit.userModel!=null,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        ) ;
      },
    );
  }



  Widget buildPostItem(PostModel postModel,context , int index)=>Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(postModel.userImage),
                radius: 20.0,

              ) ,
              SizedBox(width: 15.0,) ,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(postModel.userName , style: TextStyle(height: 1.3),),
                        SizedBox(width: 10.0,) ,
                        Icon(Icons.check_circle,color: Colors.blue ,size: 15,)
                      ],
                    ) ,
                    Text(postModel.postDate,style: Theme.of(context).textTheme.caption,)
                  ],
                ),
              ) ,
              Icon(Icons.more_horiz , size: 15,)
            ],
          ) ,
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10),
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 1,

            ),
          ) ,
          Text(postModel.postText) ,
          if (postModel.postImage!='')
           Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0),
            child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(postModel.postImage),
                      fit: BoxFit.cover,

                    )
                )
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart ,color: Colors.red ,size: 16,) ,
                        SizedBox(width: 5.0,) ,
                        Text('0',style: Theme.of(context).textTheme.caption,)
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
              Expanded(
                child: Container(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat ,color: Colors.amber ,size: 16,) ,
                          SizedBox(width: 5.0,) ,
                          Text('0 comment',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),

                    ),
                  ),
                ),
              ) ,

            ],

          ) ,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(SocialLayoutCubit.get(context).userModel.image),
                        radius: 15.0,

                      ) ,
                      SizedBox(width: 15.0,) ,
                      Text('write a comment...',style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(IconBroken.Heart ,color: Colors.red ,size: 16,) ,
                      SizedBox(width: 5.0,) ,
                      Text('like',style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                ),
                onTap: (){
                  SocialLayoutCubit.get(context).likePost(SocialLayoutCubit.get(context).postId[index]) ;  ;
                },
              ),
            ],
          ) ,
        ],
      ),
    ) ,
  ) ;
}
