import 'package:khalidprojects/shared/commponent/commponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../moduels/news_app/search/search.dart';
import '../todoapp/newhomelayout/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';

class newsapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newcubit,newstates>(
     listener: (context, state) {},
      builder: (context, state) {
       var cubit =newcubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: (){
                NavigateTo(context, search());
              },
                icon:Icon(Icons.search)),
              IconButton(onPressed: (){
                AppCubit.get(context).ChangeMode();
              },
                  icon:Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.Screens[cubit.currentindex],
          bottomNavigationBar:BottomNavigationBar(
            currentIndex:cubit.currentindex ,
            elevation: 20,
            onTap: (index){
              cubit.changeindex(index);
            },
            items:cubit.bottomitem,
          ),
        );
      },
    );
  }
}
