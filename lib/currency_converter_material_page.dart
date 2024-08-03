import 'package:flutter/material.dart';

/*
 * Unlike StatelessWidget which is immutable (Meaning once a widget is declared
 *  it cannot be changed), a StatefulWidget is mutable. This means that we can
 * change the various widgets on the screen like the text etc.
 * In this app, i decided to use the StatefulWidget because the text displaying the converted amount will change
 */
class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

/*
 * When you use the StatefulWidget, it requires the a State() hence the createState() method above,
 * given that State() is an abstract class, it cannot be instantiated in the CurrencyConverterMaterialPage class,
 * therefore i created the the private class below _CurrencyConverterMaterialPageState
 * which extends the the State() class then instantiated the _CurrencyConverterMaterialPageState in the
 * createState()
 *
 * The underscore before _CurrencyConverterMaterialPageState class means that it is a private class,
 * meaning that this class can only be accessible within this file.
 */
class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  /*
  * To get the input given by a user from the textField, we use the TextViewEditingController.
  * I also decide to put the result and textEditingController outside the build function.
  * This is because the build function in high refresh rate phones eg 120Hz will
  * lead to the build function being called 120 times per second. This means that
  * any overload on the function will lead to memory leaks in UI leading tO bad UX
  */
  double result = 0;
  final TextEditingController dollarInputController = TextEditingController();

  @override
  void dispose() {
    dollarInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
        strokeAlign: BorderSide.strokeAlignInside,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "KES.${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 45,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: dollarInputController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: "Enter amount in USD",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.white12,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    // Get the input given by the user then convert the dollars to KSH. by multiplying by 132
                    result = double.parse(dollarInputController.text) * 132;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Convert",
                  style: TextStyle(
                    fontSize: 20,
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
