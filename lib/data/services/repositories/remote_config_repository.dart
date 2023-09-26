import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepository {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  String getString(String key) => _remoteConfig.getString(key);
  bool getBool(String key) => _remoteConfig.getBool(key);
  int getInt(String key) => _remoteConfig.getInt(key);
  double getDouble(String key) => _remoteConfig.getDouble(key);

  Future<void> setConfigSettings() async => _remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ),
  );

  Future<bool> showTwitterSpaces() async {
    try {
      await _remoteConfig.fetchAndActivate();
      return _remoteConfig.getBool("show_spaces");
    } catch (e) {
      return false;
    }
  }
}
