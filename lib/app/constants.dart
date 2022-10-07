import 'dart:math';

import 'package:qt_book_reader/model/book.dart';

class Constants {
  static List<Book> books = List.generate(
    11,
    (index) => Book(
      title: 'Book Title $index',
      downloadUrl: randomDownloadUrl(),
    ),
  );

  static List<String> pdfDownloadUrls = [
    'https://www.africau.edu/images/default/sample.pdf'
  ];
  static List<String> ePubDownloadUrls = [
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/book.epub'
  ];

  static String randomDownloadUrl() {
    if (Random().nextBool()) {
      return pdfDownloadUrls[Random().nextInt(pdfDownloadUrls.length)];
    } else {
      return ePubDownloadUrls[Random().nextInt(ePubDownloadUrls.length)];
    }
  }
}
