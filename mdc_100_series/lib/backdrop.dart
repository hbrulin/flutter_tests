import 'package:flutter/material.dart';
import 'package:meta/meta.dart'; //imported in order to mark the properties required.

import 'model/product.dart';

//Add velocity constant (104)
const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentCategory,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(currentCategory != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

//TODO Add _FrontLayer class
class _FrontLayer extends StatelessWidget {
  //TODO Add on-tap callback
  const _FrontLayer({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      //shape: BeveledRectangleBorder(
       // borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      //),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //TODO Add a GestureDetector
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}


//TODO Add _BackdropTitleclass
//TODO Add BackDropState class
class _BackdropState extends State<Backdrop>
  with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  //Add Animation Controller widget
  AnimationController _controller;

  //instantiation of the animation controller
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
        vsync: this,
    );
  }

  //TODO Add override for didUpdateWidget

  @override dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Add functions to get and change the front layer visibility
  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
      _controller.fling(
          velocity: _frontLayerVisible ? - _kFlingVelocity : _kFlingVelocity);
  }

  //Todo: Add buildcontext and boxcontraints parameters to buildStack
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    // TODO: Create a RelativeRectTween Animation (104)
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: [
        //Wrap backLayer in an ExcludeSemantics widget - will exclude the backlayer's menu from the semantics tree when the backlayer isn't visible
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation, //takes the animation
          child:
            _FrontLayer(child: widget.frontLayer),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      //TODO Replace leading menu icon with IconButton
      //TODO Remove leading property
      //TODO Create title with _BackdropTitle parameter
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      title: Text('SHRINE'),
      actions: [
        //TODO Add shortctur to login screen from trailing icons
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            //TODO: Add open login
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'filter',
          ),
          onPressed: () {
            //Add open login
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      //return a layoutbuilder widget that uses buildstack as its builder
      //LayoutBuilder is used when a widget must know its parent widget's size in order to lay itself out (and the parent size does not depend on the child.) LayoutBuilder takes a function that returns a Widget.
      body: LayoutBuilder(builder : _buildStack), //the body of the scaffold is a stack
    );
  }
}