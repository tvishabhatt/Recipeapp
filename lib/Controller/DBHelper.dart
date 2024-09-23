import 'package:path/path.dart';
import 'package:recipeapp/Model/RecipesModal.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  static Database? _database;

  static final  _instance= DBHelper._privetcon();
  factory DBHelper() => _instance;



   DBHelper._privetcon();
  Future<Database> get database async{
    if(_database !=null){
      return _database!;
    }
    _database= await  initDB();
    return _database!;

  }

  Future<Database> initDB()async{

    String dbpath= await getDatabasesPath();
    String path=join(dbpath,"recipes_database.db");
    return openDatabase(path,version: 1,onCreate: onCreateDatabase);
  }

  Future<void> onCreateDatabase(Database db,int version)async{
     await db.execute(
       ''' CREATE TABLE RECIPES(
       id INTEGER PRIMARY KEY AUTOACREMENT,
       name TEXT
       desciption TEXT,
     )
     ''');

  }

  Future addrecipes(RecipesModal recipesModal)async{
    final db = await database;
    return db.insert("RECIPES",recipesModal.toMap());
  }


  Future<List<Map<String,dynamic>>> getrecipes()async {
    final db = await database;
    final List<Map<String, dynamic>>? finallist = await db.query("RECIPES");

    return List.generate(finallist!.length, (i) {
      return RecipesModal.fromMap(finallist[i]) as Map<String, dynamic>;
    },);
  }


  Future Updaterecipes(RecipesModal recipesModal)async{
    final db = await database;
    db.update('RECIPES', recipesModal.toMap(),where: 'id?=',whereArgs: [recipesModal.id]);
  }

  Future deleterecipes(RecipesModal recipesModal)async{
    final db = await database;
    db.delete('RECIPES',where: 'id?=',whereArgs: [recipesModal.id]);
  }
}
