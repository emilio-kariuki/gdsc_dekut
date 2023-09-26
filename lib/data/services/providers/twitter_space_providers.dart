import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/twitter_model.dart';
import '../repositories/twitter_space_repository.dart';

class TwitterSpaceProviders {
  Future<bool> createSpace({
    required String title,
    required String link,
    required Timestamp startTime,
    required Timestamp endTime,
    required String image,
    required Timestamp date,
  }) async {
    final response = await TwitterSpaceRepository().createSpace(
      title: title,
      link: link,
      startTime: startTime,
      endTime: endTime,
      image: image,
      date: date,
    );
    return response;
  }

  Future<List<TwitterModel>> getSpaces() async {
    final response = await TwitterSpaceRepository().getSpaces();
    return response;
  }

  Future<List<TwitterModel>> searchSpace({required String query}) async {
    final response = await TwitterSpaceRepository().searchSpace(query: query);
    return response;
  }

  Future<TwitterModel> getParticularSpaces({required String id}) async {
    final response = await TwitterSpaceRepository().getParticularSpaces(id: id);
    return response;
  }

  Future<bool> updateSpace({
    required String id,
    required String title,
    required String link,
    required Timestamp startTime,
    required Timestamp endTime,
    required String image,
    required Timestamp date,
  }) async {
    final response = await TwitterSpaceRepository().updateSpace(
      id: id,
      title: title,
      link: link,
      startTime: startTime,
      endTime: endTime,
      image: image,
      date: date,
    );
    return response;
  }

  Future<bool> deleteParticularSpace({required String id}) async {
    final response =
        await TwitterSpaceRepository().deleteParticularSpace(id: id);
    return response;
  }
}
