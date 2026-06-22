import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:number_text_input_formatter/number_text_input_formatter.dart";
import 'package:share_plus/share_plus.dart';
import 'l10n/app_localizations.dart';
import 'package:dynamic_color/dynamic_color.dart';

// Classes

class ValueRow extends StatelessWidget {
  final String letter;
  final Color color;
  final String text;
  final ValueChanged<double?> onValueChanged;

  const ValueRow({
    super.key,
    required this.letter,
    required this.color,
    required this.text,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(start: 16, end: 16),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: SizedBox(
              width: 48,
              height: 48,
              child: ColoredBox(
                color: color,
                child: Container(
                  alignment: Alignment(0, 0),
                  child: Text(
                    letter,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight(600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 16),
          width: 150,
          child: TextField(
            onChanged: (value) {
              onValueChanged(double.tryParse(value));
            },
            inputFormatters: [NumberTextInputFormatter(allowNegative: true)],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.typeTheValue,
              hintStyle: TextStyle(
                color: ColorScheme.of(context).onSurface.withAlpha(85),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MainState extends State<MainWidget> {
  // Class variables

  bool invertProportionSwitch = false;
  String resultField = "-";
  double? valueA;
  double? valueB;
  double? valueC;

  // Class objects
  late TextEditingController controller;

  // Class methods

  double calculate({
    required double valueA,
    required double valueB,
    required double valueC,
    bool isInverted = false,
  }) {
    if (!isInverted) {
      return (valueB * valueC) / valueA;
    } else {
      return (valueA * valueC) / valueB;
    }
  }

  String calculateToString(
    bool invertProportionSwitch,
    BuildContext context,
    double? valueA,
    double? valueB,
    double? valueC,
  ) {
    if (AppLocalizations.of(context)!.localeName == 'pt') {
      return calculate(
        valueA: valueA!,
        valueB: valueB!,
        valueC: valueC!,
        isInverted: invertProportionSwitch,
      ).toStringAsFixed(4).replaceAll('.', ',');
    } else {
      return calculate(
        valueA: valueA!,
        valueB: valueB!,
        valueC: valueC!,
        isInverted: invertProportionSwitch,
      ).toStringAsFixed(4);
    }
  }

  String removeFloatingZeros(String input, String decimalSeparator) {
    List<String> splitedInput = input.split(decimalSeparator);
    String decimals = splitedInput[1].replaceFirst(RegExp(r'0+$'), '');
    if (decimals.isEmpty) {
      return splitedInput[0];
    } else {
      return "${splitedInput[0]}$decimalSeparator$decimals";
    }
  }

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: resultField);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).surfaceContainer,
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).surfaceContainer,
        title: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.ruleOf3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight(600),
                fontSize: 25,
                color: ColorScheme.of(context).primary,
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.fillValues,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight(400),
                fontSize: 18,
                color: ColorScheme.of(context).secondary,
              ),
            ),
          ],
        ),
        centerTitle: true,
        clipBehavior: Clip.none,
        toolbarHeight: 100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card.filled(
                  elevation: 2,
                  color: ColorScheme.of(context).surface,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Text(
                            AppLocalizations.of(context)!.values,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight(700),
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: ColorScheme.of(context).primary,
                            ),
                          ),
                        ),
                        ValueRow(
                          color: Color.fromARGB(255, 0, 74, 211),
                          letter: "A",
                          text: "${AppLocalizations.of(context)!.value} A",
                          onValueChanged: (value) {
                            valueA = value;
                            if (valueB != null && valueC != null) {
                              setState(() {
                                resultField = removeFloatingZeros(
                                  calculateToString(
                                    invertProportionSwitch,
                                    context,
                                    valueA,
                                    valueB,
                                    valueC,
                                  ),
                                  AppLocalizations.of(
                                    context,
                                  )!.decimalSeparator,
                                );
                                controller.text = resultField;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        ValueRow(
                          color: Color.fromARGB(255, 0, 179, 68),
                          letter: "B",
                          text: "${AppLocalizations.of(context)!.value} B",
                          onValueChanged: (value) {
                            valueB = value;
                            if (valueA != null && valueC != null) {
                              setState(() {
                                resultField = removeFloatingZeros(
                                  calculateToString(
                                    invertProportionSwitch,
                                    context,
                                    valueA,
                                    valueB,
                                    valueC,
                                  ),
                                  AppLocalizations.of(
                                    context,
                                  )!.decimalSeparator,
                                );
                                controller.text = resultField;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        ValueRow(
                          color: Color.fromARGB(255, 84, 0, 179),
                          letter: "C",
                          text: "${AppLocalizations.of(context)!.value} C",
                          onValueChanged: (value) {
                            valueC = value;
                            if (valueB != null && valueA != null) {
                              setState(() {
                                resultField = removeFloatingZeros(
                                  calculateToString(
                                    invertProportionSwitch,
                                    context,
                                    valueA,
                                    valueB,
                                    valueC,
                                  ),
                                  AppLocalizations.of(
                                    context,
                                  )!.decimalSeparator,
                                );
                                controller.text = resultField;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 5),
                        Divider(indent: 16, endIndent: 16),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment(0, 0),
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: Icon(
                                Icons.swap_horiz_rounded,
                                size: 40,
                                color: ColorScheme.of(context).primary,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.invertProportion,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              child: Switch(
                                value: invertProportionSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    invertProportionSwitch = value;
                                    if (valueA != null &&
                                        valueB != null &&
                                        valueC != null) {
                                      resultField = removeFloatingZeros(
                                        calculateToString(
                                          invertProportionSwitch,
                                          context,
                                          valueA,
                                          valueB,
                                          valueC,
                                        ),
                                        AppLocalizations.of(
                                          context,
                                        )!.decimalSeparator,
                                      );
                                    }
                                    controller.text = resultField;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card.filled(
                  elevation: 2,
                  color: ColorScheme.of(context).surface,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Text(
                            AppLocalizations.of(context)!.result,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight(700),
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: ColorScheme.of(context).primary,
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: TextField(
                              onTap: () {
                                if (controller.text != "-") {
                                  Clipboard.setData(
                                    ClipboardData(text: controller.text),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)!.copied,
                                      ),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                }
                              },
                              controller: controller,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.top,
                              style: TextStyle(fontSize: 32),
                              enableInteractiveSelection: false,
                              readOnly: true,
                              canRequestFocus: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorScheme.of(
                                  context,
                                ).primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (resultField != "-") {
                                  SharePlus.instance.share(
                                    ShareParams(text: "${resultField}"),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.ios_share,
                                    color: ColorScheme.of(context).onPrimary,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    AppLocalizations.of(context)!.shareResult,
                                    style: TextStyle(
                                      color: ColorScheme.of(context).onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  // Class methods
  @override
  State<MainWidget> createState() {
    return MainState();
  }
}

// Main method

void main() {
  runApp(
    DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.light,
              seedColor: lightDynamic?.primary ?? Colors.blue,
            ),
          ),
          darkTheme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: lightDynamic?.primary ?? Colors.blue,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MainWidget(),
        );
      },
    ),
  );
}
