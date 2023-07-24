import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/todoapp/newhomelayout/cubit/cubit.dart';
import '../../../layout/todoapp/newhomelayout/cubit/states.dart';
import '../../../shared/commponent/commponent.dart';



class done extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var task=AppCubit.get(context).donetask;
        return ConditionalBuild(task: task);
      },
    );
  }
}
