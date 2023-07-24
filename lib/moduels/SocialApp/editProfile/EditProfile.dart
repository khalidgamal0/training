import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/SocialApp/cubit/SocialStates.dart';

import '../../../layout/SocialApp/cubit/SocialCubit.dart';
import '../../../shared/commponent/commponent.dart';

class EditProfile extends StatelessWidget {
  var namecontroller=TextEditingController();
  var biocontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData=SocialCubit.get(context).Usermodel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;


        namecontroller.text=userData!.name!;
        biocontroller.text=userData.bio!;
        phonecontroller.text=userData.phone!;
        return Scaffold(
          appBar:AppBar(
            leading: IconButton(onPressed: () {Navigator.pop(context);  },
              icon:Icon(Icons.keyboard_arrow_left_outlined),),
            titleSpacing: 0,
            title: Text('Edit Profile'),
            actions:[defaultextbutton(function:(){
              SocialCubit.get(context).updateuserData(
                  name: namecontroller.text,
                  bio: biocontroller.text,
                  phone: phonecontroller.text);
            }, text:'update'),
              SizedBox(width: 10,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if (state is SocialUserUpdateloadingStats)
                   LinearProgressIndicator(),
                SizedBox(height:15),
                Container(
                  height: 250,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.only(
                                  topLeft: Radius.circular(.5),
                                  topRight: Radius.circular(.5),
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:coverImage==null?NetworkImage('${userData.photo_cover}'):
                                    FileImage(coverImage) as ImageProvider,

                                ),
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialCubit.get(context).getcoverImage();
                            },
                                icon:CircleAvatar(
                                    radius: 15,
                                    child: Icon(Icons.camera_alt_outlined,size: 16,))),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:profileImage==null ? NetworkImage('${userData.photo}'):
                            FileImage(profileImage)as ImageProvider,

                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                            ),
                            child: IconButton(onPressed: (){
                              SocialCubit.get(context).getProfileImage();
                            },
                                icon:CircleAvatar(
                                    radius: 15,
                                    child: Icon(Icons.camera_alt_outlined,size: 16,))),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height:25),
                if(SocialCubit.get(context).profileImage!=null||SocialCubit.get(context).coverImage!=null)
                  Column(
                    children: [
                      Row(children: [
                      if(SocialCubit.get(context).profileImage!=null)
                        Expanded(child: Column(
                          children: [
                            defaultMaterialButton(function:(){
                              SocialCubit.get(context).uploadProfileImage(name:namecontroller.text,
                                  phone: phonecontroller.text,
                                  bio: biocontroller.text);
                            }, text:'upload image'),
                            if (state is SocialimageUpdateloadingStats)
                              Column(
                                children: [
                                  SizedBox(height: 5,),
                                  LinearProgressIndicator(),
                                ],
                              ),
                          ],
                        )),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).coverImage!=null)
                        Expanded(child: Column(
                          children: [
                            defaultMaterialButton(function:(){
                              SocialCubit.get(context).uploadcoverImage(name:namecontroller.text,
                                  phone: phonecontroller.text,
                                  bio: biocontroller.text);
                            }, text:'upload cover'),
                            if (state is SocialcoverUpdateloadingStats)
                              Column(
                                children: [
                                  SizedBox(height: 5,),
                                  LinearProgressIndicator(),
                                ],
                              ),
                          ],
                        )),
                ],),
                      SizedBox(height:25),
                    ],
                  ),
                defaulttextformfield(
                    controller:namecontroller,
                    labeltext: 'Name',
                    prefixIcon: Icons.person,
                    type: TextInputType.name,
                    validate:(value){
                      if(value.isEmpty){
                        return'name must not empty';
                      }
                    }),
                SizedBox(height: 15,),
                defaulttextformfield(
                    controller:biocontroller,
                    labeltext: 'Bio',
                    prefixIcon: Icons.info_outline,
                    type: TextInputType.name,
                    validate:(value){
                      if(value.isEmpty){
                        return'bio must not empty';
                      }
                    }),
                SizedBox(height: 15,),
                defaulttextformfield(
                    controller:phonecontroller,
                    labeltext: 'phone',
                    prefixIcon: Icons.phone,
                    type: TextInputType.phone,
                    validate:(value){
                      if(value.isEmpty){
                        return'phone must not empty';
                      }
                    }),


              ],),
            ),
          ),
        );
      },

    );
  }
}
