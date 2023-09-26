import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
