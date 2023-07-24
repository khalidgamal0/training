import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalidprojects/layout/newsapp/cubit/states.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import '../../../moduels/news_app/business/business.dart';
import '../../../moduels/news_app/scince/scince.dart';
import '../../../moduels/news_app/sports/sports.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';

class newcubit extends Cubit<newstates> {
  newcubit() : super(intialstate());

  static newcubit get(context) {
    return BlocProvider.of(context);
  }

  int currentindex = 0;
  List<BottomNavigationBarItem> bottomitem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeindex(int? index) {
    currentindex = index!;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScince();
    }
    emit(bottomvavigator());
  }

  List<Widget> Screens = [business(), sports(), scince()];

  // List<bool>Businessselecteditem = [];

  int selecteditem = 1;

  void bussinesSelectditem(index) {
    // for(int i=0;i<Businessselecteditem.length;i++ )
    // {
    //   if(i==index)
    //     Businessselecteditem[i]=true;
    //   else
    //     Businessselecteditem[i]=false;
    // }
    selecteditem = index;
    emit(newsbussinceselectitemstate());
  }

  bool? isdesktop;
  void isdesktopmethod(bool value) {
    isdesktop = value;
    emit(newsbussinceisdesktopitemstate());
  }

  List<dynamic> Business = [];

  void getbusiness() {
    emit(newsbussinceloadingstate());
    diohelper.getData(method_url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'd17edb0ca522454c92c8b7ba665a4b43',
    }).then((value) {
      // print(value.data['articles'][5]['title']);
      Business = value.data['articles'];
      // Business.forEach((element) {
      //   Businessselecteditem.add(false);
      // });
      print(Business[0]['title']);
      emit(newsbussincesuccessedstate());
    }).catchError((error) {
      print(error.toString());
      emit(newsbussincefailstate(error.toString()));
    });
  }

  List<dynamic> Sports = [];

  void getSports() {
    emit(newssportsloadingstate());
    if (Sports.length == 0) {
      diohelper.getData(method_url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'd17edb0ca522454c92c8b7ba665a4b43',
      }).then((value) {
        // print(value.data['articles'][5]['title']);
        Sports = value.data['articles'];
        print(Sports[0]['title']);
        emit(newssportssuccessedstate());
      }).catchError((error) {
        print(error.toString());
        emit(newssportsfailstate(error.toString()));
      });
    } else {
      emit(newssportssuccessedstate());
    }
  }

  List<dynamic> Scince = [];

  void getScince() {
    emit(newsscinceloadingstate());
    if (Scince.length == 0) {
      diohelper.getData(method_url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'd17edb0ca522454c92c8b7ba665a4b43',
      }).then((value) {
        // print(value.data['articles'][5]['title']);
        Scince = value.data['articles'];
        print(Scince[0]['title']);
        emit(newsscincesuccessedstate());
      }).catchError((error) {
        print(error.toString());
        emit(newsscincefailstate(error.toString()));
      });
    } else {
      emit(newsscincesuccessedstate());
    }
  }

  List<dynamic> search = [];

  void getsearch(String? value) {
    emit(newssearchloadingstate());
    diohelper.getData(method_url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'd17edb0ca522454c92c8b7ba665a4b43',
    }).then((value) {
      // print(value.data['articles'][5]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(newssearchsuccessedstate());
    }).catchError((error) {
      print(error.toString());
      emit(newssearchfailstate(error));
    });
  }


}
