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
// import 'package:fiber/data/shrinkage_data.dart';
// import 'package:fiber/models/index.dart';

// Future<Uint8List> createShrinkagesPdf(List<Shrinkage> shrinkages) async {
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
//   ];
//   int shrinkageCount = shrinkages.length;
//   final _shrinkageData = ShrinkageData();
//   final _inventoryBatchData = InventoryBatchData<Shrinkage>();
//   List<List<InventoryBatch<Shrinkage>>> products = [];
//   for (int i = 0; i < shrinkageCount; i++) {
//     DocumentReference<Shrinkage> ref =
//         _shrinkageData.reference(shrinkages[i].id);
//     products.add([]);

//     List<QueryDocumentSnapshot<InventoryBatch<Shrinkage>>> inventoryBatchDocs =
//         await _inventoryBatchData.queryDocuments(ref);
//     products[i] = inventoryBatchDocs.map((e) => e.data()).toList();
//   }

//   pdf.addPage(
//     MultiPage(
//       theme: googleFiraSansTheme,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       header: (Context context) {
//         if (context.pageNumber > 1) return SizedBox();
//         return Container(
//           alignment: Alignment.centerRight,
//           decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: PdfColors.grey, width: 0.5),
//             ),
//           ),
//           child: Text('LOSSES SUMMARY'),
//         );
//       },
//       footer: (Context context) {
//         DateTime today = DateTime.now();
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
//                   'LOSSES SUMMARY',
//                   textScaleFactor: 1.5,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           for (int j = 0; j < shrinkageCount; j++)
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
//                     CurrencyUtils.addCurrency(products[j][k].costPrice),
//                   ],
//                 [
//                   '',
//                   'Total Cost',
//                   '',
//                   CurrencyUtils.addCurrency(shrinkages[j].totalCost)
//                 ],
//                 ['', 'Category', '', (shrinkages[j].category)],
//                 ['', 'Staff', '', '${shrinkages[j].staff}'],
//                 [
//                   '',
//                   'Date Added',
//                   '',
//                   shrinkages[j].dateAdded.toString().substring(0, 19),
//                 ],
//               ],
//             ),
//         ];
//       },
//     ),
//   );

//   return pdf.save();
// }
