import 'package:flutter/material.dart';
import 'package:backdrop_widget/backdrop.dart';
import 'model/products_repository.dart';
import 'model/product.dart';

class Products extends StatefulWidget{
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  int _currentIndex = 0;

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        //Adjust Card heights(103)
        elevation: 0.0, //shadows under cards
        child: Column(
          //Center items on the card(103)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                //Adjust the box size
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  //Align labels to the bottom and center(103)
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //Change innermost column(103)
                  children: [
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button, //style the text
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      product == null ? '' : "$product.rate",
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text('Produits'),
      iconPosition: BackdropIconPosition.leading,
      actions: [
        BackdropToggleButton(
          icon: AnimatedIcons.list_view,
        ),
      ],
      frontLayer: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context)
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