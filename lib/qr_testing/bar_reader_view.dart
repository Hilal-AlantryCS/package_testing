import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';

class BarReaderView extends StatefulWidget {
  const BarReaderView({super.key});

  @override
  State<BarReaderView> createState() => _BarReaderViewState();
}

class _BarReaderViewState extends State<BarReaderView> {
  String qrResult = "not yet scanned";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Scann"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsetsDirectional.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Result",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                qrResult,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              ElevatedButton(
                onPressed: () async {
                  var result = await BarcodeScanner.scan();
                  setState(() {
                    qrResult = result.rawContent;
                  });
                  print(result
                      .type); // The result type (barcode, cancelled, failed)
                  print(result.rawContent); // The barcode content
                  print(result.format); // The barcode format (as enum)
                  print(result
                      .formatNote); // If a unknown format was scanned this field contains a note
                },
                child: Text("Scann QR Code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
