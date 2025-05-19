import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view/widget/custom_appbar.dart';
import 'package:secure_notes_app/view/widget/delete_confirmation.dart';
import 'package:secure_notes_app/view_model/note_view_mode.dart';
import 'package:secure_notes_app/view_model/theme_view_model.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    Provider.of<NoteViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Created custom appBar with optionally dark mode toggle
      appBar: CustomAppBar(title: 'Notes', showDarkModeToggle: true),
      body: Consumer<NoteViewModel>(
        builder: (context, noteViewModel, child) {
          return noteViewModel.notes.isEmpty
              ? Center(child: Text('No notes'))
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                ),

                itemCount: noteViewModel.notes.length,
                itemBuilder: (context, index) {
                  final note = noteViewModel.notes[index];
                  return GestureDetector(
                    onLongPress: () async {
                      final confirmed = await DeleteConfirmationDialog.show(
                        context,
                      );
                      if (confirmed ?? false) {
                        noteViewModel.deleteNote(note.id);
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          note.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          note.content.length > 50
                              ? '${note.content.substring(0, 50)}...'
                              : note.content,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              '/NotesAddEditScreen',
                              arguments: note,
                            ),
                      ),
                    ),
                  );
                },
              );
        },
      ),

      floatingActionButton: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, _) {
          final isDarkMode = themeViewModel.isDarkMode;

          return FloatingActionButton(
            backgroundColor: isDarkMode ? Colors.tealAccent : Colors.teal,
            foregroundColor: isDarkMode ? Colors.black : Colors.white,
            onPressed: 
                () => Navigator.pushNamed(context, '/NotesAddEditScreen'),
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
