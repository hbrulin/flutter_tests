import 'package:flutter/material.dart';
import 'package:backdrop_widget/backdrop.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _frontLayers = [Text("Home Page")];

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
      frontLayer: _frontLayers[_currentIndex],
      backLayer: BackdropNavigationBackLayer(
        items: [
          ListTile(title: Text("Widget 1")),
          ListTile(title: Text("Widget 2")),
        ],
        onTap: (int position) => {setState(() => _currentIndex = position)},
      ),
    );
  }
}