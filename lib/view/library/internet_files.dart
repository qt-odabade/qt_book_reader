import 'package:flutter/material.dart';

import '../../app/constants.dart';
import '../widget/book_card.dart';

class InternetFiles extends StatefulWidget {
  const InternetFiles({super.key});

  @override
  State<InternetFiles> createState() => _InternetFilesState();
}

class _InternetFilesState extends State<InternetFiles> {
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
