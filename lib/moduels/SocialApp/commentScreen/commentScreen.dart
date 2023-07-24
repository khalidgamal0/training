import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialCubit.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialStates.dart';

class CommentScreen extends StatelessWidget {
var commentcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:AppBar(),
          body:Column(children: [
            if(commentcontroller.text !='')
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:NetworkImage('${SocialCubit.get(context).Usermodel!.photo}'),
                      ),
                      SizedBox(width:8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[50],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${SocialCubit.get(context).Usermodel!.name}',style:TextStyle(height: 1.4,fontWeight: FontWeight.bold) ,),
                                      SizedBox(height:5,),
                                      Text(commentcontroller.text,style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4,color: Colors.black
                                      ),maxLines:6,overflow: TextOverflow.ellipsis,)
                                    ],),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(children: [
                                InkWell(child: Text('20 m'),onTap: (){},),
                                SizedBox(width: 10,),
                                InkWell(child: Text('like'),onTap: (){},),
                                SizedBox(width: 10,),
                                InkWell(child: Text('reply'),onTap: (){},),

                              ],)
                            ],
                          ),
                        ),
                      ),

                    ],),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color:Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller:commentcontroller ,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'write your comment...',
                      ),
                      onFieldSubmitted: (value){
                        commentcontroller.text=value;
                      },
                    ),
                  ),
                  IconButton(onPressed:(){
                    SocialCubit.get(context).commentpost(SocialCubit.get(context).postid[1],commentcontroller.text);
                  }, icon:Icon(Icons.send))
                ],
              ),
            )

          ]),
        );
      },

    );
  }
  Widget commentitem(context)=>Column(children: [
    // if(commentcontroller.text !='')
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:NetworkImage('${SocialCubit.get(context).Usermodel!.photo}'),
                ),
                SizedBox(width:8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[50],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${SocialCubit.get(context).Usermodel!.name}',style:TextStyle(height: 1.4,fontWeight: FontWeight.bold) ,),
                                SizedBox(height:5,),
                                Text(commentcontroller.text,style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4,color: Colors.black
                                ),maxLines:6,overflow: TextOverflow.ellipsis,)
                              ],),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(children: [
                          InkWell(child: Text('20 m'),onTap: (){},),
                          SizedBox(width: 10,),
                          InkWell(child: Text('like'),onTap: (){},),
                          SizedBox(width: 10,),
                          InkWell(child: Text('reply'),onTap: (){},),

                        ],)
                      ],
                    ),
                  ),
                ),

              ],),
          ],
        ),
      ),
    SizedBox(height: 5,),
    Spacer(),
    Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color:Colors.grey[300],
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller:commentcontroller ,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'write your comment...',
              ),
              onFieldSubmitted: (value){
                commentcontroller.text=value;
              },
            ),
          ),
          IconButton(onPressed:(){
            SocialCubit.get(context).commentpost(SocialCubit.get(context).postid[1],commentcontroller.text);
          }, icon:Icon(Icons.send))
        ],
      ),
    )

  ]);
  }
