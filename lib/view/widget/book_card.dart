import 'package:flutter/material.dart';
import 'package:qt_book_reader/model/book.dart';
import 'package:qt_book_reader/view/e_pub_view.dart';
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
            MaterialPageRoute(
              builder: (context) =>
                  book.isPDF ? PDFView(book: book) : EPubView(book: book),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: book.isPDF
                    ? Icon(
                        Icons.picture_as_pdf_rounded,
                        color: Colors.red.shade400,
                        size: 48.0,
                      )
                    : const Icon(
                        Icons.text_snippet_rounded,
                        size: 48.0,
                      ),
              ),
              Text(book.title),
            ],
          ),
        ),
      ),
    );
  }
}
