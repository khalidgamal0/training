import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:khalidprojects/moduels/SocialApp/SocialLogin/cubit/SocialLoginCubit.dart';
import 'package:khalidprojects/moduels/SocialApp/SocialLogin/cubit/SocialLoginStates.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';
import '../../../layout/SocialApp/SocailApp.dart';
import '../../../shared/commponent/commponent.dart';
import '../../../shared/commponent/constent.dart';
import '../Social_register/Social_register.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailcontroller=TextEditingController();
  var passcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginError){
            showToast(message:state.error,state:ToastStates.ERROR  );
          }else if (state is SocialLoginSucsess){
            cahe_helper.setdata(key:'uid',value:state.uid).then((value){
              uid=state.uid;
              NavigateTo(context, SocialHomeLayout());
            });
             showToast(message:uid,state:ToastStates.SUCCESS  );
            NavigateTo(context, SocialHomeLayout());
            Phoenix.rebirth(context);

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
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
                          'login now to communicate with friends',
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
                          suffixIcon:SocialLoginCubit.get(context).suffixIcon,
                          type: TextInputType.emailAddress,
                          obscureText: SocialLoginCubit.get(context).obscureText,
                          suffixpressed: (){
                            SocialLoginCubit.get(context).changepassvisbility();
                          },
                          validate:(value){
                            if(value.isEmpty){
                              return('pass is too short');
                            }
                            return null;
                          },
                          onsubmitted: (value){
                            if (formkey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email:emailcontroller.text,
                                password: passcontroller.text,
                              );
                            }
                          },

                        ),
                        SizedBox(height: 25,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoading,
                          builder: (context) =>  defaultMaterialButton(
                              text:'LOGIN',
                              function:(){
                                if (formkey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
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
                                  NavigateTo(context, Social_Register());
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
