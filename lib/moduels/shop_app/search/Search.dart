import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/moduels/Shop_app/search/cubit/searchStates.dart';

import '../../../layout/ShopApp/cubit/ShopCubit.dart';
import '../../../shared/commponent/commponent.dart';
import 'cubit/searchcubit.dart';

class Search extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return  Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      defaulttextformfield(
                          controller: searchcontroller,
                          labeltext: 'search',
                          prefixIcon: Icons.search,
                          type:TextInputType.text,
                          validate: (value){
                            if(value.isEmpty){
                              return 'search must not empty';
                            }
                          },
                          onsubmitted: (text){
                            SearchCubit.get(context).getsearch(text);
                          }
                      ),
                      SizedBox(height: 20,),
                      if(state is searchloading)
                      LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      if(state is searcsuccess)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder:(context, index) => BuildProductItemsearch(SearchCubit.get(context).searchmodel!.data!.data[index],context,isoldprise: false),
                            separatorBuilder: (context, index) => mydivider(),
                            itemCount:SearchCubit.get(context).searchmodel!.data!.data.length),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
