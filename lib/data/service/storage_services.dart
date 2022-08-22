import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  // for restoring prev playback time
  static Future setPlaybackValue(int value, int keyId) async =>
      await _preferences?.setInt(keyId.toString(), value);

  static int? getPlaybackValue(int keyId) => _preferences?.getInt(keyId.toString());

  // for storing like stats
  static Future setLikeStatsValue(int value, int keyId) async =>
      await _preferences?.setInt('likeStats$keyId', value);

  static int? getLikeStatsValue(int keyId) => _preferences?.getInt('likeStats$keyId');

  // for storing Dislike stats
  static Future setDislikeStatsValue(int value, int keyId) async =>
      await _preferences?.setInt('dislikeStats$keyId', value);

  static int? getDislikeStatsValue(int keyId) => _preferences?.getInt('dislikeStats$keyId');
}
