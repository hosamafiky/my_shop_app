import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shop_app/models/facebook_login_model.dart';
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

  FbData? fbData;
  Future facebookSignIn() async {
    FacebookAuth.instance.login().then((value) {
      if (value.status == LoginStatus.success) {
        FacebookAuth.instance.getUserData().then((value) {
          fbData = FbData.fromJson(value);
          userLogin(email: fbData!.email!, password: '123456');
        });
      }
    });
  }

  Future googleSignIn(context) async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign in Failed')));
    } else {
      userLogin(email: user.email, password: '123456');
    }
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
      print(loginModel!.data!.name);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
