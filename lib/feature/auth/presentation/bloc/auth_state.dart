class AuthState {}

class AuthInital extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class DoctorRegisterLoadingState extends AuthState {}

class DoctorRegisterSuccessState extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
