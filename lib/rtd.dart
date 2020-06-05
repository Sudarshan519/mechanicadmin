import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FirebaseApp extends StatefulWidget {
  @override
  _FirebaseAppState createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  DatabaseReference itemRef;
  List<Item> items = List();
  Item item;
  @override
  void initState() {
    super.initState();
    item = Item(' ', '');
    final FirebaseDatabase database = FirebaseDatabase();
    itemRef = database.reference().child('items');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fb example')),
      body: Column(
        children: <Widget>[
          TextFormField(
            onChanged: (v) {
              item.title = v;
            },
          ),
          TextFormField(
            onChanged: (v) {
              item.body = v;
            },
          ),
          RaisedButton(
            onPressed: () {
              handleSubmit();
            },
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return ListTile(
                  leading: Icon(Icons.message),
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),
                  trailing: InkWell(
                      onTap: () {
                        itemRef.child(snapshot.key).remove();
                      },
                      child: Icon(Icons.delete)),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void handleSubmit() {
    itemRef.push().set(item.toJson());
  }

  void _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {
    setState(() {
      var old = items.singleWhere((element) {
        element.key = event.snapshot.key;
        return null;
      });
      setState(() {
        items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
      });
    });
  }
}

class Item {
  String key;
  String title;
  String body;
  Item(this.title, this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        body = snapshot.value['body'];

  toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
