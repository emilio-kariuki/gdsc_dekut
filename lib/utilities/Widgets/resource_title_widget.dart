import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourceWidget extends StatelessWidget {
  const ResourceWidget({
    super.key,
    required this.title,
    required this.location,
    this.arguments
  });
  final String title;
  final String location;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18
          )
        ),
        TextButton(
          style:Theme.of(context).textButtonTheme.style,
          onPressed: () {
            Navigator.pushNamed(context, location,arguments: arguments);
          },
          child: Text(
            "See all",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14
          ),
          ),
        )
      ],
    );
  }
}