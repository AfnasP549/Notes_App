import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
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

    if(await authViewModel.verifyPin(pin)){
      Navigator.restorablePushNamed(context, '/NotesListScreen');
    }else{
      setState(() {
        _errorMessage = 'Invalid Pin';
      });
    }
  }

//!reset
void _resetPin() {
  showDialog(
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text('Reset PIN'),
      content: Text(
        'This will clear all notes and PIN. Are you sure?'
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Reset'),
          onPressed: () async{
            final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
            final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);

            await authViewModel.resetPin();
            await noteViewModel.resetData();
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/PinSetupScreen');
          },
        ),
      ],
    ));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter PIN'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pinController,
              decoration: InputDecoration(
                labelText: 'Enter Pin',
                errorText: _errorMessage,
                ),
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _login, 
              child: Text('Log in')),

              TextButton(onPressed: _resetPin, child: Text('Forget PIN?'))


          ],
        ),),
    );
  }
}