
abstract class SocialRegisterStates{}
class SocialRegisterInitial extends SocialRegisterStates{}

class SocialRegisterLoading extends SocialRegisterStates{}

class SocialRegisterSucsess extends SocialRegisterStates{}

class SocialRegisterError extends SocialRegisterStates{
  String? error;
  SocialRegisterError(this.error);
}

class SocialCreateSucsess extends SocialRegisterStates{
  String? uid;
  SocialCreateSucsess(this.uid);
}

class SocialCreateError extends SocialRegisterStates{
  String? error;
  SocialCreateError(this.error);
}

class Socialreshowpassvisibility extends SocialRegisterStates{}
