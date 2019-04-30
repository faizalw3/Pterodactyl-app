import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './shared_preferences_helper.dart';
import 'home.dart';
import 'main.dart';

class User {
  final String api, url;
  const User({
    this.api,
    this.url,
  });
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _apiController = TextEditingController();
  final _urlController = TextEditingController();

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
                Image.asset('assets/images/pterodactyl_icon.png', width: 100),
                SizedBox(height: 8.0),
                Text(
                  'PTERODACTYL APP',
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
            SizedBox(height: 80.0),
            AccentColorOverride(
              color: Color(0xFF442B2D),
              child: TextField(
                controller: _apiController,
                decoration: InputDecoration(
                  labelText:
                      DemoLocalizations.of(context).trans('api_key_login'),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            AccentColorOverride(
              color: Color(0xFFC5032B),
              child: TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: DemoLocalizations.of(context).trans('url_login'),
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('clear_login'),
                  ),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    _apiController.clear();
                    _urlController.clear();
                  },
                ),
                RaisedButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('next_login'),
                  ),
                  elevation: 8.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () async {
                    await SharedPreferencesHelper.setApiUrlString(
                        "apiKey", _apiController.text);
                    await SharedPreferencesHelper.setApiUrlString(
                        "panelUrl", _urlController.text);
                    var route = MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage());
                    Navigator.of(context).push(route);
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

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
