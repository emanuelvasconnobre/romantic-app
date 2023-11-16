import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';

class UserEntityMapCache {
  static final UserEntityMapCache _instance = UserEntityMapCache._internal();

  factory UserEntityMapCache() {
    return _instance;
  }

  UserEntityMapCache._internal();

  final Map<String, UserEntity> _cache = {};

  bool exists(String key) {
    return _cache.containsKey(key);
  }

  UserEntity? get(String key) {
    return _cache[key];
  }

  void set({required String key, required UserEntity value}) {
    _cache[key] = value;
  }
}
