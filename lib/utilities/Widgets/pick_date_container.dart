import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/minimal_functonality/pick_date/pick_date_cubit.dart';

class PickDateContainer extends StatelessWidget {
  const PickDateContainer({
    super.key,
    required this.dateController, required this.title,
  });

  final TextEditingController dateController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickDateCubit(),
      child: Builder(builder: (context) {
        return BlocConsumer<PickDateCubit, PickDateState>(
          listener: (context, state) {
            if (state is DatePicked) {
              dateController.text = state.date.toString().substring(0, 10);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  onTap: () async {
                    BlocProvider.of<PickDateCubit>(context)
                        .pickDate(context: context);
                  },
                  controller: dateController,
                  keyboardType: TextInputType.none,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Pick date",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
