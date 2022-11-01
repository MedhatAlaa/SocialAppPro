import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/components/reus_components.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/login_cubit/login_cubit.dart';
import 'package:social_app/modules/social_login/login_cubit/login_states.dart';
import 'package:social_app/modules/social_register/social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              message: state.error,
              state: ToastState.error,
            );
          }
          if (state is SocialLoginSuccessState) {
            navigateAndFinish(
              context,
              const SocialLayout(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: SocialCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'Login now to communicat with friends',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: SocialCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 22.0,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      defaultFormField(
                        controller: emailController,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        prefixIcon: const Icon(
                          IconBroken.User,
                          color: Colors.amberAccent,
                        ),
                        labelText: 'Email',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: SocialLoginCubit.get(context).isPassword,
                        prefixIcon: const Icon(
                          IconBroken.Unlock,
                          color: Colors.amberAccent,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordIcon();
                            },
                            icon: Icon(
                              SocialLoginCubit.get(context).isPassword
                                  ? IconBroken.Hide
                                  : IconBroken.Show,
                              color: Colors.amberAccent,
                            )),
                        labelText: 'Password',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                  ),
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ?',
                            style: TextStyle(
                              color: SocialCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                SocialRegisterScreen(),
                              );
                            },
                            child: const Text(
                              'REGISTER',
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
