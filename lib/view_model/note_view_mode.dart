import 'package:flutter/foundation.dart';
import 'package:secure_notes_app/model/note_model.dart';
import 'package:secure_notes_app/service/hive_service.dart';

class NoteViewModel extends ChangeNotifier{
  final HiveService _hiveService = HiveService();
  List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  /// Initializes the notes list by fetching the notes from the database and
  /// notifies the listeners. This must be called before any other methods on this class.
  Future<void> init()async{
    _notes = await _hiveService.getNotes();
    notifyListeners();
  }

  /// Fetches the notes from the database and notifies the listeners.
  /// This is a utility method that can be used to update the notes list
  /// without having to call [init] again.
  Future<void>fetchNotes()async{
    _notes = await _hiveService.getNotes();
    notifyListeners();
  }

//!create
  Future<void> addNote(String title, String content) async{
    final note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      title: title, 
      content: content, 
      lastModified: DateTime.now());
    await _hiveService.save(note);
    await fetchNotes();
  }

  //!update
  Future<void>updateNote(String id, String title, String content) async {
    final note = NoteModel(
      id: id, 
      title: title, 
      content: content, 
      lastModified: DateTime.now());
    await _hiveService.save(note);
    await fetchNotes();
  }

  //!delete
  Future<void> deleteNote(String id)async{
    await _hiveService.deleteNnote(id);
    await fetchNotes();
  }

  //!reset
  Future<void> resetData()async{
    await _hiveService.clearAllData();
    await fetchNotes();
  }
}