import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserCacheDatabase{
  Database? dbInstance;
  int version = 1;
  String dbName = 'CarSharingDatabase.db';

  Future<String> getCacheDatabasePath() async{
    String basePath = await getDatabasesPath();
    String wholePath = join(basePath, dbName);
    return wholePath;
  }

  Future<Database> initializeCacheDatabase() async{
    String dbPath = await getCacheDatabasePath();
    Database db = await openDatabase(
      dbPath,
      version: version,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS 'Users' (
            'ID' TEXT NOT NULL PRIMARY KEY,
            'Username' TEXT NOT NULL,
            'Email' TEXT NOT NULL,
            'PhoneNumber' TEXT NOT NULL,
            'Role' TEXT NOT NULL
          )
        ''');
      },
    );
    return db;
  }

  Future<Database> getCacheDatabase() async{
    if(dbInstance == null){
      dbInstance = await initializeCacheDatabase();
    }
    return dbInstance!;
  }

  void deleteCacheDatabase() async{
    String dbPath = await getCacheDatabasePath();
    await deleteDatabase(dbPath);
  }

  addUser(String userId, String username, String email, String phoneNumber, String role) async{
    Database db = await getCacheDatabase();
    return db.rawInsert('''
      INSERT INTO 'Users' ('ID', 'Username', 'Email', 'PhoneNumber', 'Role')
      VALUES ("$userId", "$username", "$email", "$phoneNumber", "$role")  
    ''');
  }

  Future<List<Map>> getUser(String userId) async{
    Database db = await getCacheDatabase();
    return db.rawQuery('''
      SELECT * FROM 'Users' WHERE ID="$userId"
    ''');
  }

  // updateData(sql) async{
  //   Database db = await getCacheDatabase();
  //   return db.rawUpdate(sql);
  // }
  //
  // deleteData(sql) async{
  //   Database db = await getCacheDatabase();
  //   return db.rawDelete(sql);
  // }
}