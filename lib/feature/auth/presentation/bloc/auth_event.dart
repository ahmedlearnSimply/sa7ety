import 'package:sa7ety/core/enum/user_type_enum.dart';

class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserType userType;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final UserType userType;
  LoginEvent({
    required this.email,
    required this.password,
    required this.userType,
  });
}
