import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/SocialApp/cubit/SocialCubit.dart';
import '../../../layout/SocialApp/cubit/SocialStates.dart';
import '../../../shared/commponent/commponent.dart';
import '../../../shared/commponent/constent.dart';
import '../SocialLogin/SocialLogin.dart';
import '../editProfile/EditProfile.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var userData=SocialCubit.get(context).Usermodel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.only(
                                topLeft: Radius.circular(.5),
                                topRight: Radius.circular(.5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:NetworkImage('${userData!.photo_cover}')

                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:NetworkImage('${userData.photo}'),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height:25),
                  Text('${userData.name}',style: Theme.of(context).textTheme.bodyText1,),
                  SizedBox(height:10),
                  Text('${userData.bio}',style: Theme.of(context).textTheme.caption,),
                  SizedBox(height:25),
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        child: Column(children: [
                          Text('100'),
                          SizedBox(height:10),
                          Text('post',style: TextStyle(color: Colors.grey),),
                        ],),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(children: [
                          Text('25'),
                          SizedBox(height:10),
                          Text('photo',style: TextStyle(color: Colors.grey),),
                        ],),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(children: [
                          Text('126'),
                          SizedBox(height:10),
                          Text('fllowers',style: TextStyle(color: Colors.grey),),
                        ],),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(children: [
                          Text('10k'),
                          SizedBox(height:10),
                          Text('fllowing',style: TextStyle(color: Colors.grey),),
                        ],),
                        onTap: (){},
                      ),
                    ),
                  ],),
                  SizedBox(height:25),
                  Row(
                    children: [
                      Expanded(child: OutlinedButton(onPressed:(){},child:Text('Add Photo'))),
                     SizedBox(width: 15,),
                      OutlinedButton(onPressed:(){
                        NavigateTo(context,EditProfile());
                      }, child:Icon(Icons.edit,size: 16,)),
                    ],
                  ),
                  SizedBox(height:25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    OutlinedButton(onPressed:(){
                      FirebaseMessaging.instance.subscribeToTopic('anounsments');
                    }, child:Text('subscribe') ),
                    SizedBox(width:25),
                    OutlinedButton(onPressed:(){
                      FirebaseMessaging.instance.unsubscribeFromTopic('anounsments');
                    }, child:Text('unsubscribe') ),
                  ],),
                  SizedBox(height:20),
                  defaultMaterialButton(text: 'Logout', function:(){signOut(context,SocialLoginScreen(),'uid');})
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
