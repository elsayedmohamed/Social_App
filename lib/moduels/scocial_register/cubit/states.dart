abstract class SocialRegisterStates {}

class SocialRegisterIntialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSucessState extends SocialRegisterStates {}

class SocialRegisterPasswordVisibiltyState extends SocialRegisterStates {}

class SocialRegisterErorrlState extends SocialRegisterStates {
  final String error;

  SocialRegisterErorrlState(this.error);
}

//============================================================================

class SocialCreateUserSucessState extends SocialRegisterStates {}

class SocialCreateUserErorrState extends SocialRegisterStates {
  final String error;

  SocialCreateUserErorrState(this.error);
}
