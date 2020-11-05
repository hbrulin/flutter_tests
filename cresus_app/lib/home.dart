import 'package:flutter/material.dart';
import 'package:backdrop_widget/backdrop.dart';
import 'products.dart';
import 'mysavings.dart';
import 'feelinguseful.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _pushProducts() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => Products()),
    );
  }

  void _pushMySavings() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => MySavings()),
    );
  }

  void _pushFeelingUseful() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => FeelingUseful()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text("Bienvenue"),
      iconPosition: BackdropIconPosition.leading,
      actions: <Widget>[
        BackdropToggleButton(
          icon: AnimatedIcons.list_view,
        ),
      ],
      frontLayer: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 120.0),
            Text(
              '1000 €',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 15.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                '+ 3% depuis le xx/xx/xx'
                ),
                Text('60% disponible')
            ]),
            SizedBox(height: 60.0),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  child: Text('Produits'),
                  color: Theme.of(context).buttonColor,
                  onPressed: _pushProducts,
                ),
                RaisedButton(
                  child: Text('Mon épargne'),
                  color: Theme.of(context).buttonColor,
                  onPressed: _pushMySavings,
                ),
              ],
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              child:
              Text('Voir ce que je finance'),
              color: Theme.of(context).buttonColor,
              onPressed: _pushFeelingUseful,
            ),
          ],
      ),
      backLayer: BackdropNavigationBackLayer(
        items: [
          ListTile(title: Text("Mon profil", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)))),
          ListTile(title: Text("Mon épargne", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)))),
          ListTile(title: Text("Mes contrats", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)))),
          ListTile(title: Text("Paramètres", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)))),
          ListTile(title: Text("Legal stuff", style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.6)))),
        ],
        onTap: (int position) => {setState(() => _currentIndex = position)},
      ),
    );
  }
}