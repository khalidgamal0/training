import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalidprojects/moduels/Shop_app/Shop_Register/cubit/ShopRegisterStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';

import '../../../layout/ShopApp/ShopLayout.dart';
import '../../../layout/ShopApp/cubit/ShopCubit.dart';
import '../../../shared/commponent/commponent.dart';
import '../../../shared/commponent/constent.dart';
import 'cubit/ShopRegisterCubit.dart';

class Shop_Register extends StatelessWidget {
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var namecontroller=TextEditingController();
    var passcontroller=TextEditingController();
    var emailcontroller=TextEditingController();
    var phonecontroller=TextEditingController();


    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if( state is ShopRegisterSucsess){
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
              showToast(
                message: state.loginmodel!.message,
                state: ToastStates.SUCCESS
              );

            }
          }
        },
        builder: (context, state) {
          var cubit=ShopRegisterCubit.get(context);
          return    Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style:
                          Theme.of(context).textTheme.headline4!.copyWith(color:Colors.blue,) ,),
                        SizedBox(height: 15,),
                        Text(
                          'register now to browes our offers',
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                        SizedBox(height: 35,),
                        defaulttextformfield(
                            controller: namecontroller,
                            labeltext: 'Name',
                            prefixIcon: Icons.person,
                            type: TextInputType.name,
                            validate: (value){
                              if(value.isEmpty){
                                return'name must not empty';
                              }
                            }
                        ),
                        SizedBox(height: 20,),
                        defaulttextformfield(
                            controller: emailcontroller,
                            labeltext: 'Email Adress',
                            prefixIcon: Icons.email,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value.isEmpty){
                                return'email must not empty';
                              }
                            }
                        ),
                        SizedBox(height: 20,),
                        defaulttextformfield(
                            controller: passcontroller,
                            labeltext: 'Password',
                            suffixIcon: cubit.suffixIcon,
                            suffixpressed:cubit.changepassvisbility,
                            obscureText:cubit.obscureText,
                            prefixIcon: Icons.lock_outline_sharp,
                            type: TextInputType.name,
                            validate: (value){
                              if(value.isEmpty){
                                return'Password must not empty';
                              }
                            }
                        ),
                        SizedBox(height: 20,),
                        defaulttextformfield(
                            controller: phonecontroller,
                            labeltext: 'Phone',
                            prefixIcon: Icons.phone,
                            type: TextInputType.phone,
                            validate: (value){
                              if(value.isEmpty){
                                return'phone must not empty';
                              }
                            }
                        ),
                        SizedBox(height: 20,),
                        defaultMaterialButton(text: 'register', function:(){
                         if (formkey.currentState!.validate()){
                           cubit.userLogin(
                             name: namecontroller.text,
                             email: emailcontroller.text,
                             phone: phonecontroller.text,
                             password: passcontroller.text,
                           );
                         }
                        })
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
