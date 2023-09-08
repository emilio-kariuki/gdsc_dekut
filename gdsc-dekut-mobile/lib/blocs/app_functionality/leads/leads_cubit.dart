import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gdsc_bloc/data/models/leads_model.dart';

import '../../../data/services/providers/lead_providers.dart';

part 'leads_state.dart';

class LeadsCubit extends Cubit<LeadsState> {
  LeadsCubit() : super(LeadsInitial());

  void createLead({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String github,
    required String twitter,
    required String bio,
    required String image,
  }) async {
    try {
      emit(LeadsLoading());
      final isCreated = await LeadProviders().createLead(
        name: name,
        email: email,
        phone: phone,
        role: role,
        github: github,
        twitter: twitter,
        bio: bio,
        image: image,
      );

      if (isCreated) {
        emit(LeadsCreated());
      }
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  void getLeads() async {
    try {
      emit(LeadsLoading());
      final leads = await LeadProviders().getLeads();
      emit(LeadsSuccess(leads: leads));
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  void getLeadByEmail({required String email}) async {
    try {
      emit(LeadsLoading());
      final lead = await LeadProviders().getLead(email: email);
      emit(LeadsFetched(lead: lead));
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  void updateLead({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String github,
    required String twitter,
    required String bio,
    required String image,
  }) async {
    try {
      emit(LeadsLoading());
      final isCreated = await LeadProviders().updateLead(
        name: name,
        email: email,
        phone: phone,
        role: role,
        github: github,
        twitter: twitter,
        bio: bio,
        image: image,
      );

      if (isCreated) {
        emit(LeadsUpdated());
      }
    } catch (e) {
      emit(const LeadsError(message: "Failed to update the lead"));
    }
  }

  void deleteLead({required String email}) async {
    try {
      final isDeleted = await LeadProviders().deleteLead(email: email);
      if (isDeleted) {
        emit(LeadsDeleted());
      }
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }
}
