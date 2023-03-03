import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testing/models/notesmodel.dart';

class noteCardTile extends StatelessWidget {
  final Note note;
  const noteCardTile({required this.note,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child:Column(children: [
        Text(note.createdTime.toString()),
        Text(note.title),
        Text(note.description)
      ],)
    );
  }
}