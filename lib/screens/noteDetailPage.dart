
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/dbUtilities/notesDB.dart';
import 'package:testing/screens/editNotePage.dart';
import '../models/notesmodel.dart';
import 'package:intl/date_symbol_data_local.dart';

class noteDetailPage extends StatefulWidget {
  final int noteid;

  const noteDetailPage({required this.noteid,super.key});

  @override
  State<noteDetailPage> createState() => _noteDetailPageState();
}

class _noteDetailPageState extends State<noteDetailPage> {
  @override

  late Note note;
  bool isLoading = false;

  @override
  void initState()
  {
    super.initState();
    refreshNotes();  
  }

  Future refreshNotes () async{
    setState(() {
      isLoading = true;
    });
    // ignore: unnecessary_this
    this.note = await NotesDB.instance.readNote(widget.noteid);
        setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    // note id sirf manga rahe peeche sey tu idhr id sey match kr k desired display kre gay

    return Scaffold(appBar: AppBar(actions: []),
    body: isLoading ? const Center(child: CircularProgressIndicator(),):
    Padding(padding:const EdgeInsets.all(12),
    child: ListView(children: [
      Text(note.title,style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
      const SizedBox(height: 8,),
    Text(DateFormat.yMMMd().format(note.createdTime),
        style: const TextStyle(color: Colors.white38),),
       const SizedBox(height: 8,),
       Text(note.description,
            style:const TextStyle(color: Colors.white70),)
    ]),),);
  }

  Widget delteButton()=> IconButton(
   onPressed: () async {
    await NotesDB.instance.delete(widget.noteid);
    Navigator.of(context).pop();},
   icon: const Icon(Icons.delete));

   Widget editButton()=> 
   IconButton(
    onPressed: () async { if (isLoading) return; await Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=> editNotePage(note: note,)));},
   icon: const Icon(Icons.edit_outlined));

  
}