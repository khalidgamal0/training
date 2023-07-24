import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/todoapp/newhomelayout/cubit/cubit.dart';
import '../../../layout/todoapp/newhomelayout/cubit/states.dart';
import '../../../shared/commponent/commponent.dart';



class newtask extends StatelessWidget {
  const newtask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
     builder: (context, state) {
        var task=AppCubit.get(context).task;
       return ConditionalBuild(task: task);

     },
    );
  }
}
