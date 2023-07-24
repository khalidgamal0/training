import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../layout/newsapp/cubit/cubit.dart';
import '../../../layout/newsapp/cubit/states.dart';
import '../../../shared/commponent/commponent.dart';


class business extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newcubit,newstates>(
      listener: (context, state) {},
      builder:(context, state) {
        var list=newcubit.get(context).Business;
         return ScreenTypeLayout (
           mobile: Builder(
             builder: (context){
               newcubit.get(context).isdesktopmethod(false);
               return articalConditionalbuilder(list);
             }),
           desktop:Builder(
             builder:(context) {
               newcubit.get(context).isdesktopmethod(true);
               return Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Expanded(child: articalConditionalbuilder(list)),
                     if(list.length>0)
                       Expanded(
                         child: Container(
                           color:Colors.grey[200],
                           height: double.infinity,
                           padding: EdgeInsets.all(20),
                           child: Text('${list[newcubit.get(context).selecteditem]['title']}'),
                         ),
                       ),
                   ]);
             }
           ),
           breakpoints: ScreenBreakpoints(
             desktop: 1200,
             tablet: 600,
             watch: 600,
           ),
         );
      },
    );
  }
}
