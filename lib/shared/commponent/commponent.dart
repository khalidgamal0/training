import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/ShopApp/cubit/ShopCubit.dart';
import '../../layout/todoapp/newhomelayout/cubit/cubit.dart';
import '../../moduels/news_app/webview/webview.dart';
import '../style/color.dart';
import '../../../layout/newsapp/cubit/cubit.dart';
import '../../../layout/newsapp/cubit/states.dart';

Widget defaultMaterialButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isuppercase = true,
  String text = 'login',
  @required Function()? function,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        height: 50,
        onPressed: function,
        child: Text(
          isuppercase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          maxLines: 1,
        ),
      ),
    );

Widget defaultextbutton({
  @required VoidCallback? function,
  @required String? text,
}) =>
    TextButton(onPressed: function, child: Text(text!.toUpperCase()));

Widget defaulttextformfield({
  @required TextEditingController? controller,
  @required String? labeltext,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  @required TextInputType? type,
  bool obscureText = false,
  VoidCallback? onTap,
  Function()? suffixpressed,
  Function(String)? onchanged,
  Function(String)? onsubmitted,
  @required FormFieldValidator? validate,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labeltext,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: suffixpressed, icon: Icon(suffixIcon))
              : null,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon)),
      obscureText: obscureText,
      keyboardType: type,
      onTap: onTap,
      onFieldSubmitted: onsubmitted,
      onChanged: onchanged,
      validator: validate,
    );

Widget defaultAppBar({
  @required BuildContext? context,
  String? title,
  List<Widget>? action,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context!);
        },
        icon: Icon(Icons.keyboard_arrow_left_outlined),
      ),
      title: Text(title!),
      actions: action,
    );

//start to doapp
Widget itemtaskbuilder(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archive', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'task', id: model['id']);
                },
                icon: Icon(
                  Icons.task,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );
Widget ConditionalBuild({@required List<Map>? task}) => ConditionalBuilder(
      condition: task!.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) =>
              itemtaskbuilder(task[index], context),
          separatorBuilder: (context, index) => mydivider(),
          itemCount: task!.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
//end to doapp

Widget buildarticleitem(article, context, index) => Container(
      color: newcubit.get(context).selecteditem == index &&
              newcubit.get(context).isdesktop!
          ? Colors.grey[200]
          : null,
      child: InkWell(
        onTap: () {
          NavigateTo(context, webview(article['url']));
          newcubit.get(context).bussinesSelectditem(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage('${article['urlToImage']}'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Text(
                        '${article['publishedAt']}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget mydivider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    );

Widget articalConditionalbuilder(list, {issearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildarticleitem(list[index], context, index),
          separatorBuilder: (context, index) => mydivider(),
          itemCount: list.length),
      fallback: (context) =>
          issearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void NavigateTo(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}
void NavigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Widget),
    (route) => false,
  );
}


Widget BuildProductItem(model, context, {bool isoldprise = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isoldprise)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.3),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price}',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (model.discount != 0 && isoldprise)
                            Text(
                              '${model.oldPrice}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .ChangeFavorite(product_id: model.id!);
                              },
                              icon: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      ShopCubit.get(context).favorite[model!.id]!
                                          ? defaultColor
                                          : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ))),
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
Widget BuildProductItemsearch(model, context, {bool isoldprise = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isoldprise)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.3),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price}',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (model.discount != 0 && isoldprise)
                            Text(
                              '${model.oldPrice}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .ChangeFavorite(product_id: model.id!);
                              },
                              icon: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ))),
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );

void showToast({@required String? message, ToastStates? state}) {
  Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ChoseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARING }
Color ChoseToastColor(ToastStates state) {
  Color color;
  if (state == ToastStates.SUCCESS) {
    color = Colors.green;
  } else if (state == ToastStates.ERROR) {
    color = Colors.red;
  } else {
    color = Colors.amber;
  }
  return color;
}
