import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../home_screen/social_layout.dart';
import '../scocial_register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErorrlState) {
            ShowToast(msg: state.error, state: ToastStates.ERROR);
          }

          if (state is SocialLoginSucessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              NavigateAndFinsh(context: context, screen: SocialLayout());
            }).catchError((error) {});
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: const [
                  // deafaultTextButton(
                  //     onpressed: () {
                  //       NavigateAndFinsh(
                  //           context: context, screen: RegisterScreen());
                  //     },
                  //     text: 'skip'),
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Sign in now to comunicate with your friends',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          deaFaultFormField(
                            // suffixPress: () {},
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid Email';
                              }
                            },
                            label: 'Email Address',
                            prefixIcon: Icons.email_rounded,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          deaFaultFormField(
                            suffixIcon: SocialLoginCubit.get(context).suffix,
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            suffixPress: () {
                              SocialLoginCubit.get(context)
                                  .changeSuffixVisibilty();
                            },
                            controller: passwordController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid password';
                              }
                            },
                            label: 'Password',
                            prefixIcon: Icons.lock,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => Container(
                                    height: 50.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            SocialLoginCubit.get(context)
                                                .userlogIn(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        child: const Text('login')),
                                  ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              defaultTextButton(
                                  onpressed: () {
                                    NavigateTo(
                                        context: context,
                                        screen: RegisterScreen());
                                  },
                                  text: 'register now'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

//=====================================================
