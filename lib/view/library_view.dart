import 'package:flutter/material.dart';
import 'package:qt_book_reader/app/constants.dart';
import 'package:qt_book_reader/view/widget/book_card.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: Constants.books.length,
        itemBuilder: (context, index) {
          return BookCard(
            book: Constants.books[index],
          );
        },
      ),
    );
  }
}
