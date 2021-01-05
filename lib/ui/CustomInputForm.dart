import 'package:flutter/material.dart';
import 'package:rent_calculator_app/models/monthRent.dart';
import 'package:rent_calculator_app/utils/database_helper.dart';
import 'package:firebase_database/firebase_database.dart';

// final FirebaseDatabase database = FirebaseDatabase.instance;

class CustomInputForm extends StatefulWidget {
  @override
  _CustomInputFormState createState() => _CustomInputFormState();
}

//class Data
class _RentData {
  String monthname = "";
  String rentvalue = "";
  String totalunitvalue = "";
  String pertotalunitvalue = "";
  String wastevalue = "";
  String totalamount = "";
  String watervalue = "";
}

class _CustomInputFormState extends State<CustomInputForm> {
  final _formKey = GlobalKey<FormState>();
  _RentData _data = new _RentData();
  List<MonthData> monthDatas = List();
  MonthData monthD;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Rent Management:Input"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        //SingleChildScrollView added to scroll to eliminate eg. like bottom by 12 pixels....
        child: Form(
          key: _formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //add image
              Center(
                child: Image.asset(
                  "images/face.png",
                  width: 150,
                  height: 150,
                  // color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Month Name",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3),
                    ),
                  ),
                  // keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter month name";
                    } else {
                      _data.monthname = value;
                      print("Data: ${_data.monthname}");
                    }
                  },
                  // validator: (value) => value.isEmpty
                  //     ? 'Please enter your name'
                  //     : 'All things are good',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Monthly Rent Value",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter monthly value";
                    } else {
                      _data.rentvalue = value;
                      print("Data: ${_data.rentvalue}");
                    }
                  },
                  // validator: (value) => value.isEmpty
                  //     ? 'Please enter your name'
                  //     : 'All things are good',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  //obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Electricity Total Unit",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter unit value";
                    } else {
                      _data.totalunitvalue = value;
                      print("Data: ${_data.totalunitvalue}");
                    }
                  },
                  // validator: (value) => value.isEmpty
                  //     ? 'Please enter your Password'
                  //     : 'All things are good',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  //obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Electricity Price Per Unit",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter per unit value";
                    } else {
                      _data.pertotalunitvalue = value;
                      print("Data: ${_data.pertotalunitvalue}");
                    }
                  },
                  // validator: (value) => value.isEmpty
                  //     ? 'Please enter your Password'
                  //     : 'All things are good',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  //obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Waste Management Value",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter waste value";
                    } else {
                      _data.wastevalue = value;
                      print("Data: ${_data.wastevalue}");
                    }
                  },
                  // validator: (value) => value.isEmpty
                  //     ? 'Please enter your Password'
                  //     : 'All things are good',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  //obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Water Amount Value",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(3.3),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter water amount value";
                    } else {
                      _data.watervalue = value;
                      print("Data: ${_data.watervalue}");
                    }
                  },
                  // validator: (value) => value.isEmpty
                  //     ? 'Please enter your Password'
                  //     : 'All things are good',
                ),
              ),
              //add buttons
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _data.monthname = _data.monthname;
                                _data.rentvalue = _data.rentvalue;
                                _data.pertotalunitvalue =
                                    _data.pertotalunitvalue;
                                _data.wastevalue = _data.wastevalue;
                                _data.watervalue = _data.watervalue;
                                _data.totalunitvalue = _data.totalunitvalue;
                                int sum = int.parse(_data.rentvalue) +
                                    int.parse(_data.pertotalunitvalue) *
                                        int.parse(_data.totalunitvalue) +
                                    int.parse(_data.wastevalue) +
                                    int.parse(_data.watervalue);
                                _data.totalamount = sum.toString();
                              });
                              var db = new DatabaseHelper();
                              await db.saveRentData(new MonthData(
                                  _data.monthname,
                                  _data.rentvalue,
                                  _data.totalunitvalue,
                                  _data.pertotalunitvalue,
                                  _data.wastevalue,
                                  _data.watervalue,
                                  _data.totalamount));

                              //store in firebase
                              // database.reference().child("message").set({
                              //   "MonthName": _data.monthname,
                              //   "rentvalue": _data.rentvalue,
                              //   "totalunitvalue": _data.totalunitvalue,
                              //   "pertotalunitvalue": _data.pertotalunitvalue,
                              //   "wastevalue": _data.wastevalue,
                              //   "watervalue": _data.watervalue,
                              //   "totalamount": _data.totalamount
                              // });
                              //for group data addition as multiple row
                              // print("hell yeah");

                              monthD = MonthData(
                                  _data.monthname,
                                  _data.rentvalue,
                                  _data.totalunitvalue,
                                  _data.pertotalunitvalue,
                                  _data.wastevalue,
                                  _data.watervalue,
                                  _data.totalamount);
                              databaseReference =
                                  database.reference().child("Monthly Records");
                              databaseReference.onChildAdded
                                  .listen(_onEntryAdded);
                              // print("hell yeah");
                              // print("sande: $monthD");
                              databaseReference.push().set(monthD.toJson());

                              //read data from db firebase
                              // database
                              //     .reference()
                              //     .child("message")
                              //     .once()
                              //     .then((DataSnapshot snapshot) {
                              //   Map<dynamic, dynamic> data = snapshot.value;
                              //   print("Values from db: ${data.values}");
                              // });

                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text("All things good")));
                            }
                          },
                          child: Text("Calculate")),
                    ),
                    RaisedButton(
                        onPressed: () {
                          // if (_formKey.currentState.validate()) {
                          _formKey.currentState.reset();
                          setState(() {
                            _data.rentvalue = "";
                            _data.wastevalue = "";
                            _data.pertotalunitvalue = "";
                            _data.totalunitvalue = "";
                            _data.watervalue = "";
                          });
                          // }
                        },
                        child: Text("Clear All")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: _data.rentvalue.isEmpty ||
                            _data.pertotalunitvalue.isEmpty ||
                            _data.totalunitvalue.isEmpty ||
                            _data.wastevalue.isEmpty ||
                            _data.watervalue.isEmpty
                        ? Text("")
                        : Text(
                            "Total ${_data.totalamount}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEntryAdded(Event event) {
    print(event.snapshot);
    setState(() {
      monthDatas.add(MonthData.fromSnapshot(event.snapshot));
    });
  }
}
