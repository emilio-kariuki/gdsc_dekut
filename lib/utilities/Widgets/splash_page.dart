import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/bottom_bar/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => Home())));
    });
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 30),
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child:  Center(
            child: Center(
          child: SizedBox(
              height: 30,
              width: 30,
              child: SpinKitFadingCircle(
                color: Theme.of(context).iconTheme.color,
                size: 30,
              )),
        )),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
            child: Image.asset(
          AppImages.logo_png,
          height: height * 0.35,
          width: width,
        )),
      ),
    );
  }
}
