// // Dart imports:
// import 'dart:typed_data';

// // Flutter imports:
// import 'package:flutter/services.dart';

// // Package imports:
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

// // Project imports:
// import 'package:fiber/_utils/currency_utils.dart';
// import 'package:fiber/data/delivery_data.dart';
// import 'package:fiber/data/inventory_batch_data.dart';
// import 'package:fiber/models/index.dart';

// Future<Uint8List> createDeliveriesPdf(List<Delivery> deliveries) async {
//   DateTime today = DateTime.now();
//   ThemeData googleFiraSansTheme = ThemeData.withFont(
//     base: Font.ttf(
//       await rootBundle.load('assets/google_fonts/FiraSans-Regular.ttf'),
//     ),
//     bold: Font.ttf(
//       await rootBundle.load('assets/google_fonts/FiraSans-Bold.ttf'),
//     ),
//   );
//   final Document pdf = Document(theme: googleFiraSansTheme);
//   final List<String> productHeaderRows = [
//     'S/N',
//     'Product Name',
//     'Qty',
//     'Cost Price',
//     'Selling Price',
//   ];
//   int deliveryCount = deliveries.length;
//   final _deliveryData = DeliveryData();
//   final _inventoryBatchData = InventoryBatchData<Delivery>();
//   List<List<InventoryBatch<Delivery>>> products = [];
//   for (int i = 0; i < deliveryCount; i++) {
//     DocumentReference<Delivery> ref = _deliveryData.reference(deliveries[i].id);
//     products.add([]);

//     List<QueryDocumentSnapshot<InventoryBatch<Delivery>>> inventoryBatchDocs =
//         await _inventoryBatchData.queryDocuments(ref);
//     products[i] = inventoryBatchDocs.map((e) => e.data()).toList();
//   }

//   pdf.addPage(
//     MultiPage(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       header: (Context context) {
//         if (context.pageNumber > 1) return SizedBox();
//         return Container(
//           alignment: Alignment.centerRight,
//           margin: const EdgeInsets.all(3.0 * PdfPageFormat.mm),
//           padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: PdfColors.grey400, width: 0.5),
//             ),
//           ),
//           child: Text(
//             'RESTOCK SUMMARY FOR '
//             '${deliveries[0].supplier!.name!.toUpperCase()}',
//           ),
//         );
//       },
//       footer: (Context context) {
//         return Container(
//           child: Column(
//             children: [
//               if (context.pageNumber == context.pagesCount)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Name: _____________________________________',
//                       textScaleFactor: 1,
//                     ),
//                     Text(
//                       'Sign: _____________________',
//                       textScaleFactor: 1,
//                     ),
//                   ],
//                 ),
//               if (context.pageNumber == context.pagesCount)
//                 SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Generated on ${today.toString().substring(0, 19)}.'),
//                   Text('Page ${context.pageNumber} of ${context.pagesCount}'),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//       build: (Context context) {
//         String name = deliveries[0].supplier!.name!.toUpperCase();
//         return <Widget>[
//           Header(
//             level: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'RESTOCK SUMMARY FOR $name',
//                   textScaleFactor: 1.5,
//                 ),
//                 if (deliveries[0].supplier!.phoneNo != null &&
//                     deliveries[0].supplier!.email!.isNotEmpty)
//                   Text(
//                     'Email: ${deliveries[0].supplier!.email}',
//                     textScaleFactor: 1.5,
//                   ),
//                 if (deliveries[0].supplier!.phoneNo != null &&
//                     deliveries[0].supplier!.phoneNo!.isNotEmpty)
//                   Text(
//                     'Phone Number: ${deliveries[0].supplier!.phoneNo}',
//                     textScaleFactor: 1.5,
//                   ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           for (int j = 0; j < deliveryCount; j++)
//             Table.fromTextArray(
//               headerDecoration: const BoxDecoration(color: PdfColors.grey400),
//               oddRowDecoration: const BoxDecoration(color: PdfColors.grey200),
//               cellPadding: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 5,
//               ),
//               context: context,
//               cellAlignments: {
//                 0: Alignment.centerLeft,
//                 1: Alignment.centerLeft,
//                 2: Alignment.centerRight,
//                 3: Alignment.centerRight,
//                 4: Alignment.centerRight,
//               },
//               border: TableBorder.symmetric(
//                 inside: const BorderSide(color: PdfColors.black, width: 0.5),
//               ),
//               headers: productHeaderRows,
//               data: [
//                 for (int k = 0; k < products[j].length; k++)
//                   <String>[
//                     '${k + 1}',
//                     products[j][k].name ?? '',
//                     '${products[j][k].quantity}',
//                     CurrencyUtils.addCurrency(products[j][k].costPrice),
//                     CurrencyUtils.addCurrency(products[j][k].sellingPrice),
//                   ],
//                 [
//                   '',
//                   'Total Cost',
//                   '',
//                   '',
//                   CurrencyUtils.addCurrency(deliveries[j].totalCost)
//                 ],
//                 [
//                   '',
//                   'Total Cost',
//                   '',
//                   '',
//                   CurrencyUtils.addCurrency(deliveries[j].totalCost)
//                 ],
//                 ['', 'Discount', '', '', deliveries[j].discount.toString()],
//                 [
//                   '',
//                   'Total Paid',
//                   '',
//                   '',
//                   CurrencyUtils.addCurrency(deliveries[j].totalPaid),
//                 ],
//                 [
//                   '',
//                   'Balance',
//                   '',
//                   '',
//                   CurrencyUtils.addCurrency(deliveries[j].balance),
//                 ],
//                 ['', 'Staff', '', '', '${deliveries[j].staff}'],
//                 [
//                   '',
//                   'Sales Date',
//                   '',
//                   '',
//                   deliveries[j].dateAdded.toString().substring(0, 19),
//                 ],
//               ],
//             ),
//         ];
//       },
//     ),
//   );

//   return pdf.save();
// }
