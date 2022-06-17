abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErorrStates extends SocialStates {
  final String error;

  SocialGetUserErorrStates(this.error);
}

//=====================================================
class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}
