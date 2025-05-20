// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view/widget/custom_appbar.dart';
import 'package:secure_notes_app/view/widget/custom_elevated_button.dart';
import 'package:secure_notes_app/view/widget/custom_text_field.dart';
import 'package:secure_notes_app/view_model/auth_view_model.dart';
import 'package:secure_notes_app/view_model/note_view_mode.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final _pinController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  //! login
  void _login() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final pin = _pinController.text.trim();

    if (await authViewModel.verifyPin(pin)) {
      Navigator.restorablePushNamed(context, '/NotesListScreen');
    } else {
      setState(() {
        _errorMessage = 'Invalid Pin';
      });
    }
  }

  //!reset
  void _resetPin() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Reset PIN'),
            content: Text('This will clear all notes and PIN. Are you sure?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Reset'),
                onPressed: () async {
                  final authViewModel = Provider.of<AuthViewModel>(
                    context,
                    listen: false,
                  );
                  final noteViewModel = Provider.of<NoteViewModel>(
                    context,
                    listen: false,
                  );

                  await authViewModel.resetPin();
                  await noteViewModel.resetData();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/PinSetupScreen');
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Enter PIN',centerTitle: true, ),
      //AppBar(title: Text('Enter PIN')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //!PIN for login
            CustomTextField(
              controller: _pinController,
              showBorder: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              labelText: 'Enter Pin',
              errorText: _errorMessage,
              maxLength: 4,
              autofocus: true,
              ),

            SizedBox(height: 16),
            
            CustomElevatedButton(text: 'Log in', onPressed: _login),

            TextButton(onPressed: _resetPin, child: Text('Forget PIN?', style: TextStyle(color: const Color.fromARGB(255, 195, 110, 104)),)),
          ],
        ),
      ),
    );
  }
}
