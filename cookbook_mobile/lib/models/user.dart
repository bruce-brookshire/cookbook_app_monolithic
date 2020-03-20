part of 'api.dart';

class User {
  final String email;

  User(this.email);

  static User currentUser;

  static User _fromJson(Map content) {
    currentUser = User(content['email']);
    return currentUser;
  }

  static Future<User> createUser(
          String firstName, String lastName, String email, String password) =>
      HTTPInterface.post(
          '/users',
          {
            "name_first": firstName,
            "name_last": lastName,
            "email": email,
            "password": password,
          },
          _fromJson);
}
