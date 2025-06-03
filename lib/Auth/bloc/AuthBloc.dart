import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:newsindia/Auth/models/USer.dart';

part 'AuthEvent.dart';
part 'AuthState.dart';
class AuthBloc extends Bloc<AuthEvent,AuthState>{
 User? currentUser;
  AuthBloc():super(AuthLoading()){
    on<LoginUser>(_onLoginUser);
    on<LogOutUser>(_onLogoutEvent);
    on<Pushlogin>((event,emit) async {
      log("Entered Login user and openning box");
      final box = await Hive.openBox('userBox');
      log("In AuthBox opened box userBox");
      final storedUser = box.get('user');
      currentUser=storedUser;
      log("In authBloc emitting push Looged");
      emit(LoggedIN(user: event.user));
    });
  }
  _onLoginUser(LoginUser event,Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      log("Entered Login user and openning box");
      final box = await Hive.openBox('userBox');
      log("In AuthBox opened box userBox");
      final storedUser = box.get('user');
    log("In AuthBloc got user feild from box ${storedUser.runtimeType} and ${storedUser == event.user}");
      if (storedUser == event.user) {
        log("User was alreassdy sined in emitting Logged in");
        currentUser=event.user;
        emit(LoggedIN(user: event.user));
      } else {
        await box.put('user', event.user);
        await box.put('isLoggedIn',true);
        currentUser=event.user;
        emit(LoggedIN(user: event.user));
      }
    } catch (e) {
      emit(LoginError(message: 'Login failed: ${e.toString()}'));
    }
  }
  _onLogoutEvent(LogOutUser event,Emitter<AuthState> emit){
    emit(AuthLoading());
    emit(LogedOut());
  }
}