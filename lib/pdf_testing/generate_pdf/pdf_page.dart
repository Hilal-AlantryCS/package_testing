// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:package_testing/pdf_testing/generate_pdf/info/invoice.dart';
import 'package:package_testing/pdf_testing/generate_pdf/pdf_api.dart';
import 'package:package_testing/pdf_testing/generate_pdf/pdf_invoice_api.dart';

class PDFPage extends StatefulWidget {
  const PDFPage({super.key});

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PDF Generate"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final date = DateTime.now();
              final dueDate = date.add(Duration(days: 7));

              final Invoice invoice = Invoice(
                supplier: Supplier(
                  name: "name",
                  address: "address",
                  paymentInfo: "paymentInfo",
                ),
                customer: Customer(
                  name: "name",
                  address: "address",
                ),
                info: InvoiceInfo(
                  date: date,
                  dueDate: dueDate,
                  description: "description",
                  number: "${DateTime.now().year}-9999",
                ),
                items: [
                  InvoiceItem(
                    description: "Coffee",
                    date: date,
                    quantity: 3,
                    vat: 0.19,
                    unitPrice: 5.99,
                  ),
                  InvoiceItem(
                    description: "Water",
                    date: date,
                    quantity: 8,
                    vat: 0.19,
                    unitPrice: 0.99,
                  ),
                  InvoiceItem(
                    description: "Orange",
                    date: date,
                    quantity: 4,
                    vat: 0.19,
                    unitPrice: 3.99,
                  ),
                  InvoiceItem(
                    description: "Lemon",
                    date: date,
                    quantity: 6,
                    vat: 0.19,
                    unitPrice: 7.99,
                  ),
                ],
              );
              final pdfFile = await PdfInvoiceApi.generate(invoice);
              PdfApi.openFile(pdfFile);
            },
            child: Text("Generate PDF"),
          ),
        ),
      ),
    );
  }
}
