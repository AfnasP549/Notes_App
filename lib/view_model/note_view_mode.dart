import 'package:flutter/foundation.dart';
import 'package:secure_notes_app/model/note_model.dart';
import 'package:secure_notes_app/service/hive_service.dart';

class NoteViewModel extends ChangeNotifier{
  final HiveService _hiveService = HiveService();
  List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  Future<void> init()async{
    _notes = await _hiveService.getNotes();
    notifyListeners();
  }

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