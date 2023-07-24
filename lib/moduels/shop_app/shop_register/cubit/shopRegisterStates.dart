import '../../../../models/Shop_app/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitial extends ShopRegisterStates{}

class ShopRegisterLoading extends ShopRegisterStates{}
class ShopRegisterSucsess extends ShopRegisterStates{
  final Shop_loginModel? loginmodel;
  ShopRegisterSucsess(this.loginmodel);
}
class ShopRegisterError extends ShopRegisterStates{}
class Shopreshowpassvisibility extends ShopRegisterStates{}
