import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


//This project is composed of both Codelab parts 1 & 2
//Nawal Husain Alhamwi


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random(); deleted since it's initialized in the State class
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
//      home: new Scaffold(
//          appBar: new AppBar(
//            title: new Text('Welcome to Flutter'),
//          ),
//          body: new Center(
//            //it works even if there was no "new" keyword because logically it's the same i believe
//            //as well as it will produce the same product i.e. randomized values
//           // child: new Text(wordPair.asPascalCase), deleted since it's mentioned in the State class
//            child: new RandomWords(),
//          )),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  //mentioned by Mr. Ahmed Abu Eldahab that this is a generic.
  //this is the State Class.. Specialized class that will inherit
  //the characteristics of its Parent Class (in Flutter's context it's a widget)
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles= _saved.map(
              (WordPair pair) {
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
          );
          final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
  final List<WordPair> _suggestions =
      <WordPair>[]; //note this is a private variable! _varName
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved =
      new Set<WordPair>(); //better using Set to not allow duplicated of data
  @override
  Widget build(BuildContext context) {
//    final WordPair wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);      replaced with a scaffold

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
          pair.asPascalCase,
          style: _biggerFont),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState (() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
          });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
