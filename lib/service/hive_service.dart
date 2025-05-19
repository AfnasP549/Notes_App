import 'package:hive_flutter/hive_flutter.dart';
import 'package:secure_notes_app/model/note_model.dart';

class HiveService{
  static const String _boxName = 'notes';

  Future<void> init()async{
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

//!save
  Future<void> save(NoteModel note) async{
    final box = await Hive.openBox(_boxName);
    await box.put(note.id, note.toJson());
  }

//!get
  Future<List<NoteModel>> getNotes()async{
    final box = await Hive.openBox(_boxName);
    final notes = box.values.map((e) => NoteModel.fromjson(Map<String, dynamic>.from(e))).toList();
    return notes;
  }
//!delete
  Future<void> deleteNnote(String id)async{
    final box = await Hive.openBox(_boxName);
    await box.delete(id);
  }

//!clear
  Future<void> clearAllData() async{
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }

}