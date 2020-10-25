// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Add text editing controllers : to be able to edit and clear the text in the TextFields
  //They are to be set in the TextFields' controller properties
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            // TODO: Wrap Username with AccentColorOverride (103)
            // TODO: Remove filled: true values (103)
            // TODO: Wrap Password with AccentColorOverride (103)
            //Add Textfields for input
            // Name
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled:true, //background distinguishable
                labelText: 'Username',
              ),
            ),
            //spacer
            SizedBox(height: 12.0),
          //Password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true, //replaces with bullets
            ),
            // TODO: Add button bar (101)
            ButtonBar(//this arranges its children in a row
              //TODO : Add a beveled rectangular border do CANCEL (103)
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'), //for the action you don't want people to do
                  onPressed: () {
                    //clear the text fields
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                //TODO : Add an elevation to NEXT(103)
                //TODO : Add a beveled rectangular border to NEXT(103)
                RaisedButton( //for the action you want people to do
                  child: Text('NEXT'),
                  onPressed: () {
                    //pop the most recent route from the navigator (login is on top of home as defined in app.dart)
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
