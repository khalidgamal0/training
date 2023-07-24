// POST
// UPDATE
// DELETE

// GET

//base url : https://newsapi.org/
// method (url) :v2/top-headlines?
//  queries :country=eg&category=business&apiKey=d17edb0ca522454c92c8b7ba665a4b43

//https://newsapi.org/v2/everything?q=tesla&apiKey=d17edb0ca522454c92c8b7ba665a4b43
import 'package:khalidprojects/shared/network/local/cache_helper.dart';
import '../../moduels/Shop_app/Shop_login/Shop_login.dart';
import 'commponent.dart';

void signOut(context,widget,key){
  cahe_helper.removedata(key:key).then((value){
    
    NavigateAndFinish(context,widget);
  });
}
void printFullText(String text){
  final pattern=RegExp('.{1,800}');// 800 is the size of each chunk
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String? token='';

String? uid='';
//ConditionalBuilder(
//             condition: SocialCubit.get(context).model !=null,
//             builder: (context) {
//               // var model=SocialCubit.get(context).model;
//               // // var model=FirebaseAuth.instance.currentUser!.emailVerified;
//               return Column(children: [
//                 //نفس بعض
//                 // if(!model!.isEmailVerified!)
//                 //  if(!model!.isEmailVerified!)
//                 //    if(!FirebaseAuth.instance.currentUser!.emailVerified)
//                 // Container(
//                 //   color: Colors.amber.withOpacity(.6),
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.symmetric(horizontal: 20),
//                 //     child: Row(
//                 //       children: [
//                 //         Icon(Icons.info_outline),
//                 //         SizedBox(width: 15,),
//                 //         Expanded(child: Text('please verifiy your email')),
//                 //         defaultextbutton(function:(){
//                 //           FirebaseAuth.instance.currentUser!.sendEmailVerification().
//                 //           then((value){
//                 //             showToast(message:'check your email',state:ToastStates.SUCCESS);
//                 //           }).catchError((error){
//                 //
//                 //           });
//                 //         }, text: 'send'),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//
//               ]);
//             },
//             fallback: (context) => Center(child: CircularProgressIndicator()),
//
//           ),