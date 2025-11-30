import 'package:ratlozen_services/database/database_helper.dart';

class AuthService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<String?> signUp(String username, String password) async {
    // Check if username already exists
    // In a real app, you'd query the database for the username
    // For this local-only version, we'll assume usernames are unique for simplicity
    return await _dbHelper.createUser(username, password);
  }

  Future<Map<String, dynamic>?> signIn(String username, String password) async {
    return await _dbHelper.getUser(username, password);
  }
}

class User {
  final String id;
  final String username;

  User({required this.id, required this.username});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
    );
  }
}
