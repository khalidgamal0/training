import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khalidprojects/moduels/SocialApp/Social_register/cubit/SocialRegisterStates.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/socialmodel/SocialUserModel.dart';
import '../../../../shared/network/endpoint.dart';
import '../../../../shared/network/local/cache_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(SocialRegisterInitial());

 static SocialRegisterCubit get(context){
    return BlocProvider.of(context);
  }
  void userRegister({
    String?email,
    String?password,
    String?phone,
    String?name,
  }){
    emit(SocialRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value){
      usercreate(
          name: name,
          email: email,
          password: password,
          phone: phone,
          uid: value.user!.uid);
    }).catchError((error){
      emit(SocialRegisterError(error.toString()));
    });
  }

  void usercreate({
    String?email,
    String?password,
    String?uid,
    String?phone,
    String?name,
  }){
    SocialUserModel model=SocialUserModel(
        name: name,
        email: email,
        password: password,
        phone: phone,
        uid: uid,
        bio: 'write your things',
        photo:'https://media.wired.com/photos/598e35fb99d76447c4eb1f28/16:9/w_2123,h_1194,c_limit/phonepicutres-TA.jpg' ,
        photo_cover:'https://st2.depositphotos.com/2550635/9440/i/450/depositphotos_94407988-stock-photo-silhouette-of-person-in-sportswear.jpg' ,
        isEmailVerified: false
    );
    FirebaseFirestore.instance.collection('users').
    doc(uid).set(model.ToMap()).then((value){
      emit(SocialCreateSucsess(uid));
    }).catchError((error){
      emit(SocialCreateError(error.toString()));
    });
  }
  bool obscureText=true;
  IconData suffixIcon=Icons.visibility;
  void changepassvisbility(){
    obscureText=!obscureText;
    obscureText?suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(Socialreshowpassvisibility());
  }
}