import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:khalidprojects/models/Shop_app/categorymodel.dart';
import 'package:khalidprojects/models/Shop_app/homemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/ShopApp/cubit/ShopCubit.dart';
import '../../../layout/ShopApp/cubit/ShopStates.dart';
import '../../../shared/style/color.dart';


class Proudcts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition:ShopCubit.get(context).homemodel!=null &&ShopCubit.get(context).categorymodel!=null ,
              builder: (context) =>productBuilsder(ShopCubit.get(context).homemodel!,ShopCubit.get(context).categorymodel!,context) ,
              fallback: (context) => Center(child: CircularProgressIndicator()),);
        },);
  }
  Widget productBuilsder(HomeModel model,CategoryModel catmodel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    CarouselSlider(
    items:model.data!.banners.map((e) =>
        Image(
    image:NetworkImage('${e.image}',),fit: BoxFit.cover,width: double.infinity,) ).toList() ,
    options: CarouselOptions(
    height: 200,
    initialPage: 0,
     enableInfiniteScroll: true,
     autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(seconds: 1),
    // scrollDirection: Axis.horizontal,
    autoPlayCurve: Curves.fastOutSlowIn,
    viewportFraction: 1
    )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categorise',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
            SizedBox(height:20,),
            Container(
              height: 100,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>categoryBuilsder( catmodel.data!.data[index]) ,
                  separatorBuilder: (context, index) =>SizedBox(width:10,),
                  itemCount: catmodel.data!.data.length,
              ),
            ),
            SizedBox(height:20,),
            Text('New Product',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
          ],
        ),
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.72,
          children:List.generate(model.data!.products.length,
                  (index) => productGridBuilsder(model.data!.products[index],context)),
        ),
      ),
    ]),
  );

  Widget productGridBuilsder(productsModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount! !=0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('DISCOUNT',style: TextStyle(
                fontSize: 12,
                color: Colors.white
              ),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                maxLines:2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3),),
              Row(children: [
                Text('${model.price}',
                  style: TextStyle(
                    color: defaultColor,
                  ),),
                SizedBox(width: 5,),
                if(model.discount! !=0)
                Text('${model.old_price}',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                  ),),
                Spacer(),
                IconButton(
                    onPressed: (){
                      ShopCubit.get(context).ChangeFavorite(product_id: model.id!);
                    },
                    icon:CircleAvatar(
                        radius: 15,
                        backgroundColor:ShopCubit.get(context).favorite[model.id]!?defaultColor:Colors.grey ,
                        child: Icon(Icons.favorite_border,color: Colors.white,))
                ),
              ],)
            ],
          ),
        )


    ],),
  );

  Widget categoryBuilsder(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.6),
        child: Text('${model.name}',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,),maxLines: 1,overflow: TextOverflow.ellipsis,),
      ),
    ],
  );
}
