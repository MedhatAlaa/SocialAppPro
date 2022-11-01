import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/icon_broken.dart';
import 'package:social_app/components/reus_components.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_register/register_cubit/register_cubit.dart';
import 'package:social_app/modules/social_register/register_cubit/register_states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterErrorState) {
            showToast(
              message: state.error,
              state: ToastState.error,
            );
          }
          if (state is SocialUserCreateSuccessState) {
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
                        'REGISTER',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: SocialCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0001,
                      ),
                      Text(
                        'Register now to communicat with friends',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: SocialCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 22.0,
                            ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      defaultFormField(
                        controller: nameController,
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcon: const Icon(
                          IconBroken.User,
                          color: Colors.amberAccent,
                        ),
                        labelText: 'Name',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                          IconBroken.Info_Circle,
                          color: Colors.amberAccent,
                        ),
                        labelText: 'Email',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        validator: (phone) {
                          if (phone!.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        prefixIcon: const Icon(
                          IconBroken.Call,
                          color: Colors.amberAccent,
                        ),
                        labelText: 'Phone',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                        obscureText:
                            SocialRegisterCubit.get(context).isPassword,
                        prefixIcon: const Icon(
                          IconBroken.Unlock,
                          color: Colors.amberAccent,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordIcon();
                          },
                          icon: Icon(
                            SocialRegisterCubit.get(context).isPassword
                                ? IconBroken.Hide
                                : IconBroken.Show,
                            color: Colors.amberAccent,
                          ),
                        ),
                        labelText: 'Password',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
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
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            child: Text(
                              'REGISTER',
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
