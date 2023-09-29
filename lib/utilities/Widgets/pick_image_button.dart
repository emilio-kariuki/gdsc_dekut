import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/minimal_functonality/get_image/get_image_cubit.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({
    super.key,
    required this.imageController,
  });

  final TextEditingController imageController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetImageCubit(),
      child: Builder(builder: (context) {
        return BlocConsumer<GetImageCubit, GetImageState>(
          listener: (context, state) {
            if (state is ImagePicked) {
              imageController.text = state.imageUrl;
              Timer(
                const Duration(milliseconds: 300),
                () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(0xFF0C7319),
                    content: Text("Image uploaded"),
                  ),
                ),
              );
            }

            if (state is ImageError) {
              Timer(
                const Duration(milliseconds: 100),
                () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFFD5393B),
                    content: Text(state.message),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final width = MediaQuery.of(context).size.width;
            return SizedBox(
              height: 50,
              width: width * 0.4,
              child: state is ImageUploading
                  ? const LoadingCircle()
                  : ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<GetImageCubit>(context).getImage();
                      },
                      style:
                          Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                      child: Text(
                        "Attach File",
                      ),
                    ),
            );
          },
        );
      }),
    );
  }
}
