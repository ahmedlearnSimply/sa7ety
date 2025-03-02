import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_event.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInital()) {
    on<RegisterEvent>(register);
  }
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    log("message1");

    try {
      log("message2 - Attempting to create user...");

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      log("message3 - User created successfully");

      User? user = credential.user;
      await user?.updateDisplayName(
          event.name); // Ensure updateDisplayName is awaited

      emit(RegisterSuccessState());
      log("message4 - Registration successful");
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code} - ${e.message}"); // Log the error code

      if (e.code == 'weak-password') {
        emit(AuthError(message: "الرقم السري ضعيف"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError(message: "الايميل مستخدم من قبل"));
      } else {
        emit(AuthError(message: "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      }
    } catch (e) {
      log("Unexpected error: $e");
      emit(AuthError(message: "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }
}
