import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_notes_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final TextEditingController _pinController = TextEditingController();
  String? _erroeMessage;


  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _setupPin() async{
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final pin = _pinController.text.trim();

    if(await authViewModel.setupPin(pin)){
      Navigator.pushReplacementNamed(context, '/PinLoginScreen');
    }else{
      setState(() {
        _erroeMessage = 'Invalid Pin';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pin Setup'),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              decoration: InputDecoration(
                labelText: 'Enter Pin',
                errorText: _erroeMessage,
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _setupPin, 
              child: Text('Set PIN'))
          ],
        ),),

    );
  }
}

