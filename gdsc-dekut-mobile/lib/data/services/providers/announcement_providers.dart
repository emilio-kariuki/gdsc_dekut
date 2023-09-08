import '../../models/announcement_model.dart';
import '../repositories/announcement_repository.dart';

class AnnouncementProviders {
  Future<bool> createAnnouncement(
      {required String name,
      required String position,
      required String title}) async {
    final response = await AnnouncementRepository()
        .createAnnouncement(name: name, position: position, title: title);
    return response;
  }

  Stream<List<AnnouncementModel>> getAnnoucements() async* {
    final response = AnnouncementRepository().getAnnoucements();
    yield* response;
  }

  Future<List<AnnouncementModel>> getAllAnnouncements() async {
    final response = await AnnouncementRepository().getAllAnnouncements();
    return response;
  }

  Future<List<AnnouncementModel>> searchAnnouncement(
      {required String query}) async {
    final response =
        await AnnouncementRepository().searchAnnouncement(query: query);
    return response;
  }

  Future<AnnouncementModel> getParticularAnnouncement(
      {required String id}) async {
    final response =
        await AnnouncementRepository().getParticularAnnouncement(id: id);
    return response;
  }

  Future<bool> updateParticularAnnouncement(
      {required String id,
      required String name,
      required String position,
      required String title}) async {
    final response = await AnnouncementRepository().updateAnnouncement(
        id: id, name: name, position: position, title: title);
    return response;
  }

  Future<bool> deleteParticularAnnouncement({required String id}) async {
    final response = await AnnouncementRepository().deleteAnnoucement(id: id);
    return response;
  }
}
