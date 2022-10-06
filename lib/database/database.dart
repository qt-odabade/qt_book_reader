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

  Future<void> saveBook({required Book book}) async {
    await _box.putAsync(book);
  }
}
