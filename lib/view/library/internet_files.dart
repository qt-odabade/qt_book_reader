import 'package:flutter/material.dart';

import '../../app/constants.dart';
import '../../model/book.dart';
import '../widget/book_card.dart';

class InternetFiles extends StatefulWidget {
  const InternetFiles({super.key});

  @override
  State<InternetFiles> createState() => _InternetFilesState();
}

class _InternetFilesState extends State<InternetFiles> {
  List<Book>? initBooks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: FutureBuilder<List<Book>>(
        future: Constants.books(),
        initialData: initBooks,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.data?.isEmpty ?? true) {
                return const Center(
                  child: Text('No books found'),
                );
              }

              initBooks = snapshot.data;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return BookCard(
                    book: snapshot.data![index],
                  );
                },
              );
          }
        },
      ),
    );
  }
}
