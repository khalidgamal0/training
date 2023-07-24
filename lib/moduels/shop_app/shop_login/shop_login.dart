import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalidprojects/moduels/Shop_app/Shop_login/cubit/ShopLoginStates.dart';
import 'package:khalidprojects/shared/commponent/commponent.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/ShopApp/ShopLayout.dart';
import '../../../layout/ShopApp/cubit/ShopCubit.dart';
import '../../../shared/commponent/constent.dart';
import '../onboarding/OnBoarding.dart';
import '../Shop_register/Shop_register.dart';
import 'cubit/ShopLoginCubit.dart';

class Shop_login extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailcontroller=TextEditingController();
    var passcontroller=TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSucsess){
            if(state.loginmodel!.status!){
              print(state.loginmodel!.message);
              print(state.loginmodel!.data!.token);
              cahe_helper.setdata(key: 'token',value:state.loginmodel!.data!.token!).then((value){
                token=state.loginmodel!.data!.token;
                ShopCubit.get(context).currentindex=0;
                NavigateAndFinish(context,ShopLayout());
              });
            }
            else {
              print(state.loginmodel!.message);
              Fluttertoast.showToast(
                  msg:state.loginmodel!.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: (){NavigateAndFinish(context, OnBoarding());},)),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style:
                          Theme.of(context).textTheme.headline4!.copyWith(color:Colors.blue,) ,),
                        SizedBox(height: 15,),
                        Text(
                          'login now to browes our offers',
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                        SizedBox(height: 35,),
                        defaulttextformfield(
                          controller: emailcontroller,
                          labeltext: 'Email Adress',
                          prefixIcon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          validate: ( value){
                            if(value.isEmpty){
                              return('Email must not empty');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        defaulttextformfield(
                          controller: passcontroller,
                          labeltext: 'enter password',
                          prefixIcon: Icons.lock_outline_sharp,
                          suffixIcon:ShopLoginCubit.get(context).suffixIcon,
                          type: TextInputType.emailAddress,
                          obscureText: ShopLoginCubit.get(context).obscureText,
                          suffixpressed: (){
                            ShopLoginCubit.get(context).changepassvisbility();
                          },
                          onsubmitted: (value){
                            if (formkey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email:emailcontroller.text,
                                password: passcontroller.text,
                              );
                            }
                          },
                          validate:(value){
                            if(value.isEmpty){
                              return('pass is too short');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25,),
                       ConditionalBuilder(
                           condition: state is! ShopLoginLoading,
                           builder: (context) =>  defaultMaterialButton(
                               text:'LOGIN',
                               function:(){
                                 if (formkey.currentState!.validate())
                                 {
                                   ShopLoginCubit.get(context).userLogin(
                                     email:emailcontroller.text,
                                     password: passcontroller.text,

                                   );
                                 }
                               }
                           ),
                           fallback:(context) =>Center(child: CircularProgressIndicator()),
                       ),
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            defaultextbutton(
                                function:(){
                                  NavigateTo(context, Shop_Register());
                                },
                                text: 'register')
                          ],)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
