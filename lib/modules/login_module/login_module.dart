import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/layout/layout_screen.dart';
import 'package:shop_app/modules/login_module/login_cubit/login_cubit.dart';
import 'package:shop_app/modules/login_module/login_cubit/login_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (!state.loginModel.status!) {
              var message = state.loginModel.message;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message!),
                ),
              );
            } else {
              CacheHelper.saveData(key: 'Login', value: true).then((value) {
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) => {
                          navigateTo(
                            context,
                            const ShopLayout(),
                          )
                        });
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                  ),
                );
              });
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 16.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 34.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 73.0),
                      customFormField(
                        label: 'Email Address',
                        hint: 'Write your email address...',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email Address is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      customFormField(
                        label: 'Password',
                        hint: 'Write your password...',
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: !cubit.isFieldEmpty
                            ? IconButton(
                                icon: Icon(cubit.suffixIcon),
                                onPressed: () =>
                                    cubit.changeLoginPasswordVisibility(),
                              )
                            : null,
                        isSecure: cubit.isSecure,
                        controller: passwordController,
                        onChanged: (value) => cubit.checkFieldEmpty(value),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Forgot your password?',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_right_alt,
                                color: buttonColor,
                                size: 26.0,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      customButton(
                        child: state is LoginLoadingState
                            ? const SizedBox(
                                width: double.infinity,
                                height: 48.0,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : null,
                        text: 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 80.0),
                      const Text(
                        'Or login with social account',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 92.0,
                              height: 64.0,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 34.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/google.png'),
                                width: 23.5,
                                height: 23.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 92.0,
                              height: 64.0,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 34.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/facebook.png'),
                                width: 23.5,
                                height: 23.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
