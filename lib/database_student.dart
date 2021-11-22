import 'package:path/path.dart' as p;

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../model_student.dart';



final int version_code = 1;
final String TableStudent = 'table_student';
final String Id = 'Id';
final String Name = 'name';
final String RollNo = 'roll_no';



class  DatabaseStudent {

  static Database? _database;

  DatabaseStudent._createInstance();

  static DatabaseStudent? _databaseStudent;


  factory DatabaseStudent(){
    if (_databaseStudent == null) {
      _databaseStudent = DatabaseStudent._createInstance();
    }
    return _databaseStudent!;
  }



  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase () async{
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath,'prayer_timning.db');

    Database database = await openDatabase(
        path,
        version: version_code,
        onCreate: (db, version) {
          db.execute('''
      create table $TableStudent (
      $Id INTEGER PRIMARY KEY AUTOINCREMENT,
      $Name text not null,
      $RollNo text not null 
      )
      ''');
        }
    );
    return database;

  }





  // Insert Record
  Future<bool> AddRecord(ModelStudent modelStudent) async {
    try {
      var db = await this.database;
      var result = await db.insert(TableStudent, modelStudent.toMap());
      return true;
    }
    catch (e) {
      print("Hello Error ${e.toString()}");
      return false;
    }
  }

  // Update Record
  Future<bool> UpdateRecord(ModelStudent modelStudent)async {
    try{
      var db= await this.database;
      await db.update(TableStudent, modelStudent.toMap(),
          where: '$Id = ?', whereArgs: [modelStudent.id]);
      return true;
    } catch(e){
      print("Error : ${e.toString()}");
      return false;
    }
  }

  Future<int> DeleteRecordByID(String id)  async {
    var db = await this.database;
    return await db.delete(TableStudent,where : '$Id =?',whereArgs : [id]);
  }

  Future<bool> DeleteAllRecord() async {
    try{
    var db = await this.database;
    await db.delete(TableStudent);
    return true;
    }
    catch(e){
      print("Hello Error ${e.toString()}");
      return false;
    }
  }


  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String,dynamic>> result = await db.query(TableStudent);
    return result.length;
  }

  Future<List<ModelStudent>> getAllRecord() async {
    List<ModelStudent> student_list = [];

    var db = await this.database;

    List<Map<String, dynamic>> result = await db.query(TableStudent);

    if (result.length > 0) {
      result.forEach((element) {
        ModelStudent model_student = ModelStudent.fromMap(element);

        print("element ${element}");
        print("Id : ${model_student.id}");
        print("Name : ${model_student.name}");
        print("Roll No : ${model_student.roll_no}");
        print("====================================================");

        student_list.add(model_student);
      });
      return student_list;
    } else {
      return null!;
    }
  }

}