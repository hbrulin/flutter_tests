import 'package:flutter/material.dart';
import 'package:backdrop_widget/backdrop.dart';

class FeelingUseful extends StatefulWidget{
  @override
  _FeelingUsefulState createState() => _FeelingUsefulState();
}

class _FeelingUsefulState extends State<FeelingUseful> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text('Feeling Useful'),
      iconPosition: BackdropIconPosition.leading,
      actions: [
        BackdropToggleButton(
          icon: AnimatedIcons.list_view,
        ),
      ],
      frontLayer: Text('Lala'),
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