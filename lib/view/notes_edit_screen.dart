import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_notes_app/model/note_model.dart';
import 'package:secure_notes_app/view/widget/custom_elevated_button.dart';
import 'package:secure_notes_app/view/widget/custom_text_field.dart';
import 'package:secure_notes_app/view_model/note_view_mode.dart';

class NotesEditScreen extends StatefulWidget {
  const NotesEditScreen({super.key});

  @override
  State<NotesEditScreen> createState() => _NotesEditScreenState();
}

class _NotesEditScreenState extends State<NotesEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _errorMessage;
  NoteModel? _note;


  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_note == null) { // Only run once
    _note = ModalRoute.of(context)?.settings.arguments as NoteModel?;
    if (_note != null) {
      _titleController.text = _note!.title;
      _contentController.text = _note!.content;
    }
  }
}


  //!save note
  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      setState(() => _errorMessage = 'Title and content can not be empty');
      return;
    }
    final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);
    if (_note == null) {
      noteViewModel.addNote(title, content);
    } else {
      noteViewModel.updateNote(_note!.id, title, content);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_note == null ? 'New Note' : 'Edit Note')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              //!Title field
              CustomTextField(
                controller: _titleController,
                fontSize: 34, 
                hintText: 'Title',
                showBorder: false,
                errorText: _errorMessage,
                isTitleField: true,
                ),
              // TextField(
              //   controller: _titleController,style: TextStyle(fontSize: 34),
              //   decoration: InputDecoration(
              //     hintText: 'Title',
              //     hintStyle: TextStyle(fontSize: 34),
              //     errorText: _errorMessage,
              //     border: InputBorder.none
              //   ),
              // ),
              const SizedBox(height: 16),
              //!Content field
              CustomTextField(
                controller: _contentController,
                hintText: 'Content',
                maxLines: 30,),
              // TextField(
              //   controller: _contentController,
              //   decoration: const InputDecoration(
              //     hintText: 'Content',
              //     border: InputBorder.none,
              //     alignLabelWithHint: true
              //     ),
              //     maxLines: 30
              //   //keyboardType: TextInputType.multiline,
              // ),
              const SizedBox(height: 16),
              //!Button
              CustomElevatedButton(text: 'Save', onPressed: _saveNote,),
            ],
          ),
        ),
      ),
    );
  }
}
