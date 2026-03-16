import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProfile {
  String name;
  int age;
  String skinType; // oily, dry, combination, normal, sensitive
  String country;
  String state;
  String climate; // humid, dry, cold, tropical
  String budget; // low (under 500), medium (500-2000), high (2000+)
  bool hasBeard;
  bool smokingHabit;
  bool drinkingHabit;
  String profileImagePath;
  List<String> skinConcerns;

  UserProfile({
    this.name = '',
    this.age = 25,
    this.skinType = 'normal',
    this.country = 'India',
    this.state = '',
    this.climate = 'tropical',
    this.budget = 'medium',
    this.hasBeard = false,
    this.smokingHabit = false,
    this.drinkingHabit = false,
    this.profileImagePath = '',
    List<String>? skinConcerns,
  }) : skinConcerns = skinConcerns ?? [];

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'skinType': skinType,
        'country': country,
        'state': state,
        'climate': climate,
        'budget': budget,
        'hasBeard': hasBeard,
        'smokingHabit': smokingHabit,
        'drinkingHabit': drinkingHabit,
        'profileImagePath': profileImagePath,
        'skinConcerns': skinConcerns,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] ?? '',
        age: json['age'] ?? 25,
        skinType: json['skinType'] ?? 'normal',
        country: json['country'] ?? 'India',
        state: json['state'] ?? '',
        climate: json['climate'] ?? 'tropical',
        budget: json['budget'] ?? 'medium',
        hasBeard: json['hasBeard'] ?? false,
        smokingHabit: json['smokingHabit'] ?? false,
        drinkingHabit: json['drinkingHabit'] ?? false,
        profileImagePath: json['profileImagePath'] ?? '',
        skinConcerns: List<String>.from(json['skinConcerns'] ?? []),
      );
}

class UserProvider extends ChangeNotifier {
  UserProfile _profile = UserProfile();
  bool _isProfileComplete = false;

  UserProfile get profile => _profile;
  bool get isProfileComplete => _isProfileComplete;

  UserProvider() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('user_profile');
    if (profileJson != null) {
      _profile = UserProfile.fromJson(json.decode(profileJson));
      _isProfileComplete = _profile.name.isNotEmpty;
      notifyListeners();
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
    _isProfileComplete = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile', json.encode(profile.toJson()));
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    int? age,
    String? skinType,
    String? country,
    String? state,
    String? climate,
    String? budget,
    bool? hasBeard,
    bool? smokingHabit,
    bool? drinkingHabit,
    String? profileImagePath,
    List<String>? skinConcerns,
  }) async {
    _profile = UserProfile(
      name: name ?? _profile.name,
      age: age ?? _profile.age,
      skinType: skinType ?? _profile.skinType,
      country: country ?? _profile.country,
      state: state ?? _profile.state,
      climate: climate ?? _profile.climate,
      budget: budget ?? _profile.budget,
      hasBeard: hasBeard ?? _profile.hasBeard,
      smokingHabit: smokingHabit ?? _profile.smokingHabit,
      drinkingHabit: drinkingHabit ?? _profile.drinkingHabit,
      profileImagePath: profileImagePath ?? _profile.profileImagePath,
      skinConcerns: skinConcerns ?? _profile.skinConcerns,
    );
    await saveProfile(_profile);
  }
}
