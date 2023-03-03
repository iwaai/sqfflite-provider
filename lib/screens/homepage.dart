import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:testing/dbUtilities/notesDB.dart';
import 'package:testing/screens/noteDetailPage.dart';


import '../models/notesmodel.dart';
import '../widgets/noteCardTile.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  // sub sey phelay notes ki list ko utho app open hote hi
  // is loading ka ye kaam ha k jab jab ye fill hogi tab ye true hoga or build hoga dobara page ye
  // 
  //
  late List<Note> notes;
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
    this.notes = await NotesDB.instance.readALL();
        setState(() {
      isLoading = false;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Center(child: Text('S Q F F Y',style: TextStyle(fontSize: 30),)),
    ),
    body: Center(child: isLoading ?
     const CircularProgressIndicator() : 
     notes.isEmpty ?
      const Text('No Notes',
      style: TextStyle(color: Colors.white)) : buildView()
    )
    
    ,);

  
  }
  Widget buildView() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8.0),
    itemCount: 6,
    staggeredTileBuilder: (index)=> const StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context,index) {
      final note = notes[index];

      return GestureDetector(onTap: () async{
          await Navigator.of(context).push((MaterialPageRoute(builder: (context)=> noteDetailPage(noteid: note.id!))));
      },
      child: noteCardTile(note: note));
    }
);
}