import 'package:bloc/bloc.dart';
import 'package:khalidprojects/layout/ShopApp/cubit/ShopStates.dart';
import 'package:khalidprojects/models/Shop_app/favoriteModel.dart';
import 'package:khalidprojects/models/Shop_app/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';

import '../../../models/Shop_app/categorymodel.dart';
import '../../../models/Shop_app/ChangefavoriteModel.dart';
import '../../../models/Shop_app/homemodel.dart';
import '../../../moduels/Shop_app/categorise/Categorise.dart';
import '../../../moduels/Shop_app/favourite/Favourite.dart';
import '../../../moduels/Shop_app/product/Products.dart';
import '../../../moduels/Shop_app/settings/Settings.dart';
import '../../../shared/commponent/constent.dart';
import '../../../shared/network/endpoint.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context){
    return BlocProvider.of(context);
  }

  List<Widget>bottomScreens=[Proudcts(),Categorise(),Favourite(),Settings()];
  int currentindex =0;
  void changeBottomIndex(index){
    currentindex=index;
    emit(ShopBottomNavIndexState());
  }

  HomeModel? homemodel;
  Map<int,bool>favorite={};
  void getHomeData(){
    emit(ShopLoadingHome());
    diohelper.getData(method_url: Home,token:token ).then((value){
      homemodel= HomeModel.fromjson(value.data);
      // print(homemodel!.data!.banners[0].image);
      // print(homemodel!.status);
      homemodel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id!:element.in_favorites!
        });
      });
      print(favorite);
      emit(ShopSuccsessHome());
    }).catchError((error){
      print(error);
      emit(ShopFailHome());
    });
  }

  CategoryModel? categorymodel;
  void getcategoryData(){
    diohelper.getData(method_url:Category).then((value){
      categorymodel= CategoryModel.fromjson(value.data);
      emit(ShopSuccsessCategory ());
    }).catchError((error){
      print(error);
      emit(ShopFailCategory());
    });
  }


  ChangeFavoriteModel?changefavoritModel;
  void ChangeFavorite({required int product_id}){
    favorite[product_id]=!favorite[product_id]!;
    emit(ShopChangefavorite());
    diohelper.PostData(
        method_url:Favorites,
        data: {
      'product_id':product_id
    },
      token: token
    ).then((value)
    {
      changefavoritModel=ChangeFavoriteModel.fromjson(value.data);
      print(changefavoritModel!.message!);
      if(changefavoritModel!.status! == false){
        favorite[product_id]=!favorite[product_id]!;
      }else{
        getFavoritesData();
      }
      emit(ShopSuccsessChangefavorite());
    }).catchError((error)
    {
      favorite[product_id]=!favorite[product_id]!;
      print(error.toString());
      emit(ShopFailChangefavorite());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(Shoploadinggetfavorite());
    diohelper.getData(method_url:Favorites,token: token).then((value){
      favoritesModel= FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccsessgetfavorite ());
    }).catchError((error){
      print(error);
      emit(ShopFailgetfavorite());
    });
  }

  Shop_loginModel? UserModel;
  void getUserDatatosettingscreen(){
    emit(ShoploadingUserData());
    diohelper.getData(
        method_url:PROFILE,
      token: token,
    ).then((value){
      UserModel= Shop_loginModel.fromJson(value.data);
      // printFullText(UserModel!.data!.name.toString());
      emit(ShopSuccsessUserData ());
    }).catchError((error){
      print(error);
      emit(ShopFailUserData());
    });
  }

  void updateUserDatatosettingscreen({
    String? name,
    String? email,
    String? phone,
  }){
    emit(ShopupdateloadingUserData());
    diohelper.PutData(
      method_url:UpdateProfile,
      token: token,
      data: {
    'name':name,
    'email':email,
    'phone':phone,
      }
    ).then((value){
      UserModel= Shop_loginModel.fromJson(value.data);
      // printFullText(UserModel!.data!.name.toString());
      emit(ShopupdateSuccsessUserData ());
    }).catchError((error){
      print(error);
      emit(ShopupdateFailUserData());
    });
  }

}