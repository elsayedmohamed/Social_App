import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/moduels/scocial_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterIntialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  //=====================================================================

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        uId: value.user!.uid,
        phone: phone,
        email: email,
      );

      // emit(SocialRegisterSucessState());
    }).catchError((error) {
      emit(SocialRegisterErorrlState(error));
    });
  }

  //Create User=========================================================

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://th.bing.com/th/id/R.4cf560081c770d83d840fb143e70818f?rik=mEfWmaAx9XtWUw&riu=http%3a%2f%2fwasse3sadrak.com%2fwp-content%2fuploads%2f2019%2f08%2fAmber-Heard-Johnny-Depp-Samantha-McMillen-768x612.jpg&ehk=7CARm89d7CzfQwxKrziqFncHiKVGoLUw%2bPh4oHEOjus%3d&risl=&pid=ImgRaw&r=0',
      cover:
          'https://th.bing.com/th/id/R.4cf560081c770d83d840fb143e70818f?rik=mEfWmaAx9XtWUw&riu=http%3a%2f%2fwasse3sadrak.com%2fwp-content%2fuploads%2f2019%2f08%2fAmber-Heard-Johnny-Depp-Samantha-McMillen-768x612.jpg&ehk=7CARm89d7CzfQwxKrziqFncHiKVGoLUw%2bPh4oHEOjus%3d&risl=&pid=ImgRaw&r=0',
      bio: 'write your bio',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSucessState());
    }).catchError((error) {
      emit(SocialCreateUserErorrState(error.toString()));
    });
  }

  //=====================================================================
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffixVisibilty() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordVisibiltyState());
  }
}
