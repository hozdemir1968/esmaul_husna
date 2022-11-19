import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../models/esma_model.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, 'esma.db');
    bool dbExists = await io.File(path).exists();
    if (!dbExists) {
      ByteData data = await rootBundle.load(p.join('assets', 'res/esma.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  Future<List<EsmaModel>> getEsmas() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM Esma');
    List<EsmaModel> esmas = [];
    for (int i = 0; i < list.length; i++) {
      esmas.add(EsmaModel(
        list[i]['id'],
        list[i]['isim'],
        list[i]['detay'],
        list[i]['isimeng'],
        list[i]['detayeng'],
        list[i]['resim'],
      ));
    }
    return esmas;
  }
}
