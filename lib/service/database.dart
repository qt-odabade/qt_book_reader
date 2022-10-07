import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qt_book_reader/model/book.dart';

import '../objectbox.g.dart';

class Database {
  static final Database _database = Database._internal();

  Database._internal();

  static Database get instance => _database;

  late Box<Book> _box;

  Future<void> init() async {
    final store = await openStore();
    _box = store.box<Book>();
  }

  List<Book> get books => _box.getAll();

  //TODO: Avoid duplicacy
  Future<void> saveBook(
      {required Book book, required Uint8List fileData}) async {
    if (books.contains(book)) {
      return;
    }

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

    await _box.putAsync(book);
  }
}
