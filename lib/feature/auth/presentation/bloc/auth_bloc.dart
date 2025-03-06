import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7ety/core/enum/user_type_enum.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_event.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInital()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<UpdateDoctorDataEvent>(updateDoctorData);
  }

  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AuthError(message: "المستخدم غير موجود");
      } else if (e.code == 'wrong-password') {
        AuthError(message: "الرقم السري غير صحيح");
      } else {
        emit(AuthError(message: "حدث خطأ غير متوقع، يرجى المحاولة لاحقًا"));
      }
    } catch (e) {
      log("Unexpected error: $e");
      emit(AuthError(message: "حدث خطأ غير متوقع، يرجى المحاولة لاحقًا"));
    }
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
      await user?.updateDisplayName(event.name);

      //* store in firestore
      if (event.userType == UserType.doctor) {
        FirebaseFirestore.instance.collection('doctors').doc(user?.uid).set({
          'name': event.name,
          'image': '',
          'specialization': '',
          'rating': 3,
          'email': event.email,
          'phone1': '',
          'phone2': '',
          'bio': '',
          'openHour': '',
          'closeHour': '',
          'address': '',
          'uid': user?.uid,
        });
      } else {
        FirebaseFirestore.instance.collection('patients').doc(user?.uid).set({
          'name': event.name,
          'image': '',
          'age': '',
          'email': event.email,
          'phone': '',
          'bio': '',
          'city': '',
          'uid': user?.uid,
        });
      }

      emit(RegisterSuccessState());
      log("message4 - Registration successful");
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code} - ${e.message}"); // Log detailed error

      if (e.code == 'weak-password') {
        emit(AuthError(message: "الرقم السري ضعيف"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError(message: "الايميل مستخدم من قبل"));
      } else if (e.code == 'invalid-email') {
        emit(AuthError(message: "صيغة البريد الإلكتروني غير صحيحة"));
      } else if (e.code == 'network-request-failed') {
        emit(AuthError(message: "خطأ في الشبكة، تحقق من اتصالك بالإنترنت"));
      } else {
        emit(AuthError(message: "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      }
    } catch (e) {
      log("Unexpected error: $e");
      emit(AuthError(message: "حدث خطأ غير متوقع، يرجى المحاولة لاحقًا"));
    }
  }

  //* update Doctor data

  Future<void> updateDoctorData(
      UpdateDoctorDataEvent event, Emitter<AuthState> emit) async {
    emit(DoctorRegisterLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(event.doctorModel.uid)
          .update(event.doctorModel.toJson());
      emit(DoctorRegisterSuccessState());
    } on Exception catch (e) {
      log("Unexpected error: $e");
      emit(AuthError(message: "حدث خطأ غير متوقع، يرجى المحاولة لاحقًا"));
    }
  }
}
