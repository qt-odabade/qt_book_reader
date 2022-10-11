import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qt_book_reader/service/database.dart';
import 'package:qt_book_reader/model/book.dart';

import '../service/encrypter.dart';

class TextView extends StatefulWidget {
  final Book book;

  const TextView({super.key, required this.book});

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  late final ScrollController _scrollController;

  Future<String> loadText() async {
    _scrollController = ScrollController(
      initialScrollOffset: double.tryParse(widget.book.progress ?? '') != null
          ? double.parse(widget.book.progress!)
          : 0,
    );

    if (widget.book.filePath != null) {
      File file = File(widget.book.filePath!);
      String decryptedData = EncryptService.instance
          .decrypt(encryptedBytes: await file.readAsBytes());

      return decryptedData;
    } else {
      final res = await http.get(Uri.parse(widget.book.downloadUrl));
      Database.instance.saveFile(book: widget.book, fileData: res.bodyBytes);
      return res.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.book.progress = _scrollController.offset.toString();
        Database.instance.updateBook(book: widget.book);
        return true;
      },
      child: Scaffold(
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
                  controller: _scrollController,
                  child: Text(snapshot.data ?? ''),
                );
            }
          },
        ),
      ),
    );
  }
}
