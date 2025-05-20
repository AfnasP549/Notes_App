import 'package:flutter/material.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view/screens/notes_edit_screen.dart';
import 'package:secure_notes_app/view/screens/notes_list_screen.dart';
import 'package:secure_notes_app/view/screens/pin_login_screen.dart';
import 'package:secure_notes_app/view/screens/pin_setup_screen.dart';
import 'package:secure_notes_app/view/screens/splash_screen.dart';
import 'package:secure_notes_app/view_model/auth_view_model.dart';
import 'package:secure_notes_app/view_model/note_view_mode.dart';
import 'package:secure_notes_app/view_model/theme_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocuDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocuDir.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthViewModel()),
        ChangeNotifierProvider(create: (_)=> NoteViewModel()),
        ChangeNotifierProvider(create: (_)=> ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          
          
          title: 'Secure Notes',
          theme: themeViewModel.theme,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/AuthCheck': (context) => const AuthCheck(),
            '/PinSetupScreen': (context) => const PinSetupScreen(),
            '/PinLoginScreen': (context) => const PinLoginScreen(),
            '/NotesListScreen': (context) => const NotesListScreen(),
            '/NotesAddEditScreen': (context) => const NotesEditScreen(),
          },
        ),
      ),
    );
  }
}


class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final notesViewModel = Provider.of<NoteViewModel>(context, listen: false);


    return FutureBuilder<bool>(
      future: authViewModel.hasPin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } 
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (snapshot.data == true) {
           Navigator.pushReplacementNamed(context, '/PinLoginScreen');
          }else{
           Navigator.pushReplacementNamed(context, '/PinSetupScreen');
          }
          notesViewModel.init();
        });
        return Scaffold(
          body: Center(child: 
          const CircularProgressIndicator(),),
        );
      },
    );
  }
}