import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/cache_helper.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/register_cubit/register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordIcon() {
    isPassword = !isPassword;
    emit(SocialChangePasswordIconState());
  }

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CacheHelper.setData(
        key: 'uid',
        value: value.user!.uid,
      );
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uid: value.user!.uid,
      );
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uid,
    String? image,
    String? bio,
    String? coverImage,
  }) {
    emit(SocialUserCreateLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      uid: uid,
      phone: phone,
      bio: bio ?? 'Write your bio...',
      image: image ??
          'https://img.freepik.com/free-photo/good-looking-young-dark-skinned-bearded-guy-with-dreadlocks-keeping-his-eyes-closed-while-smiling-pleasantly-posing-blue-background-with-raised-hands_295783-10384.jpg?w=996&t=st=1666119630~exp=1666120230~hmac=6cee84a163991de982ef64148b669a977b2292de52716c89d3d003abba155ee3',
      coverImage: coverImage ??
          'https://img.freepik.com/free-photo/travel-concept-with-landmarks_23-2149153256.jpg?w=1060&t=st=1666119487~exp=1666120087~hmac=3dd3b38e591fb5add863e876d46a3292973677152502a4d9269ecba958ddcc4a',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SocialUserCreateSuccessState());
    }).catchError((error) {
      emit(SocialUserCreateErrorState(error.toString()));
    });
  }
}
