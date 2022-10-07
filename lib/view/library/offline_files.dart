import 'package:flutter/material.dart';
import 'package:qt_book_reader/database/database.dart';

import '../widget/book_card.dart';

class OfflineFiles extends StatefulWidget {
  const OfflineFiles({super.key});

  @override
  State<OfflineFiles> createState() => _OfflineFilesState();
}

class _OfflineFilesState extends State<OfflineFiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: Database.instance.books.length,
        itemBuilder: (context, index) {
          return BookCard(
            book: Database.instance.books[index],
          );
        },
      ),
    );
  }
}
