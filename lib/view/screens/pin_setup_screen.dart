// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:secure_notes_app/view/widget/custom_appbar.dart';
import 'package:secure_notes_app/view/widget/custom_elevated_button.dart';
import 'package:secure_notes_app/view/widget/custom_text_field.dart';
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
      appBar: CustomAppBar(title: 'Create PIN', centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
             CustomTextField(
              controller: _pinController,
              showBorder: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              labelText: 'Enter Pin',
              errorText: _erroeMessage,
              maxLength: 4,
              autofocus: true,
              ),
            
            SizedBox(height: 16,),
            CustomElevatedButton(text: 'Create PIN', onPressed: _setupPin)
          ],
        ),),

    );
  }
}

