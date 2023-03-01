// dbtable name
final String tableName ='notes';

class NotesDBColumns{
static final String id = '_id';
static final String isImportant = 'isImportant';
static final String number = 'number';
static final String title = 'title';
static final String description ='description';
static final String time = 'time'; 

static final List<String> values = [id, isImportant,number,title,description,time];

}


class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  
  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });
  Note copy({
    int? id,
   bool? isImportant,
  int? number,
   String? title,
   String? description,
   DateTime? createdTime
  })=>Note(id: id ?? this.id, isImportant: isImportant ?? this.isImportant, number: number ?? this.number, title: title ?? this.title, description: description ?? this.description, createdTime: createdTime ?? this.createdTime);

static Note fromJson(Map<String,Object?>json) => Note(id: json[NotesDBColumns.id] as int?,isImportant: json[NotesDBColumns.isImportant]==1, number: json[NotesDBColumns.number] as int, title: json[NotesDBColumns.title] as String, description: json[NotesDBColumns.description] as String, createdTime: DateTime.parse(json[NotesDBColumns.time]as String));
  Map<String, Object?> toJson()=>{
    NotesDBColumns.id : id,
    NotesDBColumns.title : title,
    NotesDBColumns.isImportant: isImportant ?1: 0,
    NotesDBColumns.number : number,
    NotesDBColumns.description : description,
    NotesDBColumns.time : createdTime.toIso8601String()

  };

  
}