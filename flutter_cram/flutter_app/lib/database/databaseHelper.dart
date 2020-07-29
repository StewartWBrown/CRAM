import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import '../model/subject.dart';

class DatabaseHelper{

  static final _dbName = 'subjectDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'subjects';

  // Column names of Subjects table
  static final columnSubjectName= 'SubjectName';
  static final columnWorkloads= 'NumberOfWorkloads';
  static final columnDifficulty ='Difficulty';
  static final columnStartDate = 'startDate';
  static final columnEndDate = 'endDate';
  static final columnExamDate = 'examDate';

  // column names of workloads table
  static final columnWorkloadID= '_workload ID';
  static final columnSubID= 'Subject ID';
  static final columnWorkloadName = 'workload name';
  static final columnWorkloadNumber ='workload number';
  static final columnCompleted = 'Completed?';


  // Making a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _subjectDatabase;

  Future<Database> get database async{
    if(_subjectDatabase != null) return _subjectDatabase;

    _subjectDatabase = await _initiateDatabase();
    return _subjectDatabase;
  }

  _initiateDatabase() async{
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path,_dbName);
    print("CREATING DATABASE");
    var myOwnDB = await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    return myOwnDB;
  }

  Future _onCreate(Database db, int version) async{
    await db.execute(
        '''
      CREATE TABLE $_tableName(
      $columnSubjectName TEXT PRIMARY KEY , 
      $columnWorkloads INTEGER , 
      $columnDifficulty INTEGER , 
      $columnStartDate TEXT , 
      $columnEndDate TEXT , 
      $columnExamDate TEXT)
      '''
    );
  }

  // Insert
  Future<int> insertSubject(Subject subject) async{
    final Database db = await instance.database;

    return await db.insert(
      _tableName,
      subject.toMap(),
    );
  }

  // Query
  Future<List<Subject>> queryAll() async{
    final Database db = await instance.database;

    // Query the table for all the subjects
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i){
      return Subject(
        name: maps[i]['SubjectName'],
        workloads: maps[i]['NumberOfWorkloads'],
        difficulty: maps[i]['Difficulty'],
        startDate: maps[i]['startDate'],
        endDate: maps[i]['endDate'],
        examDate: maps[i]['examDate'],

      );
    });
  }

  // Update row
  Future<void> updateSubject(Subject subject) async{
    // get a reference to the database
    final db = await instance.database;

   await db.update(
     _tableName,
   subject.toMap(),
   where: "SubjectName = ?",
   whereArgs: [subject.name],
    );
  }

  // Delete subject
  Future<void> deleteSubject(String name) async{
    // Get a reference to the database
    Database db = await instance.database;

    await db.delete(
      _tableName,
      where: "SubjectName = ?",
      whereArgs: [name],
    );
  }

}