import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp()); //arrow notation for one lign functions

//The job of a widget is to provide a build() method that discribes how to display the widget. This description is done through lower level widgets.*/

//The app itself is a stateless widget. Its properties can't change - all values are final. 
//Contrary to stateful widgets, who maintain a state that might change during the lifetime of the widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { //build method
    return MaterialApp(
      title: 'Startup Name Generator',
      //home: Scaffold( //The scaffold widget provides a default app bar, and a body property that holds the widget tree for the home screen.
        home: RandomWords(), //home is RandomWords Widget, which uses Scaffold to display
          //appBar: AppBar( //Appbar widget
           // title: Text('Welcome to Flutter'),
         //),
          //body: Center( //Center widget aligns its widget subtree to the center.
           // child: RandomWords(), //Text child widget. Calling RandomWords statefulwidget which has a state.
        //),
      //),
    );
  }
}

//Implementing a stateful widget requires at least a StatefulWidget class that creates an instance of a State class. 
//The StatefulWidget class is itself immutable and can be thrown away and regenerated, but the State class persists over the lifetime of the widget.

//This widget just creates its State class.
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

//The state class extends State<RandomWords>, meaning that you're using a generic State class specialized for use with RandomWords. It maintains the state for the RandomWords widget specifically. 
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; //add a list variable called _suggestions to state WordPairings
  final _biggerFont = TextStyle(fontSize: 18.0); //need a variable to make font size larger

  //Adding a buildSuggestions funtion to build the ListView that displays the suggested word pairing
  //The ListView class provides a builder property : itemBuilder callback.  
  //Two parameteters are passed into it : the BuildContext and the row iterator i. It is called once per suggested word pairing. 
  //Iterator increments each the function is called : it increments twice : for the ListTile and for the Divider.
  //For even rows, the function adds a ListTile row for the word pairing. For odd rows, it adds a Divider widget. 
  Widget _buildSuggestions() {
    return ListView.builder( //Just for display, all the pairings are already in the suggestions list
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) { //2 parameters passed
        if (i.isOdd) return Divider();

        final index = i ~/ 2; //divides i by 2 and returns integer. So that we know nb of word pairings, minus the dividers.
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); //If you've reached the end of the available pairings, generate 10 more and add them to the list
        }
        return _buildRow(_suggestions[index]);
      });
  }

  //This function is called by _buildSuggestions once per pair. It displays each new pair in a ListTitle.
  Widget _buildRow(WordPair pair) {
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
  }
  //The scaffold widget provides a default app bar, and a body property that holds the widget tree for the home screen.
  Widget build(BuildContext context) {
    return Scaffold( //means it will hold the widget tree for the whole screen.
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}