class Invoice {
  final Supplier supplier;
  final Customer customer;
  final InvoiceInfo info;
  final List<InvoiceItem> items;

  Invoice({
    required this.supplier,
    required this.customer,
    required this.info,
    required this.items,
  });
}

class Supplier {
  final String name;
  final String address;
  final String paymentInfo;

  Supplier({
    required this.name,
    required this.address,
    required this.paymentInfo,
  });
}

class Customer {
  final String name;
  final String address;

  Customer({
    required this.name,
    required this.address,
  });
}

class InvoiceInfo {
  final DateTime date;
  final DateTime dueDate;
  final String description;
  final String number;

  InvoiceInfo({
    required this.date,
    required this.dueDate,
    required this.description,
    required this.number,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;

  InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
