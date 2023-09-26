import 'package:gdsc_bloc/data/services/repositories/remote_config_repository.dart';

class RemoteConfigProviders {
  Future<bool> showTwitterSpaces() async {
    final response = await RemoteConfigRepository().showTwitterSpaces();
    return response;
  }
}
