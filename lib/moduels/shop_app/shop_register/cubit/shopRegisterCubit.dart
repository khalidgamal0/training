import 'package:bloc/bloc.dart';
import 'package:khalidprojects/moduels/Shop_app/Shop_Register/cubit/ShopRegisterStates.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/models/Shop_app/login_model.dart';

import '../../../../shared/network/endpoint.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit():super(ShopRegisterInitial());

 static ShopRegisterCubit get(context){
    return BlocProvider.of(context);
  }
  Shop_loginModel?loginmodel;
  void userLogin({
    String?email,
    String?password,
    String?phone,
    String?name,
  }){
    emit(ShopRegisterLoading());
    diohelper.PostData(
      method_url: REGISTER,   //end point
      data:{
        'email':email,
        'phone':email,
        'name':email,
        'password':password,
      },
    ).then((value){
      print(value.data);
      loginmodel=Shop_loginModel.fromJson(value.data);
      emit(ShopRegisterSucsess(loginmodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterError());
    });
  }
  bool obscureText=true;
  IconData suffixIcon=Icons.visibility;
  void changepassvisbility(){
    obscureText=!obscureText;
    obscureText?suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(Shopreshowpassvisibility());
  }
}