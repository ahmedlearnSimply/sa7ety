import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_event.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<RegisterEvent>(register);
  }

  //* register Method
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    log("message1");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User? user = credential.user;
      user?.updateDisplayName(event.name);
      emit(RegisterSuccessState());
      log("message2");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AuthError(message: "الرقم السري ضعيف");
      } else if (e.code == 'email-already-in-use') {
        AuthError(message: "الايميل مستخدم من قبل");
      } else {
        AuthError(message: "حدث خطا ما يرجي المحاوله لاحقا");
      }
    } catch (e) {
      AuthError(message: "حدث خطا ما يرجي المحاوله لاحقا");
    }
  }
}
