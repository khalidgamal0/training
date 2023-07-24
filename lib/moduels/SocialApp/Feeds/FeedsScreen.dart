import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:khalidprojects/shared/commponent/commponent.dart';

import '../../../layout/SocialApp/cubit/SocialCubit.dart';
import '../../../layout/SocialApp/cubit/SocialStates.dart';
import '../../../models/socialmodel/Post_model.dart';
import '../../../shared/style/color.dart';
import '../addPosts/AddPosts.dart';
import '../commentScreen/commentScreen.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length > 0 &&
                SocialCubit.get(context).Usermodel != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Card(
                        child: Image(
                          image: NetworkImage(
                              'https://st2.depositphotos.com/2550635/9440/i/450/depositphotos_94407988-stock-photo-silhouette-of-person-in-sportswear.jpg'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(8),
                        elevation: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => builtPostItem(
                            SocialCubit.get(context).posts[index],
                          context,
                          index),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: SocialCubit.get(context).posts.length),
                       SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget builtPostItem(PostModel postmodel, context, int index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(8),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('${postmodel.photo}'),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${postmodel.name}',
                              style: TextStyle(height: 1.4),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: defaultColor,
                            ),
                          ],
                        ),
                        Text(
                          '${postmodel.data_time}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 15,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${postmodel.text}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 15,top:6),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(children: [
              //       Padding(
              //         padding: const EdgeInsetsDirectional.only(end:4),
              //         child: Container(
              //           height: 25,
              //           child: MaterialButton(
              //             minWidth:1,
              //             padding: EdgeInsets.zero,
              //             onPressed:(){},child: Text('#Software',
              //             style:Theme.of(context).textTheme.caption!.copyWith(color:defaultColor)
              //             ,),),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsetsDirectional.only(end:4),
              //         child: Container(
              //           height: 25,
              //           child: MaterialButton(
              //             minWidth:1,
              //             padding: EdgeInsets.zero,
              //             onPressed:(){},child: Text('#Flutter',
              //             style:Theme.of(context).textTheme.caption!.copyWith(color:defaultColor)
              //             ,),),
              //         ),
              //       ),
              //     ],),
              //   ),
              // ),
              if (postmodel.post_photo != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('${postmodel.post_photo}')),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '${SocialCubit.get(context).comment[index]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).Usermodel!.photo!),
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Write a comment ...',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigateTo(context, CommentScreen());
                      },
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'like',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likepost(SocialCubit.get(context).postid[index]);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
