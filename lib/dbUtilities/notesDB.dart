import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart ';
import 'package:path/path.dart';

import '../models/notesmodel.dart';

class NotesDB{
  
  static final NotesDB instance = NotesDB._init();

  static Database? _database; 


  //constructor to intialize db
  NotesDB._init();



  //1st step intilize db | open and close a connection to db

  //creating db
  Future<Database> get database async{
    //if db already exits
    if(_database !=null) return _database!;

    // if it doesn't exist
    _database = await _initDB('notes.db');
    return _database!;
  }


  //intiallise db
  Future<Database> _initDB(String filePath)async {

    //get location to store db
    final dbPath  = await getDatabasesPath();
    final path  = join(dbPath,filePath);
    return await openDatabase(path,version:1 , onCreate: _createDB);
  }

  Future close() async{
    final db = await instance.database;
    db.close(); 
  }
  //step 2 create db schema
  Future _createDB(Database db, int version ) async{
    const  idType = 'INTEGER PRIMARY KEY AUTO INCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const boolType =  ' BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    
    await db.execute('''
  CREATE TABLE $tableName (
    ${NotesDBColumns.id} $idType,
    ${NotesDBColumns.isImportant} $boolType,
    ${NotesDBColumns.number} $integerType,
    ${NotesDBColumns.title} $textType,
    ${NotesDBColumns.description} $textType,
    ${NotesDBColumns.time} $textType,
  )
''');
  }

  // step 3 CURD
  
  // insertion
Future<Note> create(Note note) async{ 


  final db  =  await instance.database;
  final id = await db.insert(tableName,note.toJson());
  // jo bhi insert kre ay uski id aye gi wapis apne pass | unique
  // is id ko hum apne note ki id pr update kre gay idk why???

  return note.copy(id:id);

}

// reading
Future<Note> readNote (int id)async{
  final db = await instance.database;
  final maps = await db.query(
    tableName,
     columns: NotesDBColumns.values,
     where: '${NotesDBColumns.id} = ?',
     whereArgs: [id]);
// this return a list of map each map is a note
// convert back to note from json map
//here a single note is need so returning the first one

if (maps.isNotEmpty)
{
  return Note.fromJson(maps.first);
}
else{
  throw Exception('ID $id not found');
}    
}
//reading all
Future<List<Note>> readALL()async{
  final db = await instance.database;
  final orderby = '${NotesDBColumns.time} ASC';
  final result = await db.query(tableName,orderBy: orderby);
  return result.map((json) => Note.fromJson(json)).toList();
}

//update
Future<int> update(Note note) async{
  final db = await instance.database;
  return db.update(tableName,
  note.toJson(),
  where: '${NotesDBColumns.id} = ?',
  whereArgs: [note.id]);
}


//delete
Future<int> delete(int id)async{
  final db = await instance.database;
  return await db.delete(
    tableName,
    where: '$NotesDBColumns.id = ?',
    whereArgs: [id], 
  );
}



}