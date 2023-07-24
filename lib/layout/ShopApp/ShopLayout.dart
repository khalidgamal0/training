import 'package:khalidprojects/layout/ShopApp/cubit/ShopCubit.dart';
import 'package:khalidprojects/layout/ShopApp/cubit/ShopStates.dart';
import 'package:khalidprojects/shared/commponent/commponent.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../moduels/Shop_app/search/Search.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text('salla'),
              actions: [
                IconButton(onPressed: (){
                  NavigateTo(context, Search());
                }, icon:Icon(Icons.search))
              ],
            ),
             body:cubit.bottomScreens[cubit.currentindex],
            bottomNavigationBar:BottomNavigationBar(
            currentIndex:cubit.currentindex,
            onTap: (index){
              cubit.changeBottomIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon:Icon(Icons.favorite),label: 'favorite'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings'),
            ],
          ),
        );
      },

    );
  }
}
