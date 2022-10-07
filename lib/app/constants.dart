import 'dart:math';

import 'package:qt_book_reader/model/book.dart';

class Constants {
  static List<Book> books = List.generate(11, (index) {
    final link = randomDownloadUrl();

    return Book(
      title: link.split('/').last,
      downloadUrl: link,
    );
  });

  static List<String> pdfDownloadUrls = [
    'https://www.africau.edu/images/default/sample.pdf',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test.pdf',
  ];
  static List<String> ePubDownloadUrls = [
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test.epub',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test_2.epub'
  ];
  static List<String> txtDownloadUrls = [
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test.txt',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test_2.txt'
  ];

  static String randomDownloadUrl() {
    switch (Random().nextInt(3)) {
      case 0:
        return pdfDownloadUrls[Random().nextInt(pdfDownloadUrls.length)];
      case 1:
        return ePubDownloadUrls[Random().nextInt(ePubDownloadUrls.length)];
      case 2:
        return txtDownloadUrls[Random().nextInt(ePubDownloadUrls.length)];
      default:
        return pdfDownloadUrls[Random().nextInt(pdfDownloadUrls.length)];
    }
  }
}
