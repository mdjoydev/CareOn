import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession extends ChangeNotifier {
  UserSession._();

  static final UserSession instance = UserSession._();

  String? name;
  String? phone;
  String? email;
  String? photoPath;
  bool hasSeenOnboarding = false;

  static const String _keyName = 'user_name';
  static const String _keyPhone = 'user_phone';
  static const String _keyEmail = 'user_email';
  static const String _keyPhoto = 'user_photo';
  static const String _keyOnboarding = 'has_seen_onboarding';

  Future<void> saveSession({String? name, String? phone, String? email, String? photoPath}) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (name != null) {
      this.name = name;
      await prefs.setString(_keyName, name);
    }
    if (phone != null) {
      this.phone = phone;
      await prefs.setString(_keyPhone, phone);
    }
    if (email != null) {
      this.email = email;
      await prefs.setString(_keyEmail, email);
    }
    if (photoPath != null) {
      this.photoPath = photoPath;
      await prefs.setString(_keyPhoto, photoPath);
    }
    notifyListeners();
  }

  Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    hasSeenOnboarding = true;
    await prefs.setBool(_keyOnboarding, true);
    notifyListeners();
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString(_keyName);
    phone = prefs.getString(_keyPhone);
    email = prefs.getString(_keyEmail);
    photoPath = prefs.getString(_keyPhoto);
    hasSeenOnboarding = prefs.getBool(_keyOnboarding) ?? false;
    notifyListeners();
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    name = null;
    phone = null;
    email = null;
    photoPath = null;
    // We usually keep hasSeenOnboarding = true even after logout
    await prefs.remove(_keyName);
    await prefs.remove(_keyPhone);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPhoto);
    notifyListeners();
  }
}
