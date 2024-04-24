import 'package:flutter/foundation.dart';
import 'package:instagram_clone/data/auth_methods.dart';
import 'package:instagram_clone/models/userModel.dart';

// Providers: Providers are classes that expose data or services to other parts of the app.

// Consumers: Consumers are widgets that listen to changes in providers and automatically rebuild when the data changes.

// Change Notifiers: A common type of provider that notifies listeners when its internal state changes.

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get fetchUser => _user;

  final AuthenticationMethods _authenticationMethods = AuthenticationMethods();

  Future<void> refreshUserData() async {
    UserModel user = await _authenticationMethods.fetchUserData();

    _user = user;
    notifyListeners();
  }
}
