// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/authentication/login_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/home.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/auth/auth_bloc/auth_bloc.dart';
import '../../blocs/minimal_functonality/password_visibility/password_visibility_cubit.dart';
import '../../utilities/Widgets/divider_or.dart';
import '../../utilities/Widgets/fade_in_route.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => PasswordVisibilityCubit(),
          ),
        ],
        child: Builder(builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      AppImages.register,
                      height: height * 0.25,
                      width: width,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    AutoSizeText(
                      "Register",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InputField(
                      controller: nameController,
                      hintText: "Enter your name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: emailController,
                      hintText: "Enter your email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<PasswordVisibilityCubit,
                        PasswordVisibilityState>(
                      listener: (context, state) {
                        if (state is PasswordObscured) {
                          isObscured = state.isObscured;
                        }
                      },
                      builder: (context, state) {
                        return InputField(
                            hintText: "Enter your password",
                            obScureText: state is PasswordObscured
                                ? state.isObscured
                                : true,
                                maxLines: 1,
                            controller: passwordController,
                            validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                            suffixIcon: InkWell(
                              radius: 0,
                                  splashColor: Colors.white,
                              onTap: () {
                                context
                                    .read<PasswordVisibilityCubit>()
                                    .changePasswordVisibility(!isObscured);
                              },
                              child: Icon(
                                state is PasswordObscured && state.isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).iconTheme.color,
                                size: 20,
                              ),
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is RegisterSuccess) {
                          Timer(
                            const Duration(seconds: 1),
                            () => Navigator.pushReplacementNamed(
                              context,
                              "/home",
                            ),
                          );
                        }

                        if (state is GoogleLoginSuccess) {
                          Timer(
                              const Duration(seconds: 1),
                              () => Navigator.pushReplacement(
                                    context,
                                    FadeInRoute(
                                      routeName: "/home",
                                      page: Home(),
                                    ),
                                  ));
                        }

                        if (state is GoogleLoginFailure) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xffEB5757),
                                      content: Text(state.message),
                                    ),
                                  );
                          });
                        }

                        if (state is RegisterFailure) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xffEB5757),
                                      content: Text(state.message),
                                    ),
                                  );
                          });
                        }
                        return state is RegisterLoading
                            ? const LoadingCircle()
                            : SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (nameController.text.isEmpty ||
                                        emailController.text.isEmpty ||
                                        passwordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor:
                                              const Color(0xffEB5757),
                                          content: Text(
                                              "Please fill all the fields"),
                                        ),
                                      );
                                    } else {
                                      context.read<AuthBloc>().add(
                                            Register(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ),
                                          );
                                    }
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                  child: AutoSizeText(
                                    "Register",
                                   
                                  ),
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Have an account?",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              FadeInRoute(
                                routeName: "/login",
                                page: LoginPage(),
                              ),
                            );
                          },
                          child: AutoSizeText(
                            "Sign in",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DividerOr(),
                    const SizedBox(
                      height: 25,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return state is GoogleLoginLoading
                            ?  const LoadingCircle()
                            : SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(GoogleAuthentication());
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.google,
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      AutoSizeText(
                                        "Sign in with Google",
                                       
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
