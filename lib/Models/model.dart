// To parse this JSON data, do
//
//     final tableValues = tableValuesFromJson(jsonString);

import 'dart:convert';

Map<String, List<TableValues>> tableValuesFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<TableValues>>(k, List<TableValues>.from(v.map((x) => TableValues.fromJson(x)))));

String tableValuesToJson(Map<String, List<TableValues>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class TableValues {
    TableValues({
        this.r0,
        this.plf0,
        this.r1,
        this.plf1,
        this.r2,
        this.plf2,
        this.r3,
        this.plf3,
        this.r4,
        this.plf4,
        this.r5,
        this.plf5,
        this.r6,
        this.plf6,
        this.r7,
        this.plf7,
    });

    double r0;
    double plf0;
    double r1;
    double plf1;
    double r2;
    double plf2;
    double r3;
    double plf3;
    double r4;
    double plf4;
    double r5;
    double plf5;
    double r6;
    double plf6;
    double r7;
    double plf7;

    factory TableValues.fromJson(Map<String, dynamic> json) => TableValues(
        r0: json["R0"],
        plf0: json["PLF0"],
        r1: json["R1"].toDouble(),
        plf1: json["PLF1"].toDouble(),
        r2: json["R2"].toDouble(),
        plf2: json["PLF2"].toDouble(),
        r3: json["R3"].toDouble(),
        plf3: json["PLF3"].toDouble(),
        r4: json["R4"].toDouble(),
        plf4: json["PLF4"].toDouble(),
        r5: json["R5"].toDouble(),
        plf5: json["PLF5"].toDouble(),
        r6: json["R6"].toDouble(),
        plf6: json["PLF6"].toDouble(),
        r7: json["R7"].toDouble(),
        plf7: json["PLF7"],
    );

    Map<String, dynamic> toJson() => {
        "R0": r0,
        "PLF0": plf0,
        "R1": r1,
        "PLF1": plf1,
        "R2": r2,
        "PLF2": plf2,
        "R3": r3,
        "PLF3": plf3,
        "R4": r4,
        "PLF4": plf4,
        "R5": r5,
        "PLF5": plf5,
        "R6": r6,
        "PLF6": plf6,
        "R7": r7,
        "PLF7": plf7,
    };
}
