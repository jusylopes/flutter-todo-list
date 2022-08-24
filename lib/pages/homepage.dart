import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/components/note_list.dart';
import 'package:todolist_app/models/notes_providers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To do list :D',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<NotesProviders>(
          builder: ((context, value, child) {
            return value.notes.isNotEmpty
                ? ListView.builder(
                    itemCount: value.notes.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(value.notes.toString()),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          return await confirmDismissDialog(context);
                        },
                        onDismissed: (_) {
                          Provider.of<NotesProviders>(context, listen: false)
                              .removeNotes(index);
                        },
                        background: Container(
                          color: Colors.red[300],
                          child: const Center(
                            child: Text(
                              'Excluir Nota',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        child:
                            NoteList(notes: value.notes[index], index: index),
                      );
                    },
                  )
                : GestureDetector(
                    onTap: (() {
                      showAlertDialogNote(context);
                    }),
                    child: const Center(
                      child: Text('adicionar nota'),
                    ),
                  );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialogNote(context);
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Future<bool?> confirmDismissDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: const Text("Tem certeza de que deseja excluir esta nota?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("APAGAR")),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCELAR"),
            ),
          ],
        );
      },
    );
  }
}

showAlertDialogNote(BuildContext context) async {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Widget okButton = TextButton(
    child: const Text("adicionar"),
    onPressed: () {
      Provider.of<NotesProviders>(context, listen: false)
          .addNotes(title.text, description.text);
      Navigator.of(context).pop();
    },
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Adicionar uma nova nota:"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Título: "),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextField(
                maxLines: 3,
                controller: description,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Descrição: "),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
        actions: [
          okButton,
        ],
      );
    },
  );
}
