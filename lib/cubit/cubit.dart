import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireBase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/moduels/chats/chats_screen.dart';
import 'package:social_app/moduels/feeds/feeds_screen.dart';
import 'package:social_app/moduels/new_post/new_post_screen.dart';
import 'package:social_app/moduels/settings/settings_screen.dart';
import 'package:social_app/moduels/users/users_screen.dart';

import '../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessStates());
    }).catchError(((error) {
      emit(SocialGetUserErorrStates(error.toString()));
    }));
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }

    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  //===Image Picker ================================================
  File? profileImage;
  final ImagePicker picker = ImagePicker();

  getProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage = File(image.path);
      emit(SocialProfileImagePickedSuccessState());
      print(image.path);
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErorrState());
    }
  }

  // Cover Image===============================================
  File? coverImage;
  getCoverImage() async {
    final XFile? Cover = await picker.pickImage(source: ImageSource.gallery);

    if (Cover != null) {
      coverImage = File(Cover.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImagePickedErorrState());
    }
  }

  //=Upload  profile Image======================================

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    fireBase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
        print(value);
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErorrState());
        print('error is ${error.toString()}');
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErorrState());
      print('error is ${error.toString()}');
    });
  }

  //=Upload Cover's Image ======================================

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    fireBase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(
          coverImage!.path,
        ).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        print(value);
        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErorrState());
        print('error is ${error.toString()}');
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErorrState());
      print('error is ${error.toString()}');
    });
  }

  // Update User Info ==============================================

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel? model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel?.email,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
      uId: userModel?.uId,
      isEmailVerified: userModel?.isEmailVerified,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErorrState());
    });
    // }
  }

  // New Post Image===============================================
  File? postImage;
  Future<void> getPostImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErorrState());
    }
  }

// Remove Post Image===============================================
  void removePostImage() {
    postImage = null;

    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel? model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      phone: userModel!.phone,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErorrState());
    });
    // }
  }

  // Create New Post ==============================================
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    fireBase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);

        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErorrState());
        print('error is ${error.toString()}');
      });
    }).catchError((error) {
      emit(SocialCreatePostErorrState());
      print('error is ${error.toString()}');
    });
  }
  //Get Posts ============================================================================

  List<String> postId = [];
  List<PostModel> posts = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });

      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      emit(SocialGetPostsErorrStates(error.toString()));
    });
  }

  //====================================================================================
  void likePosts({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErorrState());
    });
  }

//==========================================================================
  void commentsNum({required String commentId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': true}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErorrState());
    });
  }

  //==============================================

  List<SocialUserModel> users = [];

  void getUsers() {
    emit(SocialGetAllUsersLoadingStates());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessStates());
      }).catchError((error) {
        emit(SocialGetAllUsersErorrStates(error.toString()));
      });
  }

  //=========================================================================
  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel!.uId,
    );
// messages for me
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErorrState());
    });

    // Messages for other

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialGetMessageSuccessState());
    }).catchError((error) {
      emit(SocialGetMessageErorrState());
    });
  }

  //======================================================

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen(
      (event) {
        messages = [];
        event.docs.forEach((element) {
          messages.add(
            MessageModel.fromJson(element.data()),
          );
        });
      },
    );
    emit(SocialGetMessageSuccessState());
  }
}
