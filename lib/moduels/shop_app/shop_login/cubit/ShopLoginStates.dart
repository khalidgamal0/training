import '../../../../models/Shop_app/login_model.dart';

abstract class ShopLoginStates{}
 class ShopLoginInitial extends ShopLoginStates{}

 class ShopLoginLoading extends ShopLoginStates{}
 class ShopLoginSucsess extends ShopLoginStates{
 final Shop_loginModel? loginmodel;
 ShopLoginSucsess(this.loginmodel);
 }
 class ShopLoginError extends ShopLoginStates{}
class Shopshowpassvisibility extends ShopLoginStates{}


















