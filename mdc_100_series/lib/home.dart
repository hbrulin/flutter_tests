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
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  // Make a collection of cards (102)
  //List<Card> _buildGridCards(int count) {
    //List<Card> cards = List.generate(
      //count,
        //(int index) => Card(
          //clipBehavior: Clip.antiAlias,
          //child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            //children: [
              //AspectRatio( //decides what shape the image takes no matter what kinf of image is supplied
                //aspectRatio: 18.0 / 11.0,
                //child: Image.asset('assets/diamond.png'),
              //),
              //Padding(
                //padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                //child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //children: [
                    //Text('Title'),
                    //SizedBox(height: 8.0), //empty space btw two text widgets
                    //Text('Secondary Text'),
                  //],
                //),
              //),
            //],
          //),
        //),
      //);
    //return cards;
  //}

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        //TODO: Adjust Card heights(103)
        child: Column(
          //TODO: Center items on the card(103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                //Adjust the box size
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  //TODO: Align labels to the bottom and center(103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //TODO: Change innermost column(103)
                  children: [
                    //TODO: Handle overflowing labels(103)
                    Text(
                      product.name,
                      style: theme.textTheme.headline6, //style the text
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.subtitle2,
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
    // TODO: Add a variable for Category (104)

  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      // Add app bar (102)
      appBar: AppBar(
        title: Text('SHRINE'),
        leading: IconButton( //leading: before title
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu', //for people who use screen readers
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        //add trailing buttons, called actions
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      // Add a grid view (102)
      body: GridView.count( //by default grudview makes tiles that are all the same size
        crossAxisCount: 2, //means we want two column, because gridview has a vertical main axis
        padding: EdgeInsets.all(16.0), //space on all 4 sides of the gridview
        childAspectRatio: 8.0 / 9.0, //identifies the size of children items based an a ratio of width over height
        //build a grid of cards
        children: _buildGridCards(context)
      ),
      // Set resizeToAvoidBottomInset so that te keyboard's appearance does not alter the size of the home page or its widgets
      resizeToAvoidBottomInset: false,
    );
  }
}
