import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:v_card/models/contact_model.dart';

class DbHelper {
  final String _createTableContact = '''create table $tableContact(
    $tblContactId integer primary key autoincrement,
    $tblContactName  text,
    $tblContactMobile  text,
    $tblContactLandLine  text,
    $tblContactEmail  text,
    $tblContactAddress  text,
    $tblContactCompany  text,
    $tblContactDesignation  text,
    $tblContactWebsite  text,
    $tblContactImage  text,
    $tblContactFavorite  integer)''';

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = p.join(root, 'contact.db');
    return openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) {
        db.execute(_createTableContact);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion == 1) {
          db.execute(
              'alter table $tableContact add column $tblContactLandLine text default ""');
        }
      },
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
      mapList.length,
      (index) => ContactModel.fromMap(mapList[index]),
    );
  }

  Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db
        .query(tableContact, where: '$tblContactId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }

  Future<int> deleteContact(int id) async {
    final db = await _open();
    return db.delete(tableContact, where: '$tblContactId = ?', whereArgs: [id]);
  }

  Future<int> updateContactField(int id, Map<String, dynamic> map) async {
    final db = await _open();
    return db
        .update(tableContact, map, where: '$tblContactId = ?', whereArgs: [id]);
  }
}
