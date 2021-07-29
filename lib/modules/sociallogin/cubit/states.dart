


abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}
class SocialLoginLoadingState extends SocialLoginStates {}
class SocialLoginSuccessState extends SocialLoginStates {
  final uId ;

  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginStates {}