import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/view/utils/app_color.dart';
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
      ///Private function for the notes list and floating action button respectively
      body: _buildNotesList(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildNotesList() {
    return Consumer<NoteViewModel>(
      builder: (context, noteViewModel, child) {
        return noteViewModel.notes.isEmpty
            ? _buildEmptyNotesView()
            : _buildNotesGrid(noteViewModel);
      },
    );
  }

  /// A centered Text widget that displays 'No notes' when there are no notes.
  Widget _buildEmptyNotesView() {
    return Center(child: Text('No notes'));
  }

  /// A GridView widget that displays the notes in a 2-column grid.
  /// The aspect ratio of the child widgets is 3:2.
  Widget _buildNotesGrid(NoteViewModel noteViewModel) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
      ),
      itemCount: noteViewModel.notes.length,
      itemBuilder: (context, index) => _buildNoteItem(noteViewModel, index),
    );
  }

  /// A single note item widget that displays the note's title and content.
  /// Tapping the note item will navigate to the note's edit screen.
  /// Long-pressing the note item will prompt the user to delete the note.
  Widget _buildNoteItem(NoteViewModel noteViewModel, int index) {
    final note = noteViewModel.notes[index];
    
    return GestureDetector(
      onLongPress: () => _handleNoteDeletion(context, noteViewModel, note.id),
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
          onTap: () => Navigator.pushNamed(
            context,
            '/NotesAddEditScreen',
            arguments: note,
          ),
        ),
      ),
    );
  }

  /// Prompts the user to confirm the deletion of a note and deletes the note if the user confirms.
  Future<void> _handleNoteDeletion(
    BuildContext context,
    NoteViewModel noteViewModel,
    String noteId,
  ) async {
    final confirmed = await DeleteConfirmationDialog.show(context);
    if (confirmed ?? false) {
      noteViewModel.deleteNote(noteId);
    }
  }

  /// A floating action button that allows the user to add a new note.
  /// When pressed, the button navigates to the note add/edit screen.
  Widget _buildFloatingActionButton() {
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, _) {
        final isDarkMode = themeViewModel.isDarkMode;

        return FloatingActionButton(
          backgroundColor: isDarkMode ? AppColor.fabDark : AppColor.fabLight,
          foregroundColor: isDarkMode ? AppColor.iconDark : AppColor.iconLight,
          onPressed: () => Navigator.pushNamed(context, '/NotesAddEditScreen'),
          child: Icon(Icons.add),
        );
      },
    );
  }
}