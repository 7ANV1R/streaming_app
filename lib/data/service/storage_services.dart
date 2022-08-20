import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  // static const _keyPlaybackValue = 'playbackValue';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setPlaybackValue(int value, int keyId) async =>
      await _preferences?.setInt(keyId.toString(), value);

  static int? getPlaybackValue(int keyId) => _preferences?.getInt(keyId.toString());
}
