import 'package:firebase_auth_platform_interface/src/auth_credential.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper _db = DbHelper._();

  factory DbHelper() => _db;
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      print('database exist');
      return _database!;
    } else {
      print('database init');
      return await init();
    }
  }

  Future<Database?> init() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'copick.db');
    _database = await openDatabase(path, onCreate: _onCreate, version: 1);

    return _database;
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute('CREATE TABLE gathering_place (place_id INTEGER  PRIMARY KEY AUTOINCREMENT, place_doc_id STRING, location_code STRING, place_name STRING, type INT, gps_lat DOUBLE, gps_long DOUBLE)');
    db.execute(
        'CREATE TABLE pick_task (pick_id INTEGER  PRIMARY KEY AUTOINCREMENT,pick_doc_id String ,location_id VARCHAR REFERENCES waste_location (location_id) ON DELETE CASCADE ON UPDATE CASCADE,fail_reason STRING,pick_details STRING,pick_total_waste DOUBLE,pick_order INT, track INT, condition INT, team STRING, pick_up_date STRING);');
    db.execute(
        'CREATE TABLE waste_location (location_id VARCHAR PRIMARY KEY UNIQUE, location_name STRING,location_address STRING,location_gps_lat DOUBLE,location_gps_long DOUBLE,location_postal STRING,location_tel VARCHAR,last_call_date STRING,location_doc_id VARCHAR);');
    db.execute(
        'CREATE TABLE user (user_id VARCHAR PRIMARY KEY UNIQUE, user_pw VARCHAR, user_name STRING, user_phone STRING); ');
    db.execute(
        'CREATE TABLE open_app(open_id INTEGER PRIMARY KEY AUTOINCREMENT, open_date STRING);');
    print('database onCreated with $version');
  }

  Future<void> deleteDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'copick.db');
    print('222');
    if (await databaseExists(path)) {
      print('1111');
      await deleteDatabase(path).then((value) => print('dbDeleted'));
    } else {
      print('no Database');
    }
  }

  Future<Map<String, Object?>?> findloginInfo() async {
    List<Map<String, Object?>> userInfo =
        await _database!.rawQuery('select * from user');
    print('userInfo : $userInfo');
    if (userInfo.isEmpty) {
      return null;
    } else {
      return userInfo[0];
    }
  }

  Future<bool> firstOpenCheck() async {
    final db = await database;
    var firstOpen = await db!.rawQuery('select * from open_app');
    print('db_helper : $firstOpen');
    if (firstOpen.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> saveOpenApp() async {
    final db = await database;
    db!.insert('open_app', {"open_date": DateTime.now().toString()});
  }

  Future<void> insertLoginInfo(String email, String password) async {
    final db = await database;
    var user = await _database!.rawQuery('select * from user');
    if (user.isNotEmpty) {
      deleteUser().then((value) {
        db!.insert('user', {
          'user_id': email,
          'user_pw': password,
        });
      });
    } else {
      db!.insert('user', {
        'user_id': email,
        'user_pw': password,
      });
    }
  }

  Future<void> deleteUser() async {
    final db = await database;
    db!.rawQuery('DELETE FROM user');
  }

  Future<void> getUserInfo() async {
    final db = await database;
  }
}
