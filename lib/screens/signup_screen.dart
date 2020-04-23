import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function toggleView;
  SignupScreen(this.toggleView);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool isOTP = false;

  Widget get otpEntry {
    return Form(
      key: _formKey2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                labelText: 'Enter OTP',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter OTP';
                }

                return null;
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () {
                if (_formKey2.currentState.validate()) {
                  // TODO submit
                }
              },
              color: Theme.of(context).accentColor,
              child: Text(
                'Singup',
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      ),
    );
  }

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  Widget get phoneNumberEntry {
    return Form(
      key: _formKey1,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              focusNode: _nameFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                labelText: 'Full Name',
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_bioFocus),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Name!';
                }
                return null;
              },
            ),
            TextFormField(
              focusNode: _bioFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                labelText: 'Bio',
              ),
              maxLines: 3,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_phoneFocus),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Bio';
                }
                return null;
              },
            ),
            TextFormField(
              focusNode: _phoneFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                labelText: 'Phone Number',
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              validator: (value) {
                Pattern pattern =
                    r'^(?:(?:\+?[0-9]+\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';
                RegExp regex = new RegExp(pattern);

                if (value.isEmpty) {
                  return 'Please Enter your Phone Number';
                }
                if (!regex.hasMatch(value)) {
                  return 'Enter a valid phone number with country code.';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () {
                if (_formKey1.currentState.validate()) {
                  setState(() {
                    isOTP = true;
                  });
                }
              },
              color: Theme.of(context).accentColor,
              child: Text(
                'Send OTP',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            FlatButton(
              onPressed: () {
                widget.toggleView();
              },
              child: Text(
                'Have an account? Login',
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Signup',
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                height: 500,
                child: isOTP ? otpEntry : phoneNumberEntry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
