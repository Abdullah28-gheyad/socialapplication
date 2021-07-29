


abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState {}
class SocialRegisterLoadingState extends SocialRegisterState {}
class SocialRegisterSuccessState extends SocialRegisterState {}
class SocialRegisterErrorState extends SocialRegisterState {}
class SocialCreateUserLoadingState extends SocialRegisterState {}
class SocialCreateUserSuccessState extends SocialRegisterState {
  final uId ;

  SocialCreateUserSuccessState(this.uId);
}
class SocialCreateUserErrorState extends SocialRegisterState {}
