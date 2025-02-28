import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_event.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {});
  }

  //* register Method
  register(RegisterEvent event, Emitter<AuthState> emit) {
    emit(RegisterLoadingState());
  }
}
