abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErorrStates extends SocialStates {
  final String error;

  SocialGetUserErorrStates(this.error);
}

//Get All Users========================================
class SocialGetAllUsersLoadingStates extends SocialStates {}

class SocialGetAllUsersSuccessStates extends SocialStates {}

class SocialGetAllUsersErorrStates extends SocialStates {
  final String error;

  SocialGetAllUsersErorrStates(this.error);
}

//=====================================================
class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}
//=========================================================

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErorrState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErorrState extends SocialStates {}

//=========================================================
class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErorrState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErorrState extends SocialStates {}

class SocialUserUpdateErorrState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

//Create Post =====================================================
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErorrState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErorrState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErorrState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

// Get Posts ===========================================================
class SocialGetPostsLoadingStates extends SocialStates {}

class SocialGetPostsSuccessStates extends SocialStates {}

class SocialGetPostsErorrStates extends SocialStates {
  final String error;

  SocialGetPostsErorrStates(this.error);
}

//=======================================================================
class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErorrState extends SocialStates {}

//=========================================================================
class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErorrState extends SocialStates {}

//=========================================================================
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErorrState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErorrState extends SocialStates {}
