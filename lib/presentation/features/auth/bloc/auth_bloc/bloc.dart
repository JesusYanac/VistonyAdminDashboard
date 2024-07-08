import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistony_admin_dashboard/domain/usecases/usecase_auth.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(InitialAuthBlocState()) {
    on<TriggerAuthBlocEvent>((event, emit) async {
      emit(LoadingAuthBlocState());
      if (await UseCaseAuth().auth(event.username, event.password)) {
        emit(SuccessAuthBlocState());
      } else {
        emit(ErrorAuthBlocState());
      }
      await Future.delayed(const Duration(seconds: 2));
      emit(InitialAuthBlocState());
    });
  }

  void triggerAuthLogin(String username, String password) =>
      add(TriggerAuthBlocEvent(username: username, password: password));
}

class AuthBlocState {}

class InitialAuthBlocState extends AuthBlocState {}

class LoadingAuthBlocState extends AuthBlocState {}

class SuccessAuthBlocState extends AuthBlocState {}

class ErrorAuthBlocState extends AuthBlocState {}

class AuthBlocEvent {
  final String username;
  final String password;
  AuthBlocEvent({required this.username, required this.password});
}

class TriggerAuthBlocEvent extends AuthBlocEvent {
  TriggerAuthBlocEvent({required super.username, required super.password});
}
