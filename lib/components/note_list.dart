import 'package:flutter/material.dart';
import 'package:todolist_app/models/notes.dart';

class NoteList extends StatelessWidget {
  final Notes notes;
  final int index;

  const NoteList({super.key, required this.notes, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          )),
      child: ListTile(
        leading: Icon(
          Icons.book,
          color: Theme.of(context).primaryColor,
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            notes.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(notes.description),
        trailing: const Icon(
          Icons.delete,
        ),
      ),
    );
  }
}
