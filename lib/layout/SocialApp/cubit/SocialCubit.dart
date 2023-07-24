import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/socialmodel/Post_model.dart';
import '../../../models/socialmodel/SocialUserModel.dart';
import '../../../models/socialmodel/commentmodel.dart';
import '../../../models/socialmodel/messageModel.dart';
import '../../../moduels/SocialApp/Chats/ChatsScreen.dart';
import '../../../moduels/SocialApp/Feeds/FeedsScreen.dart';
import '../../../moduels/SocialApp/Settings/SettingsScreen.dart';
import '../../../moduels/SocialApp/Users/UsersScreen.dart';
import '../../../moduels/SocialApp/addPosts/AddPosts.dart';
import '../../../shared/commponent/constent.dart';
import 'SocialStates.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? Usermodel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
       Usermodel=SocialUserModel.fromjson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<String> titles = [
    'Home',
    'Chats',
    'posts',
    'User',
    'Settings',
  ];
  List<Widget> BottomnavBar = [
    FeedsScreen(),
    ChatsScreen(),
    NewPosts(),
    UsersScreen(),
    SettingsScreen(),
  ];
  int currentindex = 0;

  void ChangeBottomNav(index) {
    if (index == 1) {
      GetAllUsers();
    }
    if (index == 2) {
      emit(SocialNewsPostStats());
    } else {
      currentindex = index;
      emit(ChangeBottomNavStates());
    }
  }

  //get image

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = (File(pickedFile.path));
      emit(SocialImagePickedSuccessStats());
    } else {
      print('no image selected');
      emit(SocialImagePickedErrorStats());
    }
  }

  File? coverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverSuccessStats());
    } else {
      print('no image selected');
      emit(SocialCoverErrorStats());
    }
  }

  // update User data

  //uploade image with data
  void uploadProfileImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialimageUpdateloadingStats());
    FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialuploadprofileSuccessStats());
        print(value);
        updateuserData(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialuploadprofileErrorStats());
      });
    }).catchError((error) {
      emit(SocialuploadprofileErrorStats());
    });
  }

  void uploadcoverImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialcoverUpdateloadingStats());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialuploadprofileSuccessStats());
        print(value);
        updateuserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialuploadCoverErrorStats());
      });
    }).catchError((error) {
      emit(SocialuploadCoverErrorStats());
    });
  }

  // void updateUserDataImage({
  //   @required  String?name,
  //   @required  String?phone,
  //   @required  String?bio,
  //   }){
  //   emit(SocialUserUpdateloadingStats());
  //   if( coverImageUrl !=null){
  //     uploadcoverImage();
  //   }
  //   else if(profileImageUrl !=null){
  //     uploadProfileImage();
  //   }
  //   else if(coverImageUrl !=null&&profileImageUrl !=null){
  //   }
  //   else
  //    {
  //      updateData(
  //        phone: phone,
  //        name: name,
  //        bio: bio,
  //      );
  //   }
  // }

  //upload data else
  void updateuserData({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUserUpdateloadingStats());

    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        uid: Usermodel!.uid,
        bio: bio,
        email: Usermodel!.email,
        password: Usermodel!.password,
        photo: image ?? Usermodel!.photo,
        photo_cover: cover ?? Usermodel!.photo_cover,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .update(model.ToMap())
        .then((value) {
      getUserData();
    }).catchError(() {
      emit(SocialUserUpdateErrorStats());
    });
  }

  // add New posts

  File? post_Image;

  Future<void> getpostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      post_Image = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialpostImageSuccessStats());
    } else {
      print('no image selected');
      emit(SocialpostImageErrorStats());
    }
  }

  void removePostImage() {
    post_Image = null;
    emit(SocialremovepostImageStats());
  }

  void uploadPostImage({
    @required String? data_time,
    @required String? text,
  }) {
    emit(SocialcreatepostloadingStats());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(post_Image!.path).pathSegments.last}')
        .putFile(post_Image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createNewPoost(
          text: text,
          data_time: data_time,
          post_image: value,
        );
      }).catchError((error) {
        emit(SociacreatepostErrorStats());
      });
    }).catchError((error) {
      emit(SociacreatepostErrorStats());
    });
  }

  void createNewPoost({
    @required String? data_time,
    @required String? text,
    String? post_image,
  }) {
    emit(SocialcreatepostloadingStats());
    PostModel modelpost = PostModel(
      name: Usermodel!.name,
      uid: Usermodel!.uid,
      photo: Usermodel!.photo,
      data_time: data_time,
      text: text,
      post_photo: post_image ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(modelpost.ToMap())
        .then((value) {
      getPosts();
        }).catchError(() {
      emit(SociacreatepostErrorStats());
    });
  }

  List<PostModel> posts = [];
  List<String> postid = [];
  List<int> likes = [];
  List<int> comment = [];

  void getPosts() {
    emit(SocialGetpostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().
    then((value) {
      value.docs.forEach((element) {
        element.reference.collection('like').get().then((value) {
          likes.add(value.docs.length);
          postid.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
          emit(SocialGetpostsSuccessState());
        });
        element.reference.collection('comment').get().then((value) {
          comment.add(value.docs.length);
          emit(SocialGetpostsSuccessState());
        });
      });
      emit(SocialGetpostsSuccessState());
    }).
    catchError((error) {
      emit(SocialGetpostsErrorState(error.toString()));
    });
  }

  bool isLike=false;
  void likepost(
    String postid,
  ) {
    isLike=!isLike;
    if(isLike){
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .collection('like')
          .doc(Usermodel!.uid)
          .set({'like': true}).then((value) {
        emit(SociallikepostsSuccessState());
      }).catchError((error) {
        emit(SociallikepostsErrorState(error.toString()));
      });
    }
    else{
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .collection('like')
          .doc(Usermodel!.uid)
          // .set({'like': true}).then((value) {
        .delete().then((value) {
        emit(SociallikepostsSuccessState());
      }).catchError((error) {
        emit(SociallikepostsErrorState(error.toString()));
      });
    }
  }

  // void getLike(){
  //   emit(SocialGetlikeLoadingState());
  //   FirebaseFirestore.instance.collection('posts').get().
  //   then((value) {
  //     value.docs.forEach((element) {
  //       element.reference.collection('like').get().then((value) {
  //         likes.add(value.docs.length);
  //         emit(SocialGetlikeSuccessState());
  //       });
  //     });
  //     emit(SocialGetlikeSuccessState());
  //   }).catchError((error) {
  //     emit(SocialGetlikeErrorState());
  //   });
  //
  // }

  void commentpost(String postid, text) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comment')
        .doc(Usermodel!.uid)
        .set({Usermodel!.name!: text}).then((value) {
      emit(SocialcommentpostsSuccessState());
    }).catchError((error) {
      emit(SocialcommentpostsErroState(error.toString()));
    });
  }

  // void createComment({
  //   @required  String?text,
  //   @required  String?postid,
  // }){
  //   emit(SocialcommentpostsLoadingState());
  //   // PostModel modelpost = PostModel(
  //   //   name: Usermodel!.name,
  //   //   uid:  Usermodel!.uid,
  //   //   photo:  Usermodel!.photo,
  //   //   data_time: data_time,
  //   //   text: text,
  //   //   post_photo:post_image??'',
  //   // );
  //   CommentModel comment_model=CommentModel(
  //     text: text,
  //     name: Usermodel!.name,
  //     useruid: Usermodel!.uid,
  //     photo:Usermodel!.photo,
  //     postuid:postid,
  //   );
  //   FirebaseFirestore.instance.
  //   collection('posts').
  //   doc(postid).
  //   collection('comment').
  //   doc(Usermodel!.uid).set(comment_model.ToMap())
  //       .then((value) {
  //     emit(SocialcommentpostsSuccessState());
  //   }).catchError((error) {
  //     emit(SocialcommentpostsErroState(error.toString()));
  //   });
  // }
  //
  // List<int> commentlenght=[];
  // List<CommentModel> commenttext=[];
  // void getcomment(){
  //   emit(SocialGetcommentLoadingState());
  //   FirebaseFirestore.instance.collection('posts').doc('MCUrazOPVQJOEfauCGm4').collection('comment').
  //   get().
  //   then((value){
  //     value.docs.forEach((element) {
  //       commentlenght.add(value.docs.length);
  //       commenttext.add(CommentModel.fromjson(element.data()));
  //     });
  //     emit(SocialGetcommentSuccessState());
  //   }).catchError((error){
  //     emit(SocialGetcommentErrorState(error.toString()));
  //   });
  // }

  List<SocialUserModel> all_users = [];

  void GetAllUsers() {
    if (all_users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.id != Usermodel!.uid)
            all_users.add(SocialUserModel.fromjson(element.data()));
        });
        emit(SocialGetalluserSuccessState());
      }).catchError((error) {
        emit(SocialGetallusertErrorState(error.toString()));
      });
  }

  void sendcomment({
    @required String? text,
    @required String? postid,
  }) {
    CommentModel model = CommentModel(
      text: text,
      useruid: Usermodel!.uid,
      name: Usermodel!.name,
      photo: Usermodel!.photo,
      postuid: postid,
    );
    //set my chat
    FirebaseFirestore.instance
        .collection('posts')
        .doc(Usermodel!.uid)
        .collection('comment')
        .add(model.ToMap())
        .then((value) {
      emit(SocialsendcommentSuccessState());
    }).catchError((error) {
      emit(SocialsendcommenterrorState());
    });
  }

  void sendMessage({
    @required String? text,
    @required String? reciverid,
    @required String? datetime,
  }) {
    MessageModel model = MessageModel(
      text: text,
      datetime: datetime,
      reciverid: reciverid,
      senderid: Usermodel!.uid,
    );
    //set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(Usermodel!.uid)
        .collection('chats')
        .doc(reciverid)
        .collection('message')
        .add(model.ToMap())
        .then((value) {
      emit(SocialsendmessageSuccessState());
    }).catchError((error) {
      emit(SocialsendmessageerrorState());
    });
    //set reciver chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverid)
        .collection('chats')
        .doc(Usermodel!.uid)
        .collection('message')
        .add(model.ToMap())
        .then((value) {
      emit(SocialsendmessageSuccessState());
    }).catchError((error) {
      emit(SocialsendmessageerrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessage({@required recivedid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Usermodel!.uid)
        .collection('chats')
        .doc(recivedid)
        .collection('message').orderBy('datetime',descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(
          MessageModel.fromjson(element.data()),
        );
      });
      emit(SocialGetmessageSuccessState());
    });
  }
}
