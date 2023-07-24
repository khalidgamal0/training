import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/ShopApp/cubit/ShopCubit.dart';
import '../../../layout/ShopApp/cubit/ShopStates.dart';
import '../../../models/Shop_app/favoriteModel.dart';
import '../../../shared/commponent/commponent.dart';
import '../../../shared/style/color.dart';

class Favourite extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          // condition:ShopCubit.get(context).favoritesModel !=null&& state is! Shoploadinggetfavorite,
          condition:ShopCubit.get(context).favoritesModel !=null&&ShopCubit.get(context).homemodel!=null,
          builder:(context) =>ListView.separated(
              itemBuilder:(context, index) => BuildProductItem(ShopCubit.get(context).favoritesModel!.data!.data[index].product!,context),
              separatorBuilder: (context, index) => mydivider(),
              itemCount:ShopCubit.get(context).favoritesModel!.data!.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
