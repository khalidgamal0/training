import 'package:khalidprojects/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/commponent/commponent.dart';
import '../../../shared/style/color.dart';
import '../Shop_login/Shop_login.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}
class BoardingModel{
  final String?image;
  final String?title;
  final String?body;
  BoardingModel({this.image,this.body,this.title});
}
class _OnBoardingState extends State<OnBoarding> {
 List<BoardingModel> boarding=[
   BoardingModel(
     image: 'assets/images/onboarding1.png',
     title: 'Scrren Title 1',
     body:'Scrren Body',

   ),
   BoardingModel(
     image: 'assets/images/onboarding1.png',
     title: 'Scrren Title 2',
     body:'Scrren Body 2',

   ),
   BoardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Scrren Title 3',
      body:'Scrren Body 3',
   ),
 ];
var pagecontroller=PageController();
bool islast=false;

void submit(){
  cahe_helper.setdata(key:'onboarding', value: true).then((value){
    if(value){
      NavigateTo(context,Shop_login());
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         defaultextbutton(function: submit,text:'skip'.toUpperCase(),),

        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller:pagecontroller ,
                itemBuilder:(context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index){
                  if(index==boarding.length-1){
                    print('last');
                    setState(() {
                      islast=true;
                    });
                  }
                  else
                  {
                    print('not last');
                    setState(() {
                      islast=false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SmoothPageIndicator(
                  controller: pagecontroller,
                  count:boarding.length ,
                  effect: ExpandingDotsEffect(
                    dotColor:Colors.grey,
                    activeDotColor: defaultColor,
                    dotWidth: 10,
                    dotHeight:10,
                  ),
                  ),
              FloatingActionButton(
                  onPressed: (){
                    if(islast==true){
                      submit();               }
                    else{
                      pagecontroller.nextPage(
                          duration: Duration(milliseconds: 710),
                          curve:Curves.ease
                      );
                    }

                  },
                  child:Icon(Icons.arrow_forward_ios)
              ),
            ],)
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel x)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(child: Image( image: AssetImage('${x.image}'),)),
      SizedBox(height: 30,),
      Text(
        '${x.title}',
        style: TextStyle(
            fontSize:24,
            fontWeight:FontWeight.bold
        ),
      ),
      SizedBox(height: 15,),
      Text(
        '${x.body}',
        style: TextStyle(
            fontSize:16,
            fontWeight:FontWeight.bold
        ),
      ),
      SizedBox(height: 15,),

    ],
  );
}
