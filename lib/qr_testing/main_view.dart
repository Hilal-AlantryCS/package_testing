import 'package:flutter/material.dart';
import 'package:package_testing/pdf_testing/generate_pdf/pdf_page.dart';
import 'package:package_testing/qr_testing/bar_reader_view.dart';
import 'package:package_testing/qr_testing/generate_qr_code.dart';
import 'package:package_testing/qr_testing/get_scanned_code.dart';
import 'package:package_testing/video_player_testing/video_player_test.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("QR Code"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsetsDirectional.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              customButton(
                "Scann QR",
                BarReaderView(),
                context,
              ),
              SizedBox(height: 30),
              customButton(
                "Scann Code",
                QRScannerView(),
                context,
              ),
              SizedBox(height: 30),
              customButton(
                "Generate QR",
                GenerateQRCode(),
                context,
              ),
              SizedBox(height: 30),
              customButton(
                "Show Video",
                VideoApp(),
                context,
              ),
              SizedBox(height: 30),
              customButton(
                "Treat With PDF",
                PDFPage(),
                context,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton customButton(String text, Widget wid, BuildContext con) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          con,
          MaterialPageRoute(
            builder: (context) {
              return wid;
            },
          ),
        );
      },
      child: Text(text),
    );
  }
}
