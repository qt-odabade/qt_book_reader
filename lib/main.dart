import 'package:flutter/material.dart';
import 'package:qt_book_reader/view/library_view.dart';

void main() {
  runApp(const BookReader());
}

class BookReader extends StatelessWidget {
  const BookReader({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book Reader',
      home: LibraryView(),
    );
  }
}
