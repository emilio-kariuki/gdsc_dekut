import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Lead/edit_admin_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../blocs/app_functionality/leads/leads_cubit.dart';
import '../../../../../../utilities/Widgets/admin/leads/admin_leads_card.dart';

class AppLeads extends StatelessWidget {
  AppLeads({super.key, this.tabController});

  final TabController? tabController;

  final TextEditingController imageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LeadsCubit()..getLeads(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<LeadsCubit, LeadsState>(
              builder: (context, state) {
                if (state is LeadsLoading) {
                  return SizedBox(
                    height: height * 0.75,
                    child: const Center(
                      child: LoadingCircle(),
                    ),
                  );
                } else if (state is LeadsSuccess) {
                  return state.leads.isEmpty
                      ? SizedBox(
                          height: height * 0.5,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(AppImages.oops,
                                  height: height * 0.2),
                              Text(
                                "leads not found",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: const Color(0xff666666),
                                ),
                              ),
                            ],
                          )),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: BlocConsumer<LeadsCubit, LeadsState>(
                            listener: (context, appState) {
                              if (appState is LeadsFetched) {
                                nameController.text = appState.lead.name ?? "";
                                emailController.text =
                                    appState.lead.email ?? "";
                                phoneController.text =
                                    appState.lead.phone ?? "";
                                roleController.text = appState.lead.role ?? "";
                                githubController.text =
                                    appState.lead.github ?? "";
                                twitterController.text =
                                    appState.lead.twitter ?? "";
                                bioController.text = appState.lead.bio ?? "";
                                imageController.text =
                                    appState.lead.image ?? "";

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EditLeadDialog(
                                      nameController: nameController,
                                      emailController: emailController,
                                      phoneController: phoneController,
                                      roleController: roleController,
                                      githubController: githubController,
                                      twitterController: twitterController,
                                      bioController: bioController,
                                      imageController: imageController,
                                      tabController: tabController!,
                                      context: context,
                                    );
                                  },
                                );
                              }
                            },
                            builder: (context, appState) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.leads.length,
                                itemBuilder: (context, index) {
                                  return AdminLeadsCard(
                                    id: state.leads[index].id ?? "",
                                    width: width,
                                    height: height,
                                    title: state.leads[index].name ?? "",
                                    description: state.leads[index].bio ?? "",
                                    link: state.leads[index].twitter ?? "",
                                    image: state.leads[index].image ??
                                        AppImages.eventImage,
                                    function: () async {
                                      BlocProvider.of<LeadsCubit>(context)
                                          .getLeadByEmail(
                                              email: state.leads[index].email ??
                                                  "");
                                    },
                                    completeFunction: () {
                                      BlocProvider.of<LeadsCubit>(context)
                                          .deleteLead(
                                              email: state.leads[index].email ??
                                                  "");
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        );
                } else if (state is LeadsError) {
                  return SizedBox(
                    height: height * 0.9,
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(AppImages.oops, height: height * 0.2),
                        Text(
                          "Leads not found",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: const Color(0xff666666),
                          ),
                        ),
                      ],
                    )),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
