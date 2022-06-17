abstract class SocialLoginStates {}

class SocialLoginIntialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSucessState extends SocialLoginStates {
  final String uId;

  SocialLoginSucessState(this.uId);
}

class SocialLoginErorrlState extends SocialLoginStates {
  final String error;

  SocialLoginErorrlState(this.error);
}

class SocialLoginPasswordVisibiltyState extends SocialLoginStates {}
