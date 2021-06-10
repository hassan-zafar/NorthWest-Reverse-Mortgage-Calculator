import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:northwest_reverse_mortgage/constants.dart';

import 'homePage.dart';

class PurchasePage extends StatefulWidget {
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final FixedExtentScrollController scrollController2 =
      FixedExtentScrollController(initialItem: 44);


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logoWidget(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 12, bottom: 12),
                child: GlassContainer(
                  opacity: containerOpacity,
                  blur: 3,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Purchase Price Estimator",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 12, bottom: 12),
                  child: BlurredCard(
                    text: "Home Purchase Value:",
                    hasText: true,
                    textController: homeValueController,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 12, bottom: 12),
                child: BlurredCard(
                  text: "Your Age:",
                  cupertinoList:
                      // showRegionDialog ? ageListSelected :
                      ageListSelected,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 12, bottom: 12),
                child: Stack(
                  // alignment: Alignment.center,
                  // fit: StackFit.loose,
                  children: [
                    GlassContainer(
                      width: MediaQuery.of(context).size.width,
                      opacity: containerOpacity,
                      height: 120,
                      blur: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Partner's Age:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    child: isChecked
                                        ? CupertinoPicker(
                                            onSelectedItemChanged: (int value) {
                                              age2 = (value + 18).toString();
                                            },
                                            itemExtent: 30,
                                            children: ageList,
                                            useMagnifier: true,
                                            scrollController: scrollController2,
                                            magnification: 1.3,
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // !isChecked
                    //     ? Positioned.fill(
                    //         child: GlassContainer(
                    //           shadowStrength: 0,
                    //         ),
                    //       )
                    //     : Container(),
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Checkbox(
                        onChanged: (bool val) {
                          setState(() {
                            isChecked = val;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: isChecked,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 12, bottom: 12),
                child: learnMore(),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: GlassContainer(
            opacity: 0.7,
            height: 80,
            shadowStrength: 8,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  moveToResultPage(context, true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Calculate",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
