import 'package:flutter/cupertino.dart';
import 'package:recordatorios_app/core/services/secure_storage_service.dart';
import 'package:recordatorios_app/feature/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RegistrationStatus {
  initial,
  loading,
  success,
  error
}
enum LoginStatus { 
  initial, 
  loading, 
  success, 
  error 
}

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  RegistrationStatus _registrationStatus = RegistrationStatus.initial;
  LoginStatus _loginStatus = LoginStatus.initial;
  bool _isInitialized = false;

  final SecureStorageService _storageService = SecureStorageService();

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  RegistrationStatus get registrationStatus => _registrationStatus;
  LoginStatus get loginStatus => _loginStatus;

  bool get isInitialized => _isInitialized;

  AuthProvider() {
    _tryAutoLogin();
  }

  Future<void> _tryAutoLogin() async {
    final userEmail = await _storageService.getToken();

    if (userEmail != null) {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(userEmail);
      if (userJson != null) {
        _currentUser = User.fromJson(userJson);
      }
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> registerUser(String firstname, String lastname, String email, String password) async {
    _registrationStatus = RegistrationStatus.loading;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final prefs = await SharedPreferences.getInstance();
      
      final newUser = User(
        firtsname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      );

      print('GUARDANDO -> Clave: "[${email}]" | Valor: ${newUser.toJson()}');

      await prefs.setString(email, newUser.toJson());
      
      print('Usuario ${newUser.email} guardado persistentemente.');
      _registrationStatus = RegistrationStatus.success;

    } catch (e) {
      print('Ocurrió un error en registerUser: $e');
      _registrationStatus = RegistrationStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    _loginStatus = LoginStatus.loading;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      final String? userJson = prefs.getString(email);

      if (userJson == null) throw Exception('Usuario no encontrado');

      final user = User.fromJson(userJson);

      if (user.password == password) {
        _currentUser = user;
        _loginStatus = LoginStatus.success;

        await _storageService.saveToken(email);
        await _storageService.saveLastInteractionTime(DateTime.now());

      } else {
        throw Exception('Contraseña incorrecta');
      }
    } catch (e) {
      _loginStatus = LoginStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _loginStatus = LoginStatus.initial;
    
    await _storageService.deleteToken();
    
    print("Sesión cerrada correctamente.");
    notifyListeners();
  }

  void resetRegistrationStatus() {
    _registrationStatus = RegistrationStatus.initial;
    notifyListeners();
  }

  void resetLoginStatus() {
    _loginStatus = LoginStatus.initial;
    notifyListeners();
  }
}