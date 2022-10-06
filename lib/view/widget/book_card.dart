import 'package:flutter/material.dart';
import 'package:qt_book_reader/model/book.dart';
import 'package:qt_book_reader/view/pdf_view.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PDFView(book: book)),
          );
        },
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(child: FlutterLogo()),
            Text(book.title),
          ],
        ),
      ),
    );
  }
}
