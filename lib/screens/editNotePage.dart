import 'package:flutter/material.dart';

import '../models/notesmodel.dart';
class editNotePage extends StatefulWidget {
  final Note note;
  
  const editNotePage({required this.note, super.key});

  @override
  State<editNotePage> createState() => _editNotePageState();
}

class _editNotePageState extends State<editNotePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}