import '../../models/leads_model.dart';
import '../repositories/lead_repository.dart';

class LeadProviders {
  Future<bool> createLead({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String github,
    required String twitter,
    required String bio,
    required String image,
  }) async {
    final response = await LeadRepository().createLead(
      name: name,
      email: email,
      phone: phone,
      role: role,
      github: github,
      twitter: twitter,
      bio: bio,
      image: image,
    );
    return response;
  }

  Future<List<LeadsModel>> getLeads() async {
    final response = await LeadRepository().getLeads();
    return response;
  }

  Future<LeadsModel> getLead({required String email}) async {
    final response = await LeadRepository().getLead(email: email);
    return response;
  }

  Future<bool> updateLead({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String github,
    required String twitter,
    required String bio,
    required String image,
  }) async {
    final response = await LeadRepository().updateLead(
      name: name,
      email: email,
      phone: phone,
      role: role,
      github: github,
      twitter: twitter,
      bio: bio,
      image: image,
    );
    return response;
  }

  Future<bool> deleteLead({required String email}) async {
    final response = await LeadRepository().deleteLead(email: email);
    return response;
  }
}
