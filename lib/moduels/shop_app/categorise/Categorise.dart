import 'package:khalidprojects/layout/ShopApp/cubit/ShopCubit.dart';
import 'package:khalidprojects/layout/ShopApp/cubit/ShopStates.dart';
import 'package:khalidprojects/models/Shop_app/categorymodel.dart';
import 'package:khalidprojects/shared/commponent/commponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categorise extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder:(context, index) => buildCatItem(ShopCubit.get(context).categorymodel!.data!.data[index]),
            separatorBuilder: (context, index) => mydivider(),
            itemCount: ShopCubit.get(context).categorymodel!.data!.data.length);
      },
    );
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Spacer(),
      Icon(Icons.arrow_forward_ios_sharp)
    ],),
  );
}
