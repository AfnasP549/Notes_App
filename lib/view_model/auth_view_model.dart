import 'package:flutter/widgets.dart';
import 'package:secure_notes_app/service/secure_storage_service.dart';

class AuthViewModel extends ChangeNotifier{
  final SecureStorageService _secureStorage = SecureStorageService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
//!pin setup
  /// Saves a 4-digit pin to the secure storage.
  /// If the pin is valid (4 digits and matches the regular expression
  /// `^\d{4}$`), it is saved to the secure storage and the
  /// `isAuthenticated` flag is set to `true`. Otherwise, `false` is
  /// returned and the `isAuthenticated` flag is not changed.
  /// This method notifies the listeners after the operation is complete.

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

  /// Verifies if the given PIN matches the PIN stored in the secure storage.
  /// If the PINs match, the `isAuthenticated` flag is set to `true`.
  /// This method notifies the listeners after the operation is complete.
  /// Returns `true` if the PINs match, otherwise returns `false`.
  Future<bool> verifyPin(String pin)async{
    final storedPin = await _secureStorage.getPin();
    if(storedPin==pin){
      _isAuthenticated= true;
      notifyListeners();
      return true;
    }
    return false;
  }


  /// Checks if a PIN is stored in the secure storage.
  /// Returns `true` if a PIN is found, otherwise returns `false`.

  Future<bool> hasPin()async{
    return await _secureStorage.getPin() != null;
  }

  //!reset
  /// Deletes the PIN from the secure storage and sets the `isAuthenticated`
  /// flag to `false`. This method notifies the listeners after the operation
  /// is complete.
  Future<void> resetPin()async{
    await _secureStorage.deletePin();
    _isAuthenticated = false;
    notifyListeners();
  }

}