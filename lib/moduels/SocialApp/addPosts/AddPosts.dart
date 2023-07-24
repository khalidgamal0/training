import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialCubit.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialStates.dart';
import 'package:khalidprojects/shared/commponent/commponent.dart';

import '../../../shared/style/color.dart';

class NewPosts extends StatelessWidget {
  var textcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=SocialCubit.get(context).Usermodel;
        return Scaffold(
          appBar: AppBar(
            leading:IconButton(onPressed: (){
              Navigator.pop(context);
            },
                icon:Icon(Icons.arrow_back_ios)),
            title:Text('Create Post'),
            actions: [
              defaultextbutton(function:(){
                var now=DateTime.now();
                  if(SocialCubit.get(context).post_Image==null){
                    SocialCubit.get(context).createNewPoost(
                        data_time: now.toString(),
                        text: textcontroller.text);
                  }
                  else{
                    SocialCubit.get(context).uploadPostImage(
                        data_time: now.toString(),
                        text: textcontroller.text);
                  }
              }, text:'Post')
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialcreatepostloadingStats)
                   Column(
                     children: [
                       LinearProgressIndicator(),
                       SizedBox(height: 10,),
                     ],
                   ),
                Row(children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:NetworkImage('${cubit!.photo}'),
                  ),
                  SizedBox(width:15),
                  Expanded(
                    child: Text(
                        '${cubit!.name}',style:TextStyle(height: 1.4) ,),
                  ),
                ],),
                SizedBox(height:15),
                Expanded(
                  child: TextFormField(
                    controller:  textcontroller,
                    decoration: InputDecoration(
                      hintText: 'whats is in your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height:20,),
                if(SocialCubit.get(context).post_Image!=null)
                 Column(
                   children: [
                     Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:FileImage(SocialCubit.get(context).post_Image!) as ImageProvider,
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },
                            icon:CircleAvatar(
                                radius: 15,
                                child: Icon(Icons.close,size: 16,))),
                      ],
                ),
                     const SizedBox(height:20,),
                   ],
                 ),

                  Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed:(){
                        SocialCubit.get(context).getpostImage();
                      }, child:Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 5,),
                          Text('add photo'),
                        ],)),
                    ),
                    Expanded(
                        child: TextButton(onPressed:(){}, child:
                        Text('# tags')
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
