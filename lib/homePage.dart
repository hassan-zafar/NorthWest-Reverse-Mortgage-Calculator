import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:northwest_reverse_mortgage/Models/model.dart';
import 'package:northwest_reverse_mortgage/adminPanel.dart';
import 'package:northwest_reverse_mortgage/constants.dart';
import 'package:northwest_reverse_mortgage/refinancePage.dart';
import 'PurchasePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';

  bool firstScreenDialogShow = false;

final firebaseInstance = FirebaseDatabase.instance.reference();
String age1 = "62";
String age2 = "62";
TextEditingController homeValueController = TextEditingController(
    // thousandSeparator: ",", precision: 0, decimalSeparator: '.'
    );
bool isChecked = true;
// bool showRegionDialog = true;
bool lastScreenDialogShow = false;
final storedValues = GetStorage();
int currentYear = DateTime.now().year;
String lendingLimitStored;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  List<TableValues> allTableValues = [];
  int pageIndex = 0;
  bool btnClicked = false;
  bool isLoading = false;
  // TextEditingController interestRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getLendingLimitAndStoredValues();
    //print(lendingLimitStored);
  }

  getLendingLimitAndStoredValues() async {
    if (storedValues.read("lendingLimit") == null) {
      setState(() {
        isLoading = true;
      });
    }
    await firebaseInstance.child("lendingLimit").once().then((value) {
      String lndLmt = value.value["lendingLimit"];
      String year = value.value["year"];
      storedValues.writeIfNull("lendingLimit", lndLmt);
      print(lndLmt);
      print(year);
      if (DateTime.now().year == int.parse(year)) {
        storedValues.write("lendingLimit", lndLmt);
      }
      setState(() {
        lendingLimitStored = storedValues.read("lendingLimit");

        storedValues.writeIfNull("lastScreenDialogShow", false);
        storedValues.writeIfNull("firstScreenDialogShow", false);
        firstScreenDialogShow = storedValues.read("firstScreenDialogShow");
        print("firstScreenDialogShow $firstScreenDialogShow");
        lastScreenDialogShow = storedValues.read("lastScreenDialogShow");
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
      // duration: Duration(milliseconds: 350),
      // curve: Curves.easeInOut,
    );
  }

  // enterInterestRateDialog() async {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) => GlassContainer(
  //             child: SimpleDialog(
  //               // backgroundColor: Colors.transparent.withOpacity(-0.5),
  //               title: Row(
  //                 // mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(Icons.insert_chart_outlined_rounded),
  //                   SizedBox(
  //                     width: 5,
  //                   ),
  //                   new Text("Set Interest Rate"),
  //                 ],
  //               ),
  //               contentPadding: EdgeInsets.all(8),
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: TextField(
  //                     controller: interestRateController,
  //                     keyboardType: TextInputType.number,
  //                     decoration: InputDecoration(
  //                       labelText: "Enter Interest Rate",
  //                       hintText: "Select according to HECM values",
  //                     ),
  //                   ),
  //                 ),
  //                 RaisedButton(
  //                   color: Colors.white,
  //                   child: Text("Submit"),
  //                   onPressed: () {
  //                     if (double.parse(interestRateController.text) % 0.125 !=
  //                             0 &&
  //                         double.parse(interestRateController.text) >= 3 &&
  //                         double.parse(interestRateController.text) <= 19) {
  //                       Toast.show("Please Enter Valid interest Rate", context,
  //                           duration: 2, gravity: Toast.CENTER);
  //                       setState(() {
  //                         interestRateController.text = "";
  //                       });
  //                     } else {
  //                       firebaseInstance.child("interestValue").set({
  //                         "interest": interestRateController.text
  //                       }).whenComplete(() {
  //                         Toast.show("Value successfully updated", context,
  //                             duration: 2, gravity: Toast.CENTER);
  //                         Navigator.pop(context);
  //                       });
  //                     }
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundImageBoxDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? CircularProgressIndicator()
              : PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    RefinancePage(),
                    PurchasePage(),
                    // AdminPanel(),
                  ],
                ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.black,
          //   tooltip: "Set Interest Rate",
          //   onPressed: enterInterestRateDialog,
          //   child: Icon(Icons.insert_chart_outlined_rounded),
          // ),
          bottomNavigationBar: CurvedNavigationBar(
            index: pageIndex,
            buttonBackgroundColor: Colors.black,
            height: 45,
            color: Colors.black,
            backgroundColor: Colors.transparent,
            items: [
              FaIcon(
                FontAwesomeIcons.balanceScaleLeft,
                size: 25,
                color: Colors.white,
              ),
              Icon(
                Icons.monetization_on_outlined,
                size: 25,
                color: Colors.white,
              ),
              // Icon(
              //   Icons.insert_chart_outlined_rounded,
              //   size: 25,
              //   color: Colors.white,
              // ),
            ],
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
