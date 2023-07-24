import 'dart:async';
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:khalidprojects/firebase_options.dart';
import 'package:khalidprojects/shared/commponent/commponent.dart';
import 'package:khalidprojects/shared/commponent/constent.dart';
import 'package:khalidprojects/shared/network/remote/dio_heliper.dart';
import 'package:khalidprojects/shared/style/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:khalidprojects/shared/network/local/cache_helper.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'layout/ShopApp/ShopLayout.dart';
import 'layout/ShopApp/cubit/ShopCubit.dart';
import 'layout/SocialApp/SocailApp.dart';
import 'layout/SocialApp/cubit/SocialCubit.dart';
import 'layout/newsapp/cubit/cubit.dart';
import 'layout/newsapp/cubit/states.dart';
import 'layout/newsapp/news_app.dart';
import 'layout/todoapp/homelayout/homelayout.dart';
import 'layout/todoapp/newhomelayout/cubit/cubit.dart';
import 'layout/todoapp/newhomelayout/cubit/states.dart';
import 'layout/todoapp/newhomelayout/newlayout.dart';
import 'moduels/Native Code/native code.dart';
import 'moduels/Shop_app/onboarding/OnBoarding.dart';
import 'moduels/Shop_app/Shop_login/Shop_login.dart';
import 'moduels/SocialApp/SocialLogin/SocialLogin.dart';
import 'moduels/basci_app/socialscreen/watsapp.dart';
import 'moduels/bmi_app/calculater/newcalc.dart';
import 'shared/block-observer.dart';
// Future<void>FirebaseonMessageOpenedApp(RemoteMessage message)async{
//   print('onBackgroundMessage');
//   print(message.data.toString());
//   showToast(message:'onBackgroundMessage',state:ToastStates.SUCCESS );
// }
void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var token= await FirebaseMessaging.instance.getToken();
  print(token);

  // FirebaseMessaging.onMessage.listen((event) {
  //   print('onMessage');
  //   print(event.data.toString());
  //   showToast(message:'onMessage',state:ToastStates.SUCCESS );
  //
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('onMessageOpenedApp');
  //   print(event.data.toString());
  //   showToast(message:'onMessageOpenedApp',state:ToastStates.SUCCESS );
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(FirebaseonMessageOpenedApp);

  if(Platform.isWindows)
    await DesktopWindow.setMinWindowSize(Size(350, 600));
  Bloc.observer = MyBlocObserver();
  diohelper.init();
  await cahe_helper.init();


  bool? isdark=cahe_helper.getbooldat(key:'isdark');
  Widget widget;

  // bool? onboarding=cahe_helper.getdata(key:'onboarding');
  // token=cahe_helper.getdata(key:'token');
  // if(onboarding==true){
  //   if(token !=null)widget=ShopLayout();
  //   else widget=Shop_login();
  // }else{widget=OnBoarding();}

  uid=cahe_helper.getdata(key:'uid');
  if(uid != null) widget=SocialHomeLayout();
  else {widget=SocialLoginScreen();}

  runApp(myapp(isdark: isdark,startwidget:widget));
}

// staeless
// statef
// class myapp

class myapp  extends StatelessWidget
{
  final bool? isdark;
  final Widget? startwidget;

  myapp({ @required this.isdark,@required this.startwidget});

  // اول حاجه بتستدعي
  // 1: constructor
  //2:initial state
  //3:build

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> newcubit()..getbusiness(),),
        BlocProvider(create: (context) => AppCubit()..ChangeMode(fromshared:isdark),),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getcategoryData()..getFavoritesData()..getUserDatatosettingscreen()),

      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner:false,
            theme:lightthem,
            darkTheme:darkthem,
            themeMode:ThemeMode.light,
             home:Directionality(textDirection:TextDirection.ltr,child: startwidget!),
          );
        },
      ),
    );
  }
}
// Future<Timer> sddd(context)async{
//   return Timer(Duration(seconds: 3),
//           ()=>NavigateTo(context,OnBoarding()));
// }
