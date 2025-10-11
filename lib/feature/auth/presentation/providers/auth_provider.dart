import 'package:flutter/cupertino.dart';
import 'package:recordatorios_app/feature/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RegistrationStatus {
  initial,  // Estado inicial, no se ha intentado nada
  loading,  // El proceso de registro está en curso
  success,  // El registro se completó con éxito
  error     // Ocurrió un error durante el registro
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

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  RegistrationStatus get registrationStatus => _registrationStatus;
  LoginStatus get loginStatus => _loginStatus;

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

      // --- PRINT DE DEPURACIÓN #2 ---
      // Muestra exactamente la clave que estás usando para buscar.
      print('BUSCANDO -> Clave: "[${email}]"');

      final String? userJson = prefs.getString(email);

      // --- PRINT DE DEPURACIÓN #3 ---
      // Muestra lo que SharedPreferences encontró con esa clave (o "NADA" si fue null).
      print('ENCONTRADO -> Valor: ${userJson ?? "NADA"}');

      if (userJson == null) {
        throw Exception('Usuario no encontrado');
      }

      final user = User.fromJson(userJson);

      if (user.password == password) {
        _currentUser = user;
        _loginStatus = LoginStatus.success;
      } else {
        throw Exception('Contraseña incorrecta');
      }

    } catch (e) {
      print('Error de inicio de sesión: $e');
      _loginStatus = LoginStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void resetRegistrationStatus() {
    _registrationStatus = RegistrationStatus.initial;
  }

  void resetLoginStatus() {
    _loginStatus = LoginStatus.initial;
    notifyListeners();
  }
  
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}