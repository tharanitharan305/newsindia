part of 'AuthBloc.dart';
sealed class AuthState extends Equatable{
  get props =>[];
}
class LoggedIN extends AuthState{
 User user;
 LoggedIN({required this.user});
}
class LogedOut extends AuthState{}
class AuthLoading extends AuthState{}
class LoginError extends AuthState{
 String message;
 LoginError({required this.message});
}