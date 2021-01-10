import 'package:flutter/material.dart';
import 'package:newestapp3/screens/landingpage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/signandlogin/textfield.dart';
import 'package:provider/provider.dart';

class EmailandPassword extends StatefulWidget {
  @override
  _EmailandPasswordState createState() => _EmailandPasswordState();
}

enum FormType { Register, Login }

class _EmailandPasswordState extends State<EmailandPassword> {
  var _formtype = FormType.Login;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passswordcontroler = TextEditingController();
  TextEditingController userNamecontroler = TextEditingController();

  void changeType() {
    setState(() {
      _formtype =
          _formtype == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);

    return Scaffold(
        body: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 10 / 10,
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 10 / 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1.50 / 10,
                      ),
                      Center(
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.20 / 10,
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Criticism and Useful app Please login to your account",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                "For quality content and reviews",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.60 / 10,
                      ),
                      if (_formtype == FormType.Register)
                        FormTextPart(
                            controller: userNamecontroler,
                            title: "User Name",
                            textinputtype: TextInputType.name),
                      FormTextPart(
                          controller: mailcontroller,
                          title: "Email",
                          textinputtype: TextInputType.emailAddress),
                      FormTextPart(
                          controller: passswordcontroler,
                          title: "Password",
                          textinputtype: TextInputType.visiblePassword)
                    ]),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 2.75 / 10),
                      height: MediaQuery.of(context).size.height * 0.60 / 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrangeAccent,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          if (_formtype == FormType.Register) {
                            debugPrint("${userNamecontroler.text}" +
                                "  User name kısmı");
                            _userprovider.signUp(userNamecontroler.text,
                                mailcontroller.text, passswordcontroler.text);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LandingPage()));
                          } else {
                            _userprovider.login(
                                mailcontroller.text, passswordcontroler.text);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LandingPage()));
                          }
                        },
                        child: Text(
                          _formtype == FormType.Login ? "LOGIN" : "SIGNUP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03 / 10,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            child: Text(
                              _formtype == FormType.Login ? "SIGNUP" : "LOGIN",
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                            onPressed: () {
                              changeType();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
