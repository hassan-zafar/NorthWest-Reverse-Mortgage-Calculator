import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:northwest_reverse_mortgage/constants.dart';
import 'package:toast/toast.dart';
import 'homePage.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatefulWidget {
  final bool isPurchase;
  // final bool exceeds;
  ResultPage({
    @required this.isPurchase,
    // this.exceeds: false
  });
  @override
  _ResultPageState createState() => _ResultPageState();
}

String loanQualified;

class _ResultPageState extends State<ResultPage> {
  final formatCurrency =
      new NumberFormat.currency(decimalDigits: 0, symbol: "\$");

  String equityDownPayment;
  bool isLoading = false;
  var subscription;
  bool isOnline = true;
  bool exceedBool = false;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      return result;
    });
    print(subscription);
    Future.delayed(Duration.zero, () async {
      getValues();
    });
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOnline = false;
      });
    }
  }

  getValues() async {
    setState(() {
      isLoading = true;
    });

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
      setState(() {
        exceedBool = true;
      });
    }
    if (int.parse(homeValueController.text) >= 50000 &&
        int.parse(homeValueController.text) <= int.parse(lendingLimitStored)) {
      double interest;
      await firebaseInstance.child("interestValue").once().then((value) {
        String intr = value.value["interest"];
        interest = double.parse(intr);
        print(interest);
        double qwe = interest % interest.toInt();
        double rnpTimesTemp = qwe / 0.125;
        int rnpTimes = rnpTimesTemp.toInt();

        int internalCounter = interest.toInt() - 3;
        String age;
        print("internalCointer:" + "$internalCounter");

        if (isChecked) {
          if (int.parse(age1) <= int.parse(age2))
            age = age1;
          else
            age = age2;
        } else {
          age = age1;
        }
        print(age);
        firebaseInstance
            .child(age)
            .orderByChild("R1")
            .equalTo(6.125)
            .once()
            .then((a) {
          print(a.value[0]);
        });
        var asd = firebaseInstance
            .child(age)
            .orderByChild("R$rnpTimes")
            .equalTo(interest);
        asd.once().then((val) {
          // print(val.value);
          print(val.value[internalCounter]["PLF$rnpTimes"]);
          double plfValueString = val.value[internalCounter]["PLF$rnpTimes"];
          double loanQualifiedTemp =
              double.parse(homeValueController.text) * plfValueString;
          if (mounted) {
            setState(() {
              double equityDownPaymentTemp =
                  double.parse(homeValueController.text) - loanQualifiedTemp;
              equityDownPayment = formatCurrency.format(equityDownPaymentTemp);
              isLoading = false;
              loanQualified = formatCurrency.format(loanQualifiedTemp);
              homeValueController.text =
                  formatCurrency.format(double.parse(homeValueController.text));
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundImageBoxDecoration(),
        child: SafeArea(
          child: isOnline
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GlassContainer(
                              opacity: containerOpacity,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calculate_outlined,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.isPurchase
                                          ? "Purchase Payment Estimator"
                                          : "HECM Refinance Estimator",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GlassContainer(
                              opacity: containerOpacity,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: AutoSizeText(
                                          "Estimated Home Price:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              child: TextField(
                                                style: TextStyle(fontSize: 20),
                                                controller: homeValueController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  TextInputMask(
                                                      mask: '999,999,999,999',
                                                      reverse: true,
                                                      placeholder: "0"),
                                                ],
                                                decoration: InputDecoration(
                                                    // border: InputBorder.none,
                                                    hintText:
                                                        homeValueController
                                                            .text),
                                              ),
                                            ),
                                            Icon(Icons.edit_outlined),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GlassContainer(
                              opacity: containerOpacity,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: AutoSizeText(
                                          "Available Reverse Mortgage loan Proceeds:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: AutoSizeText(
                                          loanQualified != null
                                              ? "$loanQualified"
                                              : "loading",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          maxFontSize: 25,
                                          minFontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GlassContainer(
                              opacity: containerOpacity,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: AutoSizeText(
                                          widget.isPurchase
                                              ? "Down Payment:"
                                              : "Your Remaining Home Equity:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                          maxFontSize: 25,
                                          minFontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: AutoSizeText(
                                          equityDownPayment != null
                                              ? "$equityDownPayment"
                                              : "loading",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                          maxFontSize: 25,
                                          minFontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GlassContainer(
                              opacity: containerOpacity,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.warning_amber_outlined),
                                    Text(
                                        "The amount listed is only an estimate based on the information you have provided. This estimate is not a loan commitment and does not mean that you have been approved for a loan. The actual amount you may be eligible to receive is based on several factors in addition to the information you already provided, including the age of the youngest borrower, current interest rates and the lesser of the appraised value of the home, the sale price or the maximum lending limit. The amount available may be restricted for the first twelve months after the loan closes. Consult a reverse mortgage loan originator for detailed program terms by calling us toll free at 800-806-1472. Northwest Reverse Mortgage, LLC. ML- 5797/ CL-1834787/MBL-2081834787. Equal Opportunity Mortgage Broker licensed in Oregon, Washington, and Idaho. Credit on approval. Terms subject to change without notice. Not a commitment to lend."),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          exceedBool
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GlassContainer(
                                    opacity: containerOpacity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                          "Your Home Value exceeds the $currentYear FHA County Lending Limit so the calculation is based  off the current limits of $lendingLimitStored. For Jumbo reverse mortgage programs, reach out to us directly"),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black38,
                            ),
                          )
                        : Container(),
                    Positioned(
                      height: 80,
                      bottom: 0,
                      //left: MediaQuery.of(context).size.width * 0.3,
                      child: GestureDetector(
                        onTap: () => getValues(),
                        child: GlassContainer(
                          opacity: 0.7,
                          shadowStrength: 8,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calculate_outlined,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                AutoSizeText(
                                  "Re-Calculate",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    "NO INTERNET",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );
  }
}
