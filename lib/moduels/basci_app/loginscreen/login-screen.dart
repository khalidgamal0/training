
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/commponent/commponent.dart';


class Registerscreen extends StatefulWidget{
  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  var emailfield=TextEditingController();
  var passlfield=TextEditingController();
  var formkey=GlobalKey<FormState>();
  bool showpass=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),

      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:formkey ,
              child: Column(
                children: [
                  Text('Register',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w200,
                  ),
              ),
                  SizedBox(height: 40,),
                  defaulttextformfield(
                      controller: emailfield,
                      type:TextInputType.emailAddress ,
                      labeltext: 'email',
                    prefixIcon:Icons.email,
                    onchanged: (value){
                        print(value);
                    },
                    validate: (value) {
                      if(value.isEmpty){
                        return('email must not empty');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
               defaulttextformfield(controller: passlfield,
                   labeltext: 'password',
                   prefixIcon:Icons.lock,
                   suffixIcon: showpass? Icons.visibility:Icons.visibility_off,
                 type: TextInputType.visiblePassword,
                 obscureText:showpass,
                 suffixpressed: (){
                 setState(() {
                   showpass=!showpass;
                 });
                 },
                 onchanged: (value){
                 print(value);
                 },
                 validate: (value){
                 if(value.isEmpty){
                   return'pass must not empty';
                 }
                 }
               ),
                  SizedBox(height: 20,),
                  defaultMaterialButton(function: (){
                   if(formkey.currentState!.validate()){
                     print(passlfield.text);
                     print(emailfield.text);
                   }
                  }),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('don\'t have email?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:FontWeight.bold,
                      ),),
                      TextButton(onPressed: (){}, child: Text('register now', style: TextStyle(
                        fontSize: 20,

                      ),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}

