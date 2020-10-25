import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(
    //the runApp function takes a Widget as argument, which Flutter expands and displays to the screen at run time
    FriendlyChatApp(), //Simplifying the main() method enables hot reload becausehot reload doesn't rerun main(). That's why we call FrendlyChatApp
  );
}

//specifies colors for IOS
final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

//for android
final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

String _name = 'Helene';

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //root of app's widget tree, as it is in the build context of the FrendlyChatApp that is the arg of RunApp in
      title: 'FriendlyChat',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.text,
      this.animationController}); //This is a constructor for a chat message
  final String text; //this is a text variable
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      //The CurvedAnimation object, in conjunction with the SizeTransition class, produces an ease out animation effect
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment
                .start, //since it is a row, cross axis is vertical, so start is up
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                    child: Text(_name[
                        0])), //the avatar is personaloized by adding first letter of name
              ),
              //next to the avatar, two texts widgets vertocally aligned with a column
              Expanded(
                //The Expanded widget allows its child widget (like Column) to impose layout constraints (in this case the Column's width) on a child widget. Here, it constrains the width of the Text widget, which is normally determined by its contents. Therefore the message is not truncated and displayed on several lines.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //cross axis is horizontal, so this goes on the left
                  children: [
                    Text(_name, style: Theme.of(context).textTheme.headline4),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(text), //variable text of the chat message
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

//convert from stateless to stateful with refactor
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  //A mixin allows a class to be used in multiple class hierarchies
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isComposing = false;
  final FocusNode _focusNode = FocusNode();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        //the animation controller is attached to chat message, and specifies that the animation should play when a message is added
        duration: const Duration(milliseconds: 700),
        vsync:
            this, //vsync is the ticker that drives the animation formward. Here we ChatScreenState as vsync, that's why we have to add a TickerProvider in class definition above
      ),
    ); //using constructor for chat message
    setState(() {
      //lets the framework know that this part of the widget tree changed, and thereis a need to rebuild the UI.
      _messages.insert(0, message); //why 0
    });
    _focusNode
        .requestFocus(); //request focus on the Textfield below (it has the focusNode property)
    //It means that when I type something and press enter, the textfield will still have the focus (curseur clignotant)
    message.animationController.forward(); //starts running application
  }

  Widget _buildTextComposer() {
    //this method returns a widget
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal:
              8.0), //The units passed to EdgeInsets.symmetric are logical pixels that get translated into a specific number of physical pixels, depending on a device's pixel ratio. You might be familiar with the equivalent term for Android (density-independent pixels) or for iOS (points).
      child: Row(
        children: [
          Flexible(
            //wrapping the texfield in a flexible tells the row to size the text firls to use the remaining space thatisn't used by the button
            child: TextField(
              controller: _textController,
              onChanged: (String text) {
                //this callback notifies the TextField that the user is editiing
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              onSubmitted: _isComposing
                  ? _handleSubmitted //diff avec ligne 143
                  : null,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              focusNode: _focusNode,
            ),
          ),
          IconTheme(
            data: IconThemeData(
                color: Theme.of(context)
                    .accentColor), //the sendbutton will gave the color of current theme
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      child: Text('Send'),
                      onPressed: _isComposing // NEW
                          ? () => _handleSubmitted(_textController.text) // NEW
                          : null,
                    )
                  : IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController
                              .text) //comment ça s'organise avec ligne 143?
                          : null), //.text is the content of msg
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS
            ? 0.0
            : 4.0, //elevation deals with shadows. Here we change according to OS
      ),
      body: Container(
          child: Column(
            children: [
              Flexible(
                //let the list of received messages expand to fill the column height while TextField remains a fixed size.
                child: ListView.builder(
                  //the builds a list on demand by providing a function that is called once per item in the list. The function returns a new widget at each call. It detects mutations and initiates rebuilds.
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[
                      index], //this provides the function that builds each widget. No context is passed because no need now (_ indicates arg won't be use)
                  itemCount: _messages.length,
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .cardColor), //defines background color of TextField
                child:
                    _buildTextComposer(), //it returns a widget that encapsulates the text input field
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]),
                  ),
                )
              : null),
    );
  }

//good practice to dispose of your animation controllers to free up your resources when they are no longer needed.
  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
