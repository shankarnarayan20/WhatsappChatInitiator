import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsappchat/dialog.dart';
import 'package:whatsappchat/ui_helpers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'NotoSans'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          'Whatsapp Chat Initiator',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Color(0xff00b894),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpaceMassive,
            Text(
              'Enter a number you want to start a chat with',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            verticalSpaceLarge,
            Form(
              key: formKey,
              child: Row(
                children: [
                  horizontalSpaceMedium,
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      onChanged: (value) {
                        formKey.currentState.validate();
                      },
                      validator: (value) {
                        for (int i = 0; i < value.length; i++) {
                          if (value.codeUnitAt(i) < 48 ||
                              value.codeUnitAt(i) > 57) {
                            return 'Number Please';
                          }
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff00b894), width: 0.0),
                        ),
                        labelText: "Code",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: countryCodeController,
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff00b894), width: 0.0),
                        ),
                        labelText: "Phone Number",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      onChanged: (value) {
                        formKey.currentState.validate();
                      },
                      validator: (value) {
                        for (int i = 0; i < value.length; i++) {
                          if (value.codeUnitAt(i) < 48 ||
                              value.codeUnitAt(i) > 57) {
                            return 'Please enter only numbers';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  horizontalSpaceMedium,
                ],
              ),
            ),
            verticalSpaceLarge,
            RaisedButton(
              child: Text(
                'Start Chat',
                style: TextStyle(color: Colors.white),
              ),
              color: Color(0xff00b894),
              onPressed: () {
                if (countryCodeController.text.isEmpty ||
                    phoneNumberController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog();
                      });
                  return;
                }
                if (formKey.currentState.validate()) {
                  _launchURL(
                      countryCodeController.text, phoneNumberController.text);
                }
              },
            ),
            verticalSpaceMassive,
          ],
        ),
      ),
    );
  }

  _launchURL(String a, String b) async {
    var url = 'https://wa.me/+' + a + b;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
