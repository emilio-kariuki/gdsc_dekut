// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/auth/auth_bloc/auth_bloc.dart';
import '../../blocs/minimal_functonality/password_visibility/password_visibility_cubit.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool isObscured = true;
  bool isObscured2 = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff000000)),
        title: AutoSizeText(
          'Forgot Password',
          style: GoogleFonts.inter(
            color: const Color(0xff000000),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
              primary: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      AppImages.login,
                      height: height * 0.25,
                      width: width,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    AutoSizeText(
                      "Forgot Password",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InputField(
                      controller: emailController,
                      hintText: "Enter your email",
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
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
                            obScureText: isObscured,
                            controller: oldPasswordController,
                            textInputType: TextInputType.visiblePassword,
                            maxLines: 1,
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            
                            },
                            suffixIcon: InkWell(
                              onTap: () {
                                context
                                    .read<PasswordVisibilityCubit>()
                                    .changePasswordVisibility(!isObscured);
                              },
                              child: Icon(
                                isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                                size: 20,
                              ),
                            ));
                            
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocProvider(
                      create: (context) => PasswordVisibilityCubit(),
                      child: Builder(builder: (context) {
                        return BlocConsumer<PasswordVisibilityCubit,
                            PasswordVisibilityState>(
                          listener: (context, state) {
                            if (state is PasswordObscured) {
                              isObscured2 = state.isObscured;
                            }
                          },
                          builder: (context, state) {
                            return InputField(
                                hintText: "Enter your password",
                                obScureText: isObscured2,
                                controller: newPasswordController,
                                textInputType: TextInputType.visiblePassword,
                                maxLines: 1,
                                validator: (value){
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                
                                },
                                suffixIcon: InkWell(
                                  radius: 0,
                                  splashColor: Colors.white,
                                  onTap: () {
                                    context
                                        .read<PasswordVisibilityCubit>()
                                        .changePasswordVisibility(!isObscured2);
                                  },
                                  child: Icon(
                                    isObscured2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ));
                          },
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is ResetPasswordSuccess) {
                          Timer(const Duration(seconds: 1), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    Color.fromARGB(255, 31, 165, 83),
                                content: Text("Password Changed Successfully"),
                              ),
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              "/login",
                            );
                          });
                        }
                        if (state is ResetPasswordFailure) {
                          Timer(
                              const Duration(seconds: 1),
                              () => ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xffEB5757),
                                      content: Text(state.message),
                                    ),
                                  ));
                        }
                        return state is ResetPasswordLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Color(0xff000000),
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<AuthBloc>().add(ChangePassword(
                                        email: emailController.text,
                                        oldPassword: oldPasswordController.text,
                                        newPassword:
                                            newPasswordController.text));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff000000),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: AutoSizeText(
                                    "Change Password",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffffffff),
                                    ),
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
                          "Dont remember your password?",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/reset_password");
                          },
                          child: AutoSizeText(
                            "Reset ",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
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
