import 'package:qt_book_reader/model/book.dart';

class Constants {
  static List<Book> books = List.generate(
    11,
    (index) =>
        Book(title: 'Book Title $index', downloadUrl: 'Download Url $index'),
  );
}
