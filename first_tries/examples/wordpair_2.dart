import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp()); //arrow notation for one lign functions

//The job of a widget is to provide a build() method that discribes how to display the widget. This description is done through lower level widgets.*/

//The app itself is a stateless widget. Its properties can't change - all values are final. 
//Contrary to stateful widgets, who maintain a state that might change during the lifetime of the widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { //build method
    return MaterialApp( // MaterialApp never forget - used fir many things and especially Navigator.
      title: 'Startup Name Generator',
        theme: ThemeData(
          primaryColor: Colors.yellow,
          scaffoldBackgroundColor: Colors.white,
          dividerColor: Colors.yellow,
        ),
        home: RandomWords(), //home is RandomWords Widget, which uses Scaffold to display
    
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
  final _saved = Set<WordPair>(); //this set stores the word pairings that the user favritied. A set doesn't allow duplicate entries.
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
    final alreadySaved = _saved.contains(pair); //check if word pairing not already been added to favorites
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon( //trailing is a widget to display after title, typically an icon
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved? Colors.red : null,
        ),
        onTap: () {
          setState(() { //when a tile has been tapped, the function calls setState() to notify the framework that the state has changed
                        //calling setState triggers a call to the build method for the State object, resulting in an update to the UI.
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      );
  }

  //The content for the new page is build in MaterialPageRoute's builder.
  void _pushSaved() {
    Navigator.of(context).push( //pushes the route to the Navigator's stack (means we change page). Popping from stack means we go back to previous page
      MaterialPageRoute<void>(   //No need to code the returning back. The arrow does it already.
        builder: (BuildContext context) {
          final tiles = _saved.map( //map returns an iterable. this is used as a constructor.
            (WordPair pair) {
              return ListTile( //how does this iterate?
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },  
          );
          final divided = ListTile.divideTiles( //this methods adds horizontal spacing between each Tile. The divided variable holds the final rows converted to a list
            context: context,                    //this will act on the ListTiles created above.
            tiles: tiles,
          ).toList();

          return Scaffold( //the builder property returns a Scaffold containing the app bar for the new route named "Saved Suggestions"
            appBar: AppBar(
              title: Text('Saved Suggestions'),
              ),
              body: ListView(children: divided), //A list view automatically scrolls if its content is too long to fit the space available
            );
        },
      )
    
    
    );
  }

  //The scaffold widget provides a default app bar, and a body property that holds the widget tree for the home screen.
  Widget build(BuildContext context) {
    return Scaffold( //means it will hold the widget tree for the whole screen.
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),//some widget take a single child widget, and others such as action, take an array of children []
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}