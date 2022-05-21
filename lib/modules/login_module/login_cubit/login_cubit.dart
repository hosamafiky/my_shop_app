import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_module/login_cubit/login_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';
import 'package:shop_app/shared/network/remote/google_signin.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  IconData? suffixIcon = Icons.visibility;

  void changeLoginPasswordVisibility() {
    isSecure = !isSecure;
    suffixIcon = isSecure ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePassVisiblityState());
  }

  bool isFieldEmpty = true;
  void checkFieldEmpty(String value) {
    if (value.isNotEmpty) {
      isFieldEmpty = false;
      emit(LoginCheckFieldEmptyState());
    } else {
      isFieldEmpty = true;
      emit(LoginCheckFieldEmptyState());
    }
  }

  Future signIn() async {
    await GoogleSignInApi.login();
  }

  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(lang: 'en', endPoint: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
