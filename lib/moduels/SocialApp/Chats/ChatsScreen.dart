import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialCubit.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialStates.dart';

import '../../../models/socialmodel/SocialUserModel.dart';
import '../../../shared/commponent/commponent.dart';
import '../chat_details/Chat_detailsScreen.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).all_users.length>0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>BuildItem(context,SocialCubit.get(context).all_users[index]),
              separatorBuilder: (context, index) => mydivider(),
              itemCount: SocialCubit.get(context).all_users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    )  ;
  }

  Widget BuildItem(context,SocialUserModel model)=> InkWell(
    onTap: (){
      NavigateTo(context, ChatDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:NetworkImage('${model.photo}'),
        ),
        SizedBox(width:15),
        Text('${model.name}',style:TextStyle(height: 1.4) ,),

      ],),
    ),
  );

}


