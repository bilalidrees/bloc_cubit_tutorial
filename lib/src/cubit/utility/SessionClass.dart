import 'package:pokdex/src/model/User.dart';

class SessionClass {
  static SessionClass? sessionClass;
  User? _currentUser;

  static Future<SessionClass?> getInstance() async {
    if (sessionClass == null) {
      sessionClass = new SessionClass();
    }
    return sessionClass;
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  User? getCurrentUser() {
    return _currentUser;
  }
}
