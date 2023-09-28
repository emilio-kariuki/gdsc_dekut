import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';

import '../../../blocs/minimal_functonality/network_observer/network_bloc.dart';

class NoInternet extends StatelessWidget {
  NoInternet({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => NetworkBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
            body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.7,
                    width: width,
                    constraints: BoxConstraints(maxHeight: height * 0.8),
                    child: Image.asset(AppImages.no_internet),
                  ),
                  Text(
                    "No Internet connection",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: width,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<NetworkBloc>(context)
                              .add(NetworkObserve());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "Try Again",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      }),
    );
  }
}
