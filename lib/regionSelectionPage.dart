// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:glassmorphism_ui/glassmorphism_ui.dart';
// import 'package:northwest_reverse_mortgage/homePage.dart';

// import 'constants.dart';

// class RegionSelectionPage extends StatefulWidget {
//   @override
//   _RegionSelectionPageState createState() => _RegionSelectionPageState();
// }

// class _RegionSelectionPageState extends State<RegionSelectionPage> {
//   String stateName;
//   final FixedExtentScrollController scrollController =
//       FixedExtentScrollController(initialItem: 0);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         decoration: backgroundImageBoxDecoration(),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   logoWidget(),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 50, right: 50, top: 12, bottom: 12),
//                     child: GlassContainer(
//                       opacity: containerOpacity,
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Choose Your State:",
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                           Container(
//                             height: 100,
//                             child: CupertinoPicker(
//                               onSelectedItemChanged: (int value) {
//                                 print(value);
//                                 // if (value == 1) {
//                                 //   stateName = "Oregon";
//                                 //   setState(() {
//                                 //     showRegionDialog = true;
//                                 //   });
//                                 // } else if (value == 2) {
//                                 //   stateName = "Washington";
//                                 //   setState(() {
//                                 //     showRegionDialog = true;
//                                 //   });
//                                 // } else if (value == 3) {
//                                 //   stateName = "Idaho";
//                                 //   setState(() {
//                                 //     showRegionDialog = true;
//                                 //   });
//                                 // }
//                                 // print(stateName);
//                               },
//                               itemExtent: 30,
//                               scrollController: scrollController,
//                               children: statesNamesList,
//                               useMagnifier: true,
//                               magnification: 1.3,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               print(stateName);
//                               return firstScreenDialogShow
//                                   ? Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => HomePage()),
//                                     )
//                                   : showRegionDialog
//                                       ? showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return StatefulBuilder(
//                                                 builder: (context, setState) {
//                                               return SimpleDialog(
//                                                 title: Center(
//                                                     child: Text("Disclaimer")),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15.0)),
//                                                 //backgroundColor: Colors.black,
//                                                 elevation: 20.0,
//                                                 titlePadding:
//                                                     EdgeInsets.all(10.0),
//                                                 contentPadding:
//                                                     EdgeInsets.all(10.0),
//                                                 children: [
//                                                   Text(
//                                                       "Northwest Reverse Mortgage, LLC. ML- 5797/ CL-1834787/MBL-2081834787. Equal Opportunity Mortgage Broker licensed in Oregon, Washington, and Idaho. Credit on approval. Terms subject to change without notice. Not a commitment to lend. Contents not provided by, or approved by FHA, HUD, or any other government agency. All potential tax benefits should be verified with a professionally licensed tax advisor.At the conclusion of a reverse mortgage, the borrower must repay the loan and may have to sell the home or repay the loan from other proceeds; charges will be assessed with the loan, including an origination fee, closing costs, mortgage insurance premiums and servicing fees; the loan balance grows over time and interest is charged on the outstanding balance; the borrower remains responsible for property taxes, hazard insurance and home maintenance, and failure to pay these amounts may result in the loss of the home; interest on a reverse mortgage is not tax deductible until the borrower makes partial or full re-payment."),
//                                                   Row(
//                                                     children: [
//                                                       Checkbox(
//                                                         onChanged: (bool val) {
//                                                           print(val);
//                                                           setState(() {
//                                                             storedValues.write(
//                                                                 "firstScreenDialogShow",
//                                                                 val);
//                                                             firstScreenDialogShow =
//                                                                 storedValues.read(
//                                                                     "firstScreenDialogShow");
//                                                             print(
//                                                                 firstScreenDialogShow);
//                                                           });
//                                                         },
//                                                         checkColor:
//                                                             Colors.white,
//                                                         activeColor:
//                                                             Colors.black,
//                                                         value:
//                                                             firstScreenDialogShow,
//                                                       ),
//                                                       Text(
//                                                           "Do not show this again."),
//                                                     ],
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       Navigator.pushReplacement(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder:
//                                                                 (context) =>
//                                                                     HomePage()),
//                                                       );
//                                                     },
//                                                     child: Container(
//                                                         decoration: BoxDecoration(
//                                                             color: Colors.green,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         12),
//                                                             shape: BoxShape
//                                                                 .rectangle),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(12.0),
//                                                           child: Center(
//                                                               child: Text(
//                                                                   "Continue")),
//                                                         )),
//                                                   )
//                                                 ],
//                                               );
//                                             });
//                                           })
//                                       : Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => HomePage()),
//                                         );
//                             },
//                             child: GlassContainer(
//                                 shadowStrength: 6,
//                                 blur: 8,
//                                 opacity: containerOpacity,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 22.0,
//                                       right: 22.0,
//                                       top: 12,
//                                       bottom: 12),
//                                   child: Text(
//                                     "Continue",
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                 )),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
