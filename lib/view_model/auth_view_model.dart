import 'package:flutter/widgets.dart';
import 'package:secure_notes_app/service/secure_storage_service.dart';

class AuthViewModel extends ChangeNotifier{
  final SecureStorageService _secureStorage = SecureStorageService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
//!pin setup
  Future<bool>setupPin(String pin) async {
    if(pin.length != 4 || !RegExp(r'^\d{4}$').hasMatch(pin)){
      return false;
    }
    await _secureStorage.savePin(pin);
    _isAuthenticated = true;
    notifyListeners();
    return true;
  }

  //!verification

  Future<bool> verifyPin(String pin)async{
    final storedPin = await _secureStorage.getPin();
    if(storedPin==pin){
      _isAuthenticated= true;
      notifyListeners();
      return true;
    }
    return false;
  }


  Future<bool> hasPin()async{
    return await _secureStorage.getPin() != null;
  }

  //!reset
  Future<void> resetPin()async{
    await _secureStorage.deletePin();
    _isAuthenticated = false;
    notifyListeners();
  }


  //!logout
  Future<void> logout()async{
    _isAuthenticated = false;
    notifyListeners();
  }

}