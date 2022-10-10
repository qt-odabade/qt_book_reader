import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qt_book_reader/model/book.dart';

class Database {
  static final Database _database = Database._internal();

  Database._internal();

  static Database get instance => _database;

  late Box<Book> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Book>(BookAdapter());

    _box = await Hive.openBox<Book>('book-store');
  }

  List<Book> get books => _box.values.toList();

  Future<void> saveBook(
      {required Book book, required Uint8List fileData}) async {
    final docsPath = await getApplicationDocumentsDirectory();

    Directory filesDirectory = Directory("${docsPath.path}/Files");
    if (!(await filesDirectory.exists())) {
      filesDirectory = await filesDirectory.create(recursive: true);
    }

    File file =
        File("${filesDirectory.path}/${book.title}.${book.fileExtension}");

    if (!(await file.exists())) {
      file = await file.writeAsBytes(fileData);
    }

    book.filePath = file.path;

    await _box.put(book.id, book);
  }

  Future<void> updateBook({required Book book}) async {
    await _box.put(book.id, book);
  }
}
