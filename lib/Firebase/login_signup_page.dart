import 'package:Nueva/Welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new LoginSignupPageState();
}

class LoginSignupPageState extends State<LoginSignupPage> {
  FirebaseUser user;
  String error;

  void setUser(FirebaseUser user) {
    setState(() {
      this.user = user;
      this.error = null;
    });
  }

  void setError(e) {
    setState(() {
      this.user = null;
      this.error = e.toString();
    });
  }

  final databaseReference = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  _inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  void recorduserdata() async {
    final documentId = await getUID();
    await databaseReference
        .collection("UserData")
        .document("$documentId")
        .setData({
      'Setup': 'false',
    });
  }

  void getData() async {
    databaseReference
        .collection("UserData")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((documentId) => print(getUID()['First Name']));
    });
  }

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    final documentId = getUID();
    return Firestore.instance
        .collection('UserName')
        .document('$documentId')
        .snapshots();
  }

  final _formKey = new GlobalKey<FormState>();
  final snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  getemail() {
    return _email;
  }

  String _name;
  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

// 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Text(_isLoginForm ? 'Welcome,\nLogin' : 'Welcome,\nRegister',
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Container(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                    'Enter your information below or log in with your social account.',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              _showForm(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  _showCircularProgress(),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (toggleFormMode),
        child: Icon(
          Icons.cached,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo[100]),
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content:
//              new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                toggleFormMode();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 0,
              ),
              showEmailInput(),
              SizedBox(height: 10),
              showPasswordInput(),
              SizedBox(
                height: 10,
              ),
              showPrimaryButton(),
              SizedBox(
                height: 10,
              ),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.redAccent[400],
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 0.0),
      child: new TextFormField(
        style: TextStyle(color: Colors.grey[400]),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[400])),
          enabledBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[300])),
          hintStyle: TextStyle(color: Colors.grey[200]),
          labelStyle: TextStyle(color: Colors.grey[200]),
          hintText: 'Email',
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: new TextFormField(
        style: TextStyle(color: Colors.grey[400]),
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[400])),
          enabledBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[300])),
          hintStyle: TextStyle(color: Colors.grey[200]),
          labelStyle: TextStyle(color: Colors.grey[200]),
          hintText: 'Password',
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: new TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400])),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(6.0, 40.0, 6.0, 0.0),
        child: SizedBox(
          height: 45.0,
          child: new RaisedButton(
            elevation: 0.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: Colors.indigo[100],
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.grey[100])),
            onPressed: (validateAndSubmit),
          ),
        ));
  }
}
