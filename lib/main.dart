import "package:flutter/material.dart";

// Classes

class MainState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).surfaceContainer,
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).surfaceContainer,
        title: Column(
          children: [
            Text(
              "Rule of 3",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight(600),
                fontSize: 25,
                color: ColorScheme.of(context).primary,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Fill 3 values to calculate the fourth.",
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card.filled(
                elevation: 2,
                color: ColorScheme.of(context).surface,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          "Values",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight(700),
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: ColorScheme.of(context).primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card.filled(
                elevation: 2,
                color: ColorScheme.of(context).surface,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          "Result",
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
                            controller: TextEditingController(text: "-"),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.top,
                            style: TextStyle(fontSize: 32),
                            enableInteractiveSelection: false,
                            readOnly: true,
                            canRequestFocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.ios_share),
                                SizedBox(width: 10),
                                Text("Share result"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() {
    return MainState();
  }
}

// Variables

double? valueA;
double? valueB;
double? valueC;

// Objects

// Methods

double calculate({
  required double valueA,
  required double valueB,
  required double valueC,
  bool isInverted = false,
}) {
  if (!isInverted) {
    return (valueB * valueC) / valueA;
  } else {
    return (valueA * valueB) / valueC;
  }
}

void main() {
  runApp(MaterialApp(home: MainWidget()));
}
