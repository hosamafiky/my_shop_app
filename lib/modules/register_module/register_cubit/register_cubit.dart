import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register_module/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  IconData? suffixIcon = Icons.visibility;

  void changeRegisterPasswordVisibility() {
    isSecure = !isSecure;
    suffixIcon = isSecure ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePassVisiblityState());
  }

  bool isFieldEmpty = true;
  void checkFieldEmpty(String value) {
    if (value.isNotEmpty) {
      isFieldEmpty = false;
      emit(RegisterCheckFieldEmptyState());
    } else {
      isFieldEmpty = true;
      emit(RegisterCheckFieldEmptyState());
    }
  }

  LoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(endPoint: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
