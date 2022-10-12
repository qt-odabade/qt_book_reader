import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class WidgetDocView extends StatefulWidget {
  const WidgetDocView({super.key});

  @override
  State<WidgetDocView> createState() => _WidgetDocViewState();
}

class _WidgetDocViewState extends State<WidgetDocView> {
  String _version = 'Unknown';
  String _document =
      'https://github.com/qt-odabade/qt_book_reader/raw/docx-support/assets/test.doc';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so initialize in an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so use a try/catch PlatformException.
    try {
      // Initializes the PDFTron SDK, it must be called before you can use
      // any functionality.
      PdftronFlutter.initialize("your_pdftron_license_key");

      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, you want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    return Scaffold(
      body: SafeArea(
        child: DocumentView(
          onCreated: (DocumentViewController controller) async {
            Config config = Config();
            config.readOnly = true;

            var leadingNavCancel = startLeadingNavButtonPressedListener(() {
              // Show a dialog when leading navigation button is pressed.
              _showMyDialog();
            });

            await controller.openDocument(_document, config: config);
          },
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog'),
          content: const Text('Leading navigation button has been pressed.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
