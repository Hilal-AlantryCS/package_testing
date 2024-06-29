//Basic QR Code Scanner Widget:
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerWidget extends StatefulWidget {
  const QRCodeScannerWidget({super.key});

  @override
  State<QRCodeScannerWidget> createState() => _QRCodeScannerWidgetState();
}

class _QRCodeScannerWidgetState extends State<QRCodeScannerWidget> {
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      //Handle the scanned QR code data.
      print("Scanned Data: ${scanData.code}");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
