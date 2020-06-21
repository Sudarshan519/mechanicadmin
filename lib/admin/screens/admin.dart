import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mechanicadmin/admin/db/mechanic.dart';
import 'package:mechanicadmin/admin/db/shops.dart';
import 'package:mechanicadmin/services/authServices.dart';

import '../../signin.dart';

enum Page { dashboard, manage }

class AdminSite extends StatefulWidget {
  @override
  _AdminSiteState createState() => _AdminSiteState();
}

class _AdminSiteState extends State<AdminSite> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController shopController = TextEditingController();
  TextEditingController mechanicController = TextEditingController();
  final _categoryFormkey = GlobalKey<FormState>();
  final _brandFormkey = GlobalKey<FormState>();
  ShopService _shopService = ShopService();
  MechanicService _mechanicService = MechanicService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        title: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.dashboard;
                      });
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color:
                          _selectedPage == Page.dashboard ? active : notActive,
                    ),
                    label: Text('Dashboard'))),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedPage = Page.manage;
                      });
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedPage == Page.manage ? active : notActive,
                    ),
                    label: Text('Manage')))
          ],
        ),
        actions: <Widget>[],
      ),
      body: loadscreen(),
    );
  }

  void _shopAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormkey,
        child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Add shopt name',
            ),
            controller: shopController,
            validator: (v) {
              if (v.isEmpty) return 'Category cannot be empty';
              return '';
            }),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (_categoryFormkey.currentState.validate())
                _shopService.createShop(shopController.text);
              Fluttertoast.showToast(msg: 'mechanic added');
            },
            child: Text('Add')),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel'))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _mechanicAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormkey,
        child: TextFormField(
          validator: (v) {
            if (v.isEmpty) {
              return 'cannot be empty';
            }
            return '';
          },
          decoration: InputDecoration(hintText: 'Add mechanic'),
          controller: shopController,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (_brandFormkey.currentState.validate()) {
              _mechanicService.createShop(mechanicController.text);
              Fluttertoast.showToast(msg: 'mechanic added');
            }
          },
          child: Text("add"),
        ),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel'))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  Widget loadscreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.attach_money,
                    size: 30,
                    color: Colors.green,
                  ),
                  label: Text('12222')),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Expanded(
                child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text('Users'),
                        ),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60, color: Colors.red),
                        )),
                  ),
                ),
              ],
            ))
          ],
        );
      case Page.manage:
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add mechanic'),
              onTap: () {
                _mechanicAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add shop'),
              onTap: () => _shopAlert(),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('All shops'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add mechanic'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('All Mechanics'),
            ),
            Divider(),
            InkWell(
              onTap: (){
                AuthService().signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ));
              },
                          child: Column(
                children: <Widget>[
                  Icon(Icons.lock_open),
                  Text('Log out'),
                ],
              ),
            )
          ],
        );
    }
    return null;
  }
}
