import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(
          color: Theme.of(context).iconTheme.color,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
