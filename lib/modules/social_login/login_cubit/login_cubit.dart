import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/cache_helper.dart';
import 'package:social_app/modules/social_login/login_cubit/login_states.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordIcon() {
    isPassword = !isPassword;
    emit(SocialChangePasswordIconState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CacheHelper.setData(
        key: 'uid',
        value: value.user!.uid,
      );
      emit(SocialLoginSuccessState());
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }
}
