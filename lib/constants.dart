import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:northwest_reverse_mortgage/refinanceExplainationPage.dart';
import 'package:toast/toast.dart';
import 'homePage.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:url_launcher/url_launcher.dart';

const double containerOpacity = 0.6;
const url = "https://www.nwreverse.com/are-you-eligible-free-assessment/";
launchURL() async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

showFirstDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
            title: Center(child: Text("Disclaimer")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            //backgroundColor: Colors.black,
            elevation: 20.0,
            titlePadding: EdgeInsets.all(10.0),
            contentPadding: EdgeInsets.all(10.0),
            children: [
              Text(
                  "Northwest Reverse Mortgage, LLC. ML- 5797/ CL-1834787/MBL-2081834787. Equal Opportunity Mortgage Broker licensed in Oregon, Washington, and Idaho. Credit on approval. Terms subject to change without notice. Not a commitment to lend. Contents not provided by, or approved by FHA, HUD, or any other government agency. All potential tax benefits should be verified with a professionally licensed tax advisor.At the conclusion of a reverse mortgage, the borrower must repay the loan and may have to sell the home or repay the loan from other proceeds; charges will be assessed with the loan, including an origination fee, closing costs, mortgage insurance premiums and servicing fees; the loan balance grows over time and interest is charged on the outstanding balance; the borrower remains responsible for property taxes, hazard insurance and home maintenance, and failure to pay these amounts may result in the loss of the home; interest on a reverse mortgage is not tax deductible until the borrower makes partial or full re-payment."),
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool val) {
                      print(val);
                      setState(() {
                        storedValues.write("firstScreenDialogShow", val);
                        firstScreenDialogShow =
                            storedValues.read("firstScreenDialogShow");
                        print(firstScreenDialogShow);
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: firstScreenDialogShow,
                  ),
                  Text("Do not show this again."),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(child: Text("Continue")),
                    )),
              )
            ],
          );
        });
      });
}

GestureDetector learnMore() {
  return GestureDetector(
    onTap: () {
      launchURL();
    },
    child: GlassContainer(
      opacity: containerOpacity,
      blur: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.bubble_chart_outlined), Text("   Learn More")],
        ),
      ),
    ),
  );
}

Padding logoWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GlassContainer(
      opacity: containerOpacity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
  );
}

void moveToResultPage(BuildContext context, bool isPurchase) {
  homeValueController.text = homeValueController.text.replaceAll(",", "");
  homeValueController.text = homeValueController.text.replaceAll("\$", "");
  if (homeValueController.text.isEmpty) {
    homeValueController.text = "";
    Toast.show("Please Enter Valid Home Price", context,
        duration: 2, gravity: Toast.CENTER);
  } else if (int.parse(homeValueController.text) < 50000) {
    Toast.show("Home Value Too Low", context,
        duration: 2, gravity: Toast.CENTER);
  } else if (int.parse(homeValueController.text) >
      int.parse(lendingLimitStored)) {
    homeValueController.text = lendingLimitStored;
    lastScreenDialogShow
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(
                      isPurchase: isPurchase,
                    )),
          )
        : disclaimerDialog(context);
  } else if (int.parse(homeValueController.text) >= 50000 &&
      int.parse(homeValueController.text) <= int.parse(lendingLimitStored)) {
    lastScreenDialogShow
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(
                      isPurchase: isPurchase,
                    )),
          )
        : disclaimerDialog(context);
  } else {
    homeValueController.text = "";
    Toast.show("Please Enter Valid Home Price", context,
        duration: 2, gravity: Toast.CENTER);
  }
}

Future disclaimerDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
            title: Center(child: Text("Disclaimer")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            //backgroundColor: Colors.black,
            elevation: 20.0,
            titlePadding: EdgeInsets.all(10.0),
            contentPadding: EdgeInsets.all(10.0),
            children: [
              Text(
                  "The amount listed is only an estimate based on the information you have provided. This estimate is not a loan commitment and does not mean that you have been approved for a loan. The actual amount you may be eligible to receive is based on several factors in addition to the information you already provided, including the age of the youngest borrower, current interest rates and the lesser of the appraised value of the home, the sale price or the maximum lending limit. The amount disclosed in the application is the actual FHA principle limit and DOES NOT include closings costs which may vary depending on market conditions. The amount available may be restricted for the first twelve months after the loan closes. Consult a reverse mortgage loan originator for detailed program terms by calling us toll free at 800-806-1472. Northwest Reverse Mortgage, LLC. ML- 5797/ CL-1834787/MBL-2081834787. Equal Opportunity Mortgage Broker licensed in Oregon, Washington, and Idaho. Credit on approval. Terms subject to change without notice. Not a commitment to lend."),
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool val) {
                      setState(() {
                        storedValues.write("lastScreenDialogShow", val);
                        lastScreenDialogShow =
                            storedValues.read("lastScreenDialogShow");
                      });
                      print(lastScreenDialogShow);
                    },
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: lastScreenDialogShow,
                  ),
                  Text("Do not show this again."),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultPage(
                                  isPurchase: true,
                                )),
                      );
                    },
                    child: Text("Accept"),
                  ),
                ],
              ),
            ],
          );
        });
      });
}

BoxDecoration backgroundColorBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xff31B44A),
        Color(0xffFFD100),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topLeft,
    ),
  );
}

BoxDecoration backgroundImageBoxDecoration() {
  return BoxDecoration(
      image: DecorationImage(
          image: AssetImage("background.jpg"), fit: BoxFit.fill));
}

class BlurredCard extends StatelessWidget {
  BlurredCard({
    Key key,
    this.cupertinoList,
    @required this.text,
    this.hasText = false,
    this.textController,
  }) : super(key: key);
  final String text;
  final List<Text> cupertinoList;
  final bool hasText;
  final TextEditingController textController;
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(
          initialItem:
              //showRegionDialog ? 0 :
              0);

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    //final lendingLimitValue = storedValues.read("lendingLimit");
    return GlassContainer(
      width: MediaQuery.of(context).size.width,
      opacity: containerOpacity,
      height: 120,
      blur: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                hasText ? "$text" : text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: hasText
                        ? Center(
                            child: TextField(
                              controller: textController,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                TextInputMask(
                                    mask: '999,999,999,999',
                                    reverse: true,
                                    placeholder: "0"),
                              ],
                              decoration: InputDecoration(
                                  hintText: "min \$50,000",
                                  border: InputBorder.none),
                            ),
                          )
                        : CupertinoPicker(
                            onSelectedItemChanged: (int value) {
                              // if (showRegionDialog) {
                                age1 = (value + 62).toString();
                              // } else {
                              // age1 = (value + 18).toString();
                              // }
                            },
                            itemExtent: 30,
                            scrollController: scrollController,
                            children: cupertinoList,
                            useMagnifier: true,
                            magnification: 1.3,
                          ),
                  ),
                  hasText
                      ? MyTooltip(
                          message:
                              "$currentYear FHA lending limits are \$$lendingLimitStored. For Home Values over this amount, please contact us about our jumbo reverse mortgage options",
                          child: Icon(
                            Icons.error_outline_sharp,
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({@required this.message, @required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}

List<Text> statesNamesList = [
  // Text("Alabama"),
  Text("Oregon"),
  Text("Washington"),
  Text("Idaho"),
//   Text("Alaska"),
//   Text("American Samoa"),
//   Text("Arizona"),
//   Text("Arkansas"),
//   Text("California"),
//   Text("Colorado"),
//   Text("Connecticut"),
//   Text("Delaware"),
//   Text("District of Columbia"),
//   Text("States of Micronesia"),
//   Text("Florida"),
//   Text("Georgia"),
//   Text("Guam"),
//   Text("Hawaii"),
//   Text("Iowa"),
//   Text("Illinois"),
//   Text("Indiana"),
//   Text("Kansas"),
//   Text("Kentucky"),
//   Text("Louisiana"),
//   Text("Maine"),
//   Text("Marshall Islands"),
//   Text("Maryland"),
//   Text("Massachusetts"),
//   Text("Michigan"),
//   Text("Minnesota"),
//   Text("Mississippi"),
//   Text("Missouri"),
//   Text("Montana"),
//   Text("Nebraska"),
//   Text("Nevada"),
//   Text("New Hampshire"),
//   Text("New Jersey"),
//   Text("New Mexico"),
//   Text("New York"),
//   Text("North Carolina"),
//   Text("North Dakota"),
//   Text("Northern Mariana Islands"),
//   Text("Ohio"),
//   Text("Oklahoma"),
//   Text("Oregon"),
//   Text("Palau"),
//   Text("Pennsylvania"),
//   Text("Puerto Rico"),
//   Text("Rhode Island"),
//   Text("South Carolina"),
//   Text("South Dakota"),
//   Text("Tennessee"),
//   Text("Texas"),
//   Text("Utah"),
//   Text("Vermont"),
//   Text("Virgin Island"),
//   Text("Virginia"),
//   Text("West Virginia"),
//   Text("Wisconsin"),
//   Text("Wyoming"),
];

List<Text> yearList = [
  Text("2021"),
  Text("2022"),
  Text("2023"),
  Text("2024"),
  Text("2025"),
  Text("2026"),
  Text("2027"),
  Text("2028"),
  Text("2029"),
  Text("2030"),
  Text("2031"),
  Text("2032"),
  Text("2033"),
  Text("2034"),
  Text("2035"),
  Text("2036"),
  Text("2037"),
  Text("2038"),
  Text("2039"),
  Text("2040"),
];
List<Text> ageList = [
  Text("18"),
  Text("19"),
  Text("20"),
  Text("21"),
  Text("22"),
  Text("23"),
  Text("24"),
  Text("25"),
  Text("26"),
  Text("27"),
  Text("28"),
  Text("29"),
  Text("30"),
  Text("31"),
  Text("32"),
  Text("33"),
  Text("34"),
  Text("35"),
  Text("36"),
  Text("37"),
  Text("38"),
  Text("39"),
  Text("40"),
  Text("41"),
  Text("42"),
  Text("43"),
  Text("44"),
  Text("45"),
  Text("46"),
  Text("47"),
  Text("48"),
  Text("49"),
  Text("50"),
  Text("51"),
  Text("52"),
  Text("53"),
  Text("54"),
  Text("55"),
  Text("56"),
  Text("57"),
  Text("58"),
  Text("59"),
  Text("60"),
  Text("61"),
  Text("62"),
  Text("63"),
  Text("64"),
  Text("65"),
  Text("66"),
  Text("67"),
  Text("68"),
  Text("69"),
  Text("70"),
  Text("71"),
  Text("72"),
  Text("73"),
  Text("74"),
  Text("75"),
  Text("76"),
  Text("77"),
  Text("78"),
  Text("79"),
  Text("80"),
  Text("81"),
  Text("82"),
  Text("83"),
  Text("84"),
  Text("85"),
  Text("86"),
  Text("87"),
  Text("88"),
  Text("89"),
  Text("90"),
  Text("91"),
  Text("92"),
  Text("93"),
  Text("94"),
  Text("95"),
  Text("96"),
  Text("97"),
  Text("98"),
  Text("99"),
];
List<Text> ageListSelected = [
  Text("62"),
  Text("63"),
  Text("64"),
  Text("65"),
  Text("66"),
  Text("67"),
  Text("68"),
  Text("69"),
  Text("70"),
  Text("71"),
  Text("72"),
  Text("73"),
  Text("74"),
  Text("75"),
  Text("76"),
  Text("77"),
  Text("78"),
  Text("79"),
  Text("80"),
  Text("81"),
  Text("82"),
  Text("83"),
  Text("84"),
  Text("85"),
  Text("86"),
  Text("87"),
  Text("88"),
  Text("89"),
  Text("90"),
  Text("91"),
  Text("92"),
  Text("93"),
  Text("94"),
  Text("95"),
  Text("96"),
  Text("97"),
  Text("98"),
  Text("99"),
];
