// ignore_for_file: must_be_immutable

//Customized QR Code Scanner UI:
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CustomQRScannerUI extends StatelessWidget {
  CustomQRScannerUI({super.key});
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 30,
          cutOutSize: 300,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      //Handle the scanned QR code data.
      print("Scanned Data: ${scanData.code}");
    });
  }
}
