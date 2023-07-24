import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialCubit.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialStates.dart';

import '../../../models/socialmodel/SocialUserModel.dart';
import '../../../models/socialmodel/messageModel.dart';
import '../../../shared/style/color.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messagecontroller=TextEditingController();
  SocialUserModel? model;
  ChatDetailsScreen(this.model);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(recivedid: model!.uid);
        return   BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:NetworkImage('${model!.photo}'),
                  ),
                  SizedBox(width:15),
                  Text('${model!.name}',style:TextStyle(height: 1.4) ,),

                ],),
              ),
              body: ConditionalBuilder(
               condition:SocialCubit.get(context).messages.length>0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Expanded(
                      child: ListView.separated(
                          reverse: true,
                          itemBuilder: (context, index) {
                            var message=SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).Usermodel!.uid==message.senderid)
                              return buildmymessage(message);

                            return buildmessage(message) ;
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 15,),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Expanded(
                        child: TextFormField(
                          controller: messagecontroller,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.grey.withOpacity(.2),width: 1 ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.grey.withOpacity(.2),width: 1 ),
                              borderRadius: BorderRadius.circular(10),
                            ) ,
                            hintText: 'write your message...',
                            suffixIcon:Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  color:defaultColor ,
                                  borderRadius:BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))
                              ),

                              child: IconButton(icon:Icon(Icons.send,size: 16,color: Colors.white,) ,onPressed: (){
                                SocialCubit.get(context).sendMessage(
                                    text: messagecontroller.text,
                                    reciverid: model!.uid,
                                    datetime:DateTime.now().toString());
                                   messagecontroller.clear();
                              }),

                            ),),
                          onFieldSubmitted: (value){
                            messagecontroller.clear();
                          },
                        ),
                      ),
                    )        ]),
                ),
                fallback: (context) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LinearProgressIndicator(),
                      ),
                      SizedBox(height: 440),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Expanded(
                          child: TextFormField(
                            controller: messagecontroller,
                            decoration: InputDecoration(
                              border:OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.grey.withOpacity(.2),width: 1 ),
                                  borderRadius: BorderRadius.circular(10),
                             ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.grey.withOpacity(.2),width: 1 ),
                                borderRadius: BorderRadius.circular(10),
                              ) ,
                              hintText: 'write your message...',
                              suffixIcon:Container(
                                width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color:defaultColor ,
                                    borderRadius:BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))
                                  ),

                                  child: IconButton(icon:Icon(Icons.send,size: 16,color: Colors.white,) ,onPressed: (){
                                    SocialCubit.get(context).sendMessage(
                                        text: messagecontroller.text,
                                        reciverid: model!.uid,
                                        datetime:DateTime.now().toString());
                                  }),

                            ),),
                              onFieldSubmitted: (value){
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            ;
          },
        );
      },

    );
  }
  Widget buildmessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),

            ),
            color: Colors.grey[300]
        ),
        child: Text(model.text!)),
  );
  Widget buildmymessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),

            ),
            color: defaultColor.withOpacity(.2)
        ),
        child: Text(model.text!)),
  );
}