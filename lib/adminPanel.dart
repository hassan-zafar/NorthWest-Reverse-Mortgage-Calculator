import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:toast/toast.dart';
import 'homePage.dart';
import 'constants.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

var year;

class _AdminPanelState extends State<AdminPanel> {
  TextEditingController interestRateController = TextEditingController();
  TextEditingController lendingLimitController = TextEditingController();
  final FixedExtentScrollController scrollController3 =
      FixedExtentScrollController(initialItem: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: containerOpacity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'logo.png',
                        height: 80,
                      ),
                      Text(
                        "NORTHWEST REVERSE MORTGAGE",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              "Admin Panel",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GlassContainer(
                opacity: containerOpacity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.insert_chart_outlined_rounded,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                new Text(
                                  "Set Interest Rate",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            controller: interestRateController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Enter Interest Rate",
                              hintText: "Select according to HECM values",
                            ),
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      color: Colors.white70,
                      child: Text("Update"),
                      onPressed: () {
                        if (interestRateController.text.isEmpty ||
                            double.parse(interestRateController.text) < 3 ||
                            double.parse(interestRateController.text) >= 19 ||
                            double.parse(interestRateController.text) % 0.125 !=
                                0) {
                          Toast.show(
                              "Please Enter Valid interest Rate", context,
                              duration: 2, gravity: Toast.CENTER);
                          setState(() {
                            interestRateController.text = "";
                          });
                        } else {
                          firebaseInstance.child("interestValue").set({
                            "interest": interestRateController.text
                          }).whenComplete(() {
                            Toast.show("Value successfully updated", context,
                                duration: 2, gravity: Toast.CENTER);
                            interestRateController.text = "";
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GlassContainer(
                opacity: containerOpacity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.handHoldingUsd,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            new Text(
                              "Set Lending Limit",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CupertinoPicker(
                                    onSelectedItemChanged: (int value) {
                                      year = (value + 2021).toString();
                                    },
                                    itemExtent: 30,
                                    children: yearList,
                                    useMagnifier: true,
                                    scrollController: scrollController3,
                                    magnification: 1.3,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: lendingLimitController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      labelText: "Set Lending Limit",
                                      hintText:
                                          "Select according to HECM values",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.white70,
                        child: Text("Update"),
                        onPressed: () {
                          if (lendingLimitController.text.isEmpty) {
                            Toast.show(
                                "Please Enter Valid Lending Rate", context,
                                duration: 2, gravity: Toast.CENTER);
                            setState(() {
                              lendingLimitController.text = "";
                            });
                          } else {
                            firebaseInstance.child("lendingLimit").set({
                              "lendingLimit": lendingLimitController.text,
                              "year": year
                            }).whenComplete(() {
                              Toast.show("Value successfully updated", context,
                                  duration: 2, gravity: Toast.CENTER);
                              lendingLimitController.text = "";
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
