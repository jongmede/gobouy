import 'package:flutter/material.dart';
import 'package:juan_pos/database/database_helper.dart';
import 'package:juan_pos/model/category.dart';
import 'package:juan_pos/util/util.dart';

class CategoryListPage extends StatefulWidget {

  const CategoryListPage();

  @override
  CategoryListState createState() => new CategoryListState();
}

class CategoryListState extends State<CategoryListPage> {

  DatabaseHelper _db = new DatabaseHelper();
  Future<List<Category>> _fetch;
  List<Category> _categories = List<Category>();

  @override
  void initState() {
    super.initState();
    _fetch = _fetchCategories();
  }

  void _addCategoryToList(Category category) {
    setState(() {
      _categories.add(category);
    });
  }

  Future<List<Category>> _fetchCategories() async {
    _categories = await _db.getCategories();
    return _categories;
  }

  void _getCategoryForm(BuildContext context, [ Category category ]) {
    Category _category = category != null ? Category.fromMap(category.toMap()) : Category();
    GlobalKey<FormState> _eventFormKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return StatefulBuilder(
            builder: (BuildContext dialogContext, StateSetter dialogSetState) {
              return AlertDialog(
                title: Text('Category'),
                content: Form(
                  key: _eventFormKey,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    initialValue: _category.categoryName,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return value.isEmpty ? '' : null;
                    },
                    onChanged: (value) {
                      _category.categoryName = value;
                    },
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('CLOSE'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(_category.categoryId != null ? 'UPDATE' : 'ADD'),
                    onPressed: () async {
                      Util.dismissKeyboard(context);

                      if (!_eventFormKey.currentState.validate())
                        return;

                      if (_category.categoryId != null) {
                        await _db.updateCategory(_category);
                        _updateCategoryToList(_category);
                      }
                      else {
                        int id = await _db.saveCategory(_category);
                        _category.categoryId = id;
                        _addCategoryToList(_category);
                      }

                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
    );
  }

  void _updateCategoryToList(Category category) {
    setState(() {
      int index  = _categories.indexWhere((_category) => _category.categoryId == category.categoryId);
      _categories[index] = category;
    });
  }

  Widget _getEmptyWidget() {
    return FlatButton(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
                Icons.library_books,
                size: 128
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('Add Category',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      onPressed: () {
        _getCategoryForm(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _fetch,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                List<Widget> categoryWidgets = List<Widget>();
                _categories.asMap().map((index, element) => MapEntry(index,
                    categoryWidgets.add(ListTile(
                      title: Text(_categories[index].categoryName ?? ''),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  content: Text('Delete ' + _categories[index].categoryName + '?'),
                                  actions: [
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        _db.deleteCategory(_categories[index]);
                                        setState(() {
                                          _categories.removeAt(index);
                                        });
                                        Navigator.of(dialogContext).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                      ),
                      onTap: () {
                        _getCategoryForm(context, _categories[index]);
                      },
                    ))
                ));

                return Scaffold(
                  appBar: AppBar(
                    title: Text('Categories'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          _getCategoryForm(context, );
                        },
                      ),
                    ],
                  ),
                  body: Center(
                    child: categoryWidgets.length == 0 ? _getEmptyWidget() : ListView(
                      children: categoryWidgets,
                    ),
                  ),
                );
              },
            );
        }
      }
    );
  }
}
