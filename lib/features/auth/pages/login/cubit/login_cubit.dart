import 'package:exomatik_learn_flutter/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final PostLogin _postLogin;

  LoginCubit(this._postLogin) : super(const LoginState.initial());

  Future<void> login(LoginParams params) async {
    emit(const LoginState.loading());
    final data = await _postLogin.call(params);

    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(LoginState.failure(l.message ?? ""));
        }
      },
      (r) => emit(LoginState.success(r)),
    );
  }
}
