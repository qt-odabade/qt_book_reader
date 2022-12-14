import 'package:qt_book_reader/model/book.dart';

class Constants {
  static Future<List<Book>> books() async {
    List<Book> data = [];

    for (int i = 0; i < downloadUrls.length; i++) {
      data.add(Book(
        id: i,
        title: downloadUrls[i].split('/').last,
        downloadUrl: downloadUrls[i],
      ));
    }

    await Future.delayed(const Duration(seconds: 1));

    return data;
  }

  static List<String> downloadUrls = [
    'https://www.africau.edu/images/default/sample.pdf',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/multipage.pdf',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test.epub',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test_2.epub',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/multipage_v2.epub',
    'http://www.daisy.org/samples/epub/valentin-hauy.epub',
    'https://github.com/IDPF/epub3-samples/releases/download/20170606/figure-gallery-bindings.epub',
    'https://github.com/IDPF/epub3-samples/releases/download/20170606/hefty-water.epub',
    'http://files.infogridpacific.com/epub3/don-quijoti-epub3.epub',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test.txt',
    'https://github.com/qt-odabade/qt_book_reader/raw/master/assets/test_2.txt'
  ];
}
