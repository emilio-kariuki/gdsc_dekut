// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfilePadding extends StatelessWidget {
   ProfilePadding({
    super.key,
     this.thickness = 0.4
  });

  double ?thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 5,
      thickness: thickness,

    );
  }
}
