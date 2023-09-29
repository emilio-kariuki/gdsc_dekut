import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/app_developers/app_developers_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/profile_padding.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../data/services/providers/developer_providers.dart';

class ContactDeveloperPage extends StatelessWidget {
  const ContactDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
        title: Text(
          "Developer Contact",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff666666),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => AppDevelopersCubit()..getDevelopers(),
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "If you have any queries or suggestions,\n please feel free to contact us.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Contact Us",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<AppDevelopersCubit, AppDevelopersState>(
                builder: (context, state) {
                  if (state is AppDevelopersLoading) {
                    return SizedBox(
                      height: height * 0.65,
                      child: const Center(
                        child: LoadingCircle(),
                      ),
                    );
                  } else if (state is AppDevelopersSuccess) {
                    return state.appDevelopers.isEmpty
                        ? SizedBox(
                            height: height * 0.5,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(AppImages.oops,
                                    height: height * 0.2),
                                Text(
                                  "developers not found",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: const Color(0xff666666),
                                  ),
                                ),
                              ],
                            )),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                ProfilePadding(),
                            itemCount: state.appDevelopers.length,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              final developer = state.appDevelopers[index];
                              return ListTile(
                                onTap: () {
                                  DeveloperProviders().contactDeveloper(
                                      email: developer.email!);
                                },
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  height: height * 0.1,
                                  width: height * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 0.3, color: Colors.black54),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        AppImages.defaultImage,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  developer.name!,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  developer.role!,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff666666),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    DeveloperProviders().contactDeveloper(
                                        email: developer.email!);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xff666666),
                                    size: 20,
                                  ),
                                ),
                              );
                            }));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
