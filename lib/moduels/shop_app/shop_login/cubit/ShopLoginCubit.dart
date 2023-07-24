import 'package:bloc/bloc.dart';
import 'package:khalidprojects/models/Shop_app/login_model.dart';
import 'package:khalidprojects/moduels/Shop_app/Shop_login/cubit/ShopLoginStates.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/endpoint.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit():super(ShopLoginInitial());
  static ShopLoginCubit get(context){
        return  BlocProvider.of(context);
  }
  Shop_loginModel? loginmodel;
  void userLogin({
   required String email,
    required String password,
  }){
    emit(ShopLoginLoading());
    diohelper.PostData(
        method_url: LOGIN,   //end point
        data:{
          'email':email,
          'password':password,
        },
    ).then((value){
      print('kkkkk');
          loginmodel=Shop_loginModel.fromJson(value.data);
          emit(ShopLoginSucsess(loginmodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginError());
    });
  }
 bool obscureText=true;
  IconData suffixIcon=Icons.visibility;
  void changepassvisbility(){
    obscureText=!obscureText;
    obscureText?suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(Shopshowpassvisibility());
  }
}
