abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialChangePasswordIconState extends SocialRegisterStates {}

//Register States
class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

//User Create States
class SocialUserCreateLoadingState extends SocialRegisterStates {}

class SocialUserCreateSuccessState extends SocialRegisterStates {}

class SocialUserCreateErrorState extends SocialRegisterStates {
  final String error;

  SocialUserCreateErrorState(this.error);
}
