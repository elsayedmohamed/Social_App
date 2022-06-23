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
          'https://img.freepik.com/free-photo/teen-girl-portrait-close-up_23-2149231222.jpg?t=st=1655702169~exp=1655702769~hmac=36ca0a65a4995b0c82128364102fdf7c99091a546c60faba30fee4397b6b69f8&w=740',
      cover:
          'https://img.freepik.com/free-photo/teen-girl-portrait-close-up_23-2149231204.jpg?w=740',
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
