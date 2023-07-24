import 'package:khalidprojects/layout/ShopApp/cubit/ShopCubit.dart';
import 'package:khalidprojects/layout/ShopApp/cubit/ShopStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/commponent/commponent.dart';
import '../../../shared/commponent/constent.dart';
import '../Shop_login/Shop_login.dart';

class Settings extends StatelessWidget {
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        namecontroller.text=cubit.UserModel!.data!.name!;
        phonecontroller.text=cubit.UserModel!.data!.phone!;
        emailcontroller.text=cubit.UserModel!.data!.email!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(state is ShopupdateloadingUserData)
                  LinearProgressIndicator(),
                SizedBox(height: 20,),
                defaulttextformfield(
                    controller: namecontroller,
                    labeltext: 'Name',
                    prefixIcon: Icons.person,
                    type: TextInputType.name,
                    validate:(value){
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
                    validate:(value){
                      if(value.isEmpty){
                        return'email must not empty';
                      }
                    }
                ),
                SizedBox(height: 20,),

                defaulttextformfield(
                    controller: phonecontroller,
                    labeltext: 'Phone',
                    prefixIcon: Icons.phone,
                    type: TextInputType.phone,
                    validate:(value){
                      if(value.isEmpty){
                        return'phone must not empty';
                      }
                    }
                ),
                SizedBox(height: 20,),
                defaultMaterialButton(text: 'update', function:(){
                  ShopCubit.get(context).updateUserDatatosettingscreen(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    email: emailcontroller.text,
                  );
                }),
                SizedBox(height: 20,),
                defaultMaterialButton(text: 'Logout', function:(){signOut(context,Shop_login(),'token');})
              ],
            ),
          ),
        );
      },

    );
  }
}
