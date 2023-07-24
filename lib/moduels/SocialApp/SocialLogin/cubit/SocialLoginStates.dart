
abstract class SocialLoginStates{}
 class SocialLoginInitial extends SocialLoginStates{}

 class SocialLoginLoading extends SocialLoginStates{}

 class SocialLoginSucsess extends SocialLoginStates{
 String? uid;
 SocialLoginSucsess(this.uid);
 }

 class SocialLoginError extends SocialLoginStates{
  String? error;
  SocialLoginError(this.error);
 }

class Socialshowpassvisibility extends SocialLoginStates{}


















