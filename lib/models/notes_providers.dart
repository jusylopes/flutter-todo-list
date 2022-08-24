import 'package:flutter/widgets.dart';
import 'package:todolist_app/models/notes.dart';

class NotesProviders with ChangeNotifier {
  final List<Notes> _notes = [];
  List<Notes> get notes => [..._notes];

  void addNotes(String title, String descriptions) {
    Notes note = Notes(title, descriptions);
    _notes.add(note);
    notifyListeners();
  }

  void removeNotes(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
