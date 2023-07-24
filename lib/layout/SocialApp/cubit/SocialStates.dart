abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String?error;
  SocialGetUserErrorState(this.error);
}

class ChangeBottomNavStates extends SocialStates{}

class SocialNewsPostStats extends SocialStates{}

class SocialImagePickedSuccessStats extends SocialStates{}

class SocialImagePickedErrorStats extends SocialStates{}

class SocialCoverSuccessStats extends SocialStates{}

class SocialCoverErrorStats extends SocialStates{}

class SocialuploadprofileSuccessStats extends SocialStates{}

class SocialuploadprofileErrorStats extends SocialStates{}

class SocialuploadCoverSuccessStats extends SocialStates{}

class SocialuploadCoverErrorStats extends SocialStates{}

class SocialUserUpdateloadingStats extends SocialStates{}

class SocialcoverUpdateloadingStats extends SocialStates{}

class SocialimageUpdateloadingStats extends SocialStates{}

class SocialUserUpdateErrorStats extends SocialStates{}

//post states

class SocialcreatepostloadingStats extends SocialStates{}

class SocialcreatepostsuccessStats extends SocialStates{}

class SociacreatepostErrorStats extends SocialStates{}

class SocialpostImageSuccessStats extends SocialStates{}

class SocialpostImageErrorStats extends SocialStates{}

class SocialremovepostImageStats extends SocialStates{}
// POSTS STATES
class SocialGetpostsLoadingState extends SocialStates{}

class SocialGetpostsSuccessState extends SocialStates{}

class SocialGetpostsErrorState extends SocialStates{
  final String?error;
  SocialGetpostsErrorState(this.error);
}

class SocialGetlikeLoadingState extends SocialStates{}

class SocialGetlikeSuccessState extends SocialStates{}

class SocialGetlikeErrorState extends SocialStates{

}

// POSTS like STATES
class SociallikepostsSuccessState extends SocialStates{}

class SociallikepostsErrorState extends SocialStates{
  final String?error;
  SociallikepostsErrorState(this.error);
}

class SocialcommentpostsLoadingState extends SocialStates{}

class SocialcommentpostsSuccessState extends SocialStates{}

class SocialcommentpostsErroState extends SocialStates{
  final String?error;
  SocialcommentpostsErroState(this.error);}
//
//   class SocialGetcommentLoadingState extends SocialStates{}
//
//   class SocialGetcommentSuccessState extends SocialStates{}
//
//   class SocialGetcommentErrorState extends SocialStates{
//   final String?error;
//   SocialGetcommentErrorState(this.error);
//
// }

class SocialsendcommentSuccessState extends SocialStates{}
class SocialsendcommenterrorState extends SocialStates{}

class SocialGetcommentSuccessState extends SocialStates{}

class SocialGetalluserSuccessState extends SocialStates{}

class SocialGetallusertErrorState extends SocialStates{
final String?error;
SocialGetallusertErrorState(this.error);}

//
class SocialsendmessageSuccessState extends SocialStates{}
class SocialsendmessageerrorState extends SocialStates{}

class SocialGetmessageSuccessState extends SocialStates{}
