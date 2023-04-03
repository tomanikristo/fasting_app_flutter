import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/fast.dart';
import '../providers/fast_provider.dart';

class NewFastTab extends StatefulWidget {
  static const routeName = '/new-fast';
  final Function addTx;

  NewFastTab(this.addTx);
  @override
  _NewFastState createState() {
    return _NewFastState();
  }
}

class _NewFastState extends State<NewFastTab> {
  final _newFastFocus = FocusNode();

  TimeOfDay _selectedTime;
  final _submitFast = GlobalKey<FormState>();
  var _editedFast = Fast(
    id: null,
    title: '',
    time: null,
    fastStartTime: null,
  );
  var _isLoading = false;
  void dispose() {
    _newFastFocus.dispose();
    super.dispose();
  }

  void _submitData() {
    _submitFast.currentState.save();
    setState(() {
      _isLoading = true;
    });
    Provider.of<FastProvider>(context, listen: false)
        .addFast(_editedFast)
        .catchError((error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Something went horibly wrong'),
          content: Text(error.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }).then((_) {
      _isLoading = true;
      Navigator.pop(context);
    });
    print(_editedFast.title);
    print(_editedFast.time);
    print(_editedFast.fastStartTime);
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
      });
      print(_selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Form(
                  key: _submitFast,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Fast Name'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_newFastFocus);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _editedFast = Fast(
                            title: newValue,
                            time: _editedFast.time,
                            fastStartTime: _editedFast.fastStartTime,
                            id: null,
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Hours Fasting'),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        focusNode: _newFastFocus,
                        onSaved: (value) {
                          _editedFast = Fast(
                            title: _editedFast.title,
                            time: int.parse(value),
                            fastStartTime: _selectedTime,
                            id: null,
                          );
                        },
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _selectedTime == null
                                    ? 'No Time Chosen'
                                    : _selectedTime.format(context),
                              ),
                            ),
                            FlatButton(
                              textColor: Colors.black,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Choose Start Time',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: _presentTimePicker,
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text('Add Fast'),
                        textColor: Colors.black,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _submitData();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
