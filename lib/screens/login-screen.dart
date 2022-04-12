import 'package:flutter/material.dart';
import 'package:login_app/provider/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  String? _email ;
  String? _password;

  void submit(){
    Provider.of<Auth>(context, listen: false).login(
      credentials: {
        'email':_email,
        'password':_password
      }
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Posts'
        ),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                 TextFormField(
                   initialValue: 'kevinkone19@gmail.com',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Email',
                    hintText: 'kevinkone19@gmail.com'
                  ),
                   onSaved: (value)=>_email = value.toString(),
                ),
                 const SizedBox(
                   height: 10.0,
                 ),
                 TextFormField(
                   initialValue: '123456',
                  decoration:  InputDecoration(
                      labelText: 'Password',
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  ),
                  obscureText: true,
                   onSaved: (value)=>_password = value.toString(),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: ()=>{
                      _formKey.currentState?.save(),
                      submit(),
                    },
                    child: const Text(
                      'Login'
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
