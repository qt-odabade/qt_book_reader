import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qt_book_reader/service/database.dart';
import 'package:qt_book_reader/model/book.dart';

class TextView extends StatefulWidget {
  final Book book;

  const TextView({super.key, required this.book});

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  Future<String> loadText() async {
    if (widget.book.filePath != null) {
      return await File(widget.book.filePath!).readAsString();
    } else {
      final res = await http.get(Uri.parse(widget.book.downloadUrl));
      Database.instance.saveBook(book: widget.book, fileData: res.bodyBytes);
      return res.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: FutureBuilder<String>(
        future: loadText(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.data?.isEmpty ?? true) {
                return const Center(
                  child: Text('No text found'),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(snapshot.data ?? ''),
              );
          }
        },
      ),
    );
  }
}
