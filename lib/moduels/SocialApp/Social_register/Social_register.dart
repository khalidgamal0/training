import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/moduels/SocialApp/Social_register/cubit/SocialRegisterStates.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';

import '../../../layout/SocialApp/SocailApp.dart';
import '../../../shared/commponent/commponent.dart';
import '../../../shared/commponent/constent.dart';
import 'cubit/SocialRegisterCubit.dart';

class Social_Register extends StatelessWidget {
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var namecontroller=TextEditingController();
    var passcontroller=TextEditingController();
    var emailcontroller=TextEditingController();
    var phonecontroller=TextEditingController();


    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterError){
            showToast(message:state.error,state:ToastStates.ERROR  );
          }else if(state is SocialCreateSucsess){
            cahe_helper.setdata(key:'uid',value:state.uid).then((value){
              uid=state.uid;
              Phoenix.rebirth(context);
              NavigateTo(context, SocialHomeLayout());
            });
            showToast(message:uid,state:ToastStates.SUCCESS  );
          }
        },
        builder: (context, state) {
          var cubit=SocialRegisterCubit.get(context);
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
                          'register now to communicate with friends',
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
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoading,
                          builder: (context) => defaultMaterialButton(text: 'register', function:(){
                            if (formkey.currentState!.validate()){
                              cubit.userRegister(
                                name: namecontroller.text,
                                email: emailcontroller.text,
                                phone: phonecontroller.text,
                                password: passcontroller.text,
                              );
                            }
                          }),
                          fallback:(context) =>Center(child: CircularProgressIndicator()),
                        ),
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
