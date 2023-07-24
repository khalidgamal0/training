import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialCubit.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialStates.dart';

import '../../moduels/SocialApp/SocialLogin/SocialLogin.dart';
import '../../moduels/SocialApp/addPosts/AddPosts.dart';
import '../../shared/commponent/commponent.dart';

class SocialHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
   create: (context) => SocialCubit()..getUserData()..getPosts(),
  child: BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if (state is SocialNewsPostStats){
          NavigateTo(context,NewPosts());
        }
      },
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
        return  Scaffold(
          appBar:AppBar(
              leading:IconButton(onPressed: (){ NavigateTo(context,SocialLoginScreen());},
                icon:Icon(Icons.arrow_back),),
              actions: [
                IconButton(onPressed: (){}, icon:Icon(Icons.notifications),),
                IconButton(onPressed: (){}, icon:Icon(Icons.search),)],
            title:Text(cubit.titles[cubit.currentindex]),
          ),
          body:cubit.BottomnavBar[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentindex,
            onTap: (index){
              cubit.ChangeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon:Icon(Icons.chat),label: 'Chats'),
              BottomNavigationBarItem(icon:Icon(Icons.add_circle_outline_outlined),label: 'add post'),
              BottomNavigationBarItem(icon:Icon(Icons.person),label: 'users'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings'),
            ],
          ),
        );
      },
    ),
);
  }
}
