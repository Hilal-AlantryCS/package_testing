//Display Scanned QR Code Data.
import 'package:flutter/material.dart';

class QRCodeDataDisplay extends StatelessWidget {
  QRCodeDataDisplay(this.qrCodeData);
  final String qrCodeData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Scanned QR Code Data:/n$qrCodeData",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
