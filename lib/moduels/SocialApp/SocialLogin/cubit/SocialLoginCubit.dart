import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:khalidprojects/moduels/SocialApp/SocialLogin/cubit/SocialLoginStates.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/endpoint.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{

  SocialLoginCubit():super(SocialLoginInitial());
  static SocialLoginCubit get(context){
        return  BlocProvider.of(context);
  }

  void userLogin({
    String?email,
    String?password,

  }) {
    emit(SocialLoginLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value) {
      emit(SocialLoginSucsess(value.user!.uid));
    }).catchError((onError){
      emit(SocialLoginError(onError.toString()));
    });
  }
 bool obscureText=true;
  IconData suffixIcon=Icons.visibility;
  void changepassvisbility(){
    obscureText=!obscureText;
    obscureText?suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(Socialshowpassvisibility());
  }
}
