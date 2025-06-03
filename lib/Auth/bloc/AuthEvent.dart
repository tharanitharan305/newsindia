part of 'AuthBloc.dart';
sealed class AuthEvent extends Equatable{
  get props => [];
}
class LoginUser extends AuthEvent{
 User user;
  LoginUser({required this.user});
}
class LogOutUser extends AuthEvent{}
class Pushlogin extends AuthEvent{
  User user;
  Pushlogin({required this.user});
}