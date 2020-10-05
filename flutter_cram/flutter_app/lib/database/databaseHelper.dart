import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/subject.dart';
import '../model/workload.dart';


class DatabaseHelper{

  static final _dbName = 'subjectDatabase.db';
  static final _dbVersion = 1;
  static final _subjectTableName = 'subjects';
  static final _workloadTableName = 'workloads';
  static final _daysTableName = 'skipDays';

  // Column names of Subjects table
  static final columnSubjectName= 'SubjectName';
  static final columnWorkloads= 'NumberOfWorkloads';
  static final columnDifficulty ='Difficulty';
  static final columnStartDate = 'startDate';
  static final columnEndDate = 'endDate';
  static final columnExamDate = 'examDate';

  // column names of workloads table
  static final columnWorkloadID= '_workloadID';
  static final columnSubName= 'subject';
  static final columnWorkloadName = 'workloadName';
  static final columnWorkloadNumber ='workloadNumber';
  static final columnWorkloadDate ='workloadDate';
  static final columnWorkloadDifficulty ='workloadDifficulty';
  static final columnCompleted = 'complete';

  // column names of skip dates table

  static final columnDay = '_days';
  static final columnSkip = 'skip';

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
      CREATE TABLE $_subjectTableName(
      $columnSubjectName TEXT PRIMARY KEY , 
      $columnWorkloads INTEGER , 
      $columnDifficulty INTEGER , 
      $columnStartDate TEXT , 
      $columnEndDate TEXT , 
      $columnExamDate TEXT)
      '''
    );

    await db.execute(
        '''
      CREATE TABLE $_workloadTableName(
      $columnWorkloadID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $columnSubName TEXT, 
      $columnWorkloadName TEXT , 
      $columnWorkloadNumber INTEGER ,
      $columnWorkloadDate TEXT ,
      $columnWorkloadDifficulty INTEGER , 
      $columnCompleted INTEGER,
      FOREIGN KEY($columnSubName) REFERENCES $_subjectTableName($columnSubjectName)
      )
      '''
    );

    await db.execute(
        '''
      CREATE TABLE $_daysTableName(
      $columnDay TEXT PRIMARY KEY,
      $columnSkip INTEGER
      )
      '''
    );

    fillDayDatabase(db);

  }

  Future fillDayDatabase(Database db) async{
    await db.insert(_daysTableName, {columnDay : "Monday", columnSkip : 0});
    await db.insert(_daysTableName, {columnDay : "Tuesday", columnSkip : 0});
    await db.insert(_daysTableName, {columnDay : "Wednesday", columnSkip : 0});
    await db.insert(_daysTableName, {columnDay : "Thursday", columnSkip : 0});
    await db.insert(_daysTableName, {columnDay : "Friday", columnSkip : 0});
    await db.insert(_daysTableName, {columnDay : "Saturday", columnSkip : 0});
    await db.insert(_daysTableName, {columnDay : "Sunday", columnSkip : 0});
  }

  // Insert a row into each table

  // Inserting into the subject database
  Future<int> insertSubject(Subject subject) async{
    final Database db = await instance.database;

    return await db.insert(
      _subjectTableName,
      subject.toMap(),
    );
  }

  // Inserting into the workload database
  Future<int> insertWorkload(Workload workload) async{
    final Database db = await instance.database;

    return await db.insert(
      _workloadTableName,
      workload.toMap(),
    );
  }


  // Query tables to return list of table contents
  Future<List<Subject>> queryAllSubjects() async{
    final Database db = await instance.database;

    // Query the table for all the subjects
    final List<Map<String, dynamic>> maps = await db.query(_subjectTableName);

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

  // Query the workloads table for all the workloads
  Future<List<Workload>> queryAllWorkloads() async{
    final Database db = await instance.database;

    // Query the table for all the subjects
    final List<Map<String, dynamic>> maps = await db.query(_workloadTableName);

    return List.generate(maps.length, (i){
      return Workload(
        workloadID: maps[i]['_workloadID'],
        subject: maps[i]['subject'],
        workloadName: maps[i]['workloadName'],
        workloadNumber: maps[i]['workloadNumber'],
        workloadDate: maps[i]['workloadDate'],
        workloadDifficulty: maps[i]['workloadDifficulty'],
        complete: maps[i]['complete'],
      );
    });
  }

  // Query the skip days table for current values
  Future<List> queryAllSkipDays() async{
    final Database db = await instance.database;

    // Query the table for all the values
    final List<Map<String, dynamic>> maps = await db.query(_daysTableName);

    return List.generate(maps.length, (i){
      return maps[i]['skip'];
    });
  }

  // Update row in the subject table
  Future<void> updateSubject(Subject subject) async{
    // get a reference to the database
    final db = await instance.database;

   await db.update(
     _subjectTableName,
   subject.toMap(),
   where: "SubjectName = ?",
   whereArgs: [subject.name],
    );
  }

  // Update row in the workload table
  Future<void> updateWorkload(Workload workload) async{
    // get a reference to the database
    final db = await instance.database;

    await db.update(
      _workloadTableName,
      workload.toMap(),
      where: "_workloadID = ?",
      whereArgs: [workload.workloadID],
    );
  }

  // Update day to skip or not skip
  Future<void> skipDay(String day, int skip) async{
    // get reference to the database
    final db = await instance.database;

    await db.update(
      _daysTableName,
        {columnDay : day, columnSkip : skip},
      where: "$columnDay = ?",
      whereArgs: [day],
    );
  }

  // Delete Item from the database

  // Delete subject form the subject table
  Future<void> deleteSubject(String name) async{
    // Get a reference to the database
    Database db = await instance.database;

    await db.delete(
      _subjectTableName,
      where: "SubjectName = ?",
      whereArgs: [name],
    );
  }

  // Delete workload from the workload table
  Future<void> deleteWorkloadBySubject(String subjectToDelete) async{
    // Get a reference to the database
    Database db = await instance.database;

    await db.delete(
      _workloadTableName,
      where: "subject = ?",
      whereArgs: [subjectToDelete],
    );
  }

  // Check if the subject is in the database already (used before addition of subject to table)
  Future<bool> isDuplicate(String subjectToFind) async{
    // get a reference to the database
    Database db = await instance.database;

    // make a list of any subjects being asked for in the database
    List queryResult = await db.rawQuery('SELECT * FROM $_subjectTableName WHERE $columnSubjectName="$subjectToFind"');
    // Check if query list result is empty. if yes then return false if not then return to true
    bool result = queryResult.isEmpty ? false : true ;
    return result;
  }

  Future<List<Workload>> returnWorkloadsForSubject(String subjectToReturn) async{
    // get a reference to the database
    Database db = await instance.database;

    // make a list of any subjects being asked for in the database
    List queryResult = await db.rawQuery('SELECT * FROM $_workloadTableName WHERE $columnSubName="$subjectToReturn"');

    return List.generate(queryResult.length, (i) {
      return Workload(
        workloadID: queryResult[i]['_workloadID'],
        subject: queryResult[i]['subject'],
        workloadName: queryResult[i]['workloadName'],
        workloadNumber: queryResult[i]['workloadNumber'],
        workloadDate: queryResult[i]['workloadDate'],
        workloadDifficulty: queryResult[i]['workloadDifficulty'],
        complete: queryResult[i]['complete'],
      );
    });
  }

}