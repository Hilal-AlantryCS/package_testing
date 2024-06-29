// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:io';

import 'package:package_testing/pdf_testing/generate_pdf/info/invoice.dart';
import 'package:package_testing/pdf_testing/generate_pdf/pdf_api.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildTitle(invoice),
          buildInvoice(invoice),
          pw.Divider(),
          buildTotal(invoice),
        ],
        footer: (context) => buildFooter(invoice),
      ),
    );

    return PdfApi.saveDocument(name: "invoice.pdf", pdf: pdf);
  }

  static pw.Widget buildTitle(Invoice invoice) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "INVOICE",
          style: pw.TextStyle(
            // font: ttf,
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        pw.Text(invoice.info.description),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      ],
    );
  }

  static pw.Widget buildInvoice(Invoice invoice) {
    // final font = await rootBundle.load("assets/fonts/Raleway-Regular.ttf");
    // final ttf = Font.ttf(font);

    final headers = [
      'Description',
      'Date',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total',
    ];

    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.description,
        "${item.date.year}/${item.date.month}/${item.date.day}",
        "${item.quantity}",
        "\$ ${item.unitPrice}",
        "${item.vat} %",
        "\$ ${total.toStringAsFixed(2)}",
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(
        // font: ttf,
        fontWeight: pw.FontWeight.bold,
      ),
      headerDecoration: pw.BoxDecoration(
        color: PdfColors.grey300,
      ),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: "Net total",
                  value: netTotal.toString(),
                  unite: true,
                ),
                buildText(
                  title: "Vat ${vatPercent * 100} %",
                  value: vat.toString(),
                  unite: true,
                ),
                pw.Divider(),
                buildText(
                  title: "Total amount due",
                  titleStyle: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  value: total.toString(),
                  unite: true,
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              title,
              style: style,
            ),
          ),
          pw.Text(
            value,
            style: unite ? style : null,
          ),
        ],
      ),
    );
  }

  static pw.Widget buildFooter(Invoice invoice) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Divider(),
        pw.SizedBox(height: 2 * PdfPageFormat.mm),
        buildSimpleText(
          title: "Address",
          value: invoice.supplier.address,
        ),
        pw.SizedBox(height: 1 * PdfPageFormat.mm),
        buildSimpleText(
          title: "Paypal",
          value: invoice.supplier.paymentInfo,
        ),
      ],
    );
  }

  static pw.Widget buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold);
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          title,
          style: style,
        ),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(value),
      ],
    );
  }
}
