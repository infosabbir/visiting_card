import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:v_card/models/contact_model.dart';

class DbHelper {
  final String _createTableContact = '''create table $tableContact(
    $tblContactId integer primary key autoincrement,
    $tblContactName  text,
    $tblContactMobile  text,
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
      version: 1,
      onCreate: (db, version) {
        db.execute(_createTableContact);
      },
    );
  }

  Future<int> insertContact(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContact() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
        mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }
}
