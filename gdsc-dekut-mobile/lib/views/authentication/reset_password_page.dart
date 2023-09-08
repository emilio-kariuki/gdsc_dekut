import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/auth/auth_bloc/auth_bloc.dart';


class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff000000)),
        title: Text(
          'Reset Password',
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
                      AppImages.login,
                      height: height * 0.25,
                      width: width,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reset Password",
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
                      title: "Email",
                      controller: emailController,
                      hintText: "Enter your email",
                    ),
                    const SizedBox(
                      height: 10,
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
                                backgroundColor: Color.fromARGB(255, 31, 165, 83),
                                content: Text("Reset Email Sent"),
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
                                    context.read<AuthBloc>().add(
                                        ResetPasswordEvent(
                                            email: emailController.text));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff000000),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Reset Password",
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
