
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _username = '';
  String _password = '';
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  String get username => _username;
  String get password => _password;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Setters
  void setUsername(String value) {
    _username = value.trim();
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  // Simple validation
  bool validate() {
    return _username.isNotEmpty && _password.isNotEmpty;
  }

  // Login using Firebase Auth
  Future<void> login() async {
    if (!validate()) {
      _errorMessage = 'Username and password cannot be empty';
      _isLoggedIn = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('Attempting sign-in for: $_username');
      // trim email before sending to firebase
      final email = _username.trim();
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: _password,
      );
      debugPrint('Sign-in succeeded for: $email');
      _isLoggedIn = true;
      _errorMessage = null;
    } catch (e) {
      debugPrint('Sign-in error: $e');
      _isLoggedIn = false;
      // Provide a clearer message for FirebaseAuthException
      if (e is FirebaseAuthException) {
        _errorMessage = e.message ?? e.code;
      } else {
        _errorMessage = e.toString();
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // Create a new account using Firebase Auth
  Future<void> signup() async {
    if (!validate()) {
      _errorMessage = 'Username and password cannot be empty';
      _isLoggedIn = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _username,
        password: _password,
      );
      _isLoggedIn = true;
      _errorMessage = null;
    } catch (e) {
      debugPrint('Signup error: $e');
      _isLoggedIn = false;
      if (e is FirebaseAuthException) {
        _errorMessage = e.message ?? e.code;
      } else {
        _errorMessage = e.toString();
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    _isLoggedIn = false;
    notifyListeners();
  }
}