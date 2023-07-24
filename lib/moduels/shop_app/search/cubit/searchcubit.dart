import 'package:bloc/bloc.dart';
import 'package:khalidprojects/moduels/Shop_app/search/cubit/searchStates.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/Shop_app/SearchModel.dart';
import '../../../../shared/commponent/constent.dart';
import '../../../../shared/network/endpoint.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit():super(searchintial());
  static SearchCubit get(context){
    return BlocProvider.of(context);
  }

  SearchModel? searchmodel;
  void getsearch(String text,){
    emit(searchloading());

    diohelper.PostData(
        method_url: SEARCH,
        token:token,
        data: {
          'text':text
        }
    ).then((value){
      searchmodel=SearchModel.fromJson(value.data);

      emit(searcsuccess());
    }).catchError((error){
          print(error.toString());

          emit(searcherror());
    }
    );
  }
}
