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
// import 'package:fiber/data/inventory_batch_data.dart';
// import 'package:fiber/data/sale_data.dart';
// import 'package:fiber/models/index.dart';

// Future<Uint8List> createSalesPdf(List<Sale> sales) async {
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
//     'Cost',
//   ];
//   int saleCount = sales.length;
//   final _saleData = SaleData();
//   final _inventoryBatchData = InventoryBatchData<Sale>();
//   List<List<InventoryBatch<Sale>>> products = [];
//   for (int i = 0; i < saleCount; i++) {
//     DocumentReference<Sale> ref = _saleData.reference(sales[i].id);
//     products.add([]);

//     List<QueryDocumentSnapshot<InventoryBatch<Sale>>> inventoryBatchDocs =
//         await _inventoryBatchData.queryDocuments(ref);
//     products[i] = inventoryBatchDocs.map((e) => e.data()).toList();
//   }

//   pdf.addPage(
//     MultiPage(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       header: (Context context) {
//         if (context.pageNumber == 1) return SizedBox();
//         return Container(
//           alignment: Alignment.centerRight,
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: PdfColors.grey400, width: 0.5),
//             ),
//           ),
//           child: Text(
//             'PURCHASE SUMMARY FOR ${sales[0].client!.name!.toUpperCase()}',
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
//         return <Widget>[
//           Header(
//             level: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'PURCHASE SUMMARY FOR '
//                   '${sales[0].client!.name!.toUpperCase()}',
//                   textScaleFactor: 1.5,
//                 ),
//                 if (sales[0].client!.email != null &&
//                     sales[0].client!.email!.isNotEmpty)
//                   Text(
//                     'Email: ${sales[0].client!.email}',
//                     textScaleFactor: 1.5,
//                   ),
//                 if (sales[0].client!.phoneNo != null &&
//                     sales[0].client!.phoneNo!.isNotEmpty)
//                   Text(
//                     'Phone Number: ${sales[0].client!.phoneNo}',
//                     textScaleFactor: 1.5,
//                   ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           for (int j = 0; j < saleCount; j++)
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
//                 2: Alignment.center,
//                 3: Alignment.centerRight,
//               },
//               border: TableBorder.symmetric(
//                 inside: const BorderSide(color: PdfColors.black, width: 0.5),
//               ),
//               headers: productHeaderRows,
//               data: [
//                 for (int k = 0; k < products[j].length; k++)
//                   <String?>[
//                     '${k + 1}',
//                     products[j][k].name,
//                     '${products[j][k].quantity}',
//                     CurrencyUtils.addCurrency(products[j][k].quantity! *
//                         products[j][k].sellingPrice!),
//                   ],
//                 [
//                   '',
//                   'Total Cost',
//                   '',
//                   CurrencyUtils.addCurrency(sales[j].totalCost)
//                 ],
//                 ['', 'Discount', '', sales[j].discount.toString()],
//                 [
//                   '',
//                   'Total Paid',
//                   '',
//                   CurrencyUtils.addCurrency(sales[j].amountPaid)
//                 ],
//                 [
//                   '',
//                   'Balance',
//                   '',
//                   CurrencyUtils.addCurrency(sales[j].balance)
//                 ],
//                 ['', 'Staff', '', '${sales[j].staff}'],
//                 [
//                   '',
//                   'Sales Date',
//                   '',
//                   sales[j].dateAdded.toString().substring(0, 19),
//                 ],
//               ],
//             ),
//         ];
//       },
//     ),
//   );

//   return pdf.save();
// }
