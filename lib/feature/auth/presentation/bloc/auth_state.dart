class AuthState {}

class AuthInital extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
