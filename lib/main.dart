import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:rent_calculator_app/models/monthRent.dart';
import 'package:flutter/material.dart';
import 'package:rent_calculator_app/ui/CustomInputForm.dart';
import 'package:rent_calculator_app/ui/DataChartUI.dart';
import 'package:rent_calculator_app/utils/database_helper.dart';
import 'package:rent_calculator_app/widgets/custom_drawer.dart';

List _datas;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = new DatabaseHelper();

  // print('$_datas');
  //Add user
  // await db.saveRentData(
  //     new MonthData("Baisakh", "13000", "60", "12", "200", "150", "15000"));

  // int count = await db.getCount();
  // print("Count: $count");

  // //Retrieving a user
  // MonthData ana = await db.getMonth(1);
  // MonthData anaUpdated = MonthData.fromMap({
  //   "monthName": "UpdatedAna",
  //   "password": "updatedtotalMonthPrice",
  //   "id": 1
  // });

  // //Update
  // await db.updateRentMonth(anaUpdated);

  // //Delete a Data
  // int userDeleted = await db.deleteRentMonth(2);
  // print("Delete User:  $userDeleted");

  //Get all users;
  _datas = await db.getAllRentData();
  for (int i = 0; i < _datas.length; i++) {
    MonthData mthdata = MonthData.map(_datas[i]);
    print("Month: ${mthdata.monthName}, Total: ${mthdata.totalAmount}");
  }

  runApp(new MaterialApp(
    title: "Rent Management",
    home: new Home(),
  ));
}
// void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Rent Management"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: CustomDrawer(),
      body: Builder(
        // builder is used only for the snackbar, if you don't want the snackbar you can remove
        // Builder from the tree
        builder: (BuildContext context) => HawkFabMenu(
          icon: AnimatedIcons.list_view,
          fabColor: Colors.blue,
          iconColor: Colors.white,
          items: [
            HawkFabMenuItem(
              label: 'Add Monthly Rent',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomInputForm()),
                );
                // Scaffold.of(context)..hideCurrentSnackBar();
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('Menu 1 selected')),
                // );
              },
              icon: Icon(Icons.pie_chart),
              color: Colors.red,
              labelColor: Colors.blue,
            ),
            HawkFabMenuItem(
              label: 'Monthly Chart',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataChartUI()),
                );
                // Scaffold.of(context)..hideCurrentSnackBar();
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text('Menu 2 selected')),
                // );
              },
              icon: Icon(Icons.comment),
              labelColor: Colors.white,
              labelBackgroundColor: Colors.blue,
            ),
            HawkFabMenuItem(
              label: 'Menu 3 (default)',
              ontap: () {
                Scaffold.of(context)..hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Menu 3 selected')),
                );
              },
              icon: Icon(Icons.add_a_photo),
            ),
          ],
          body: new ListView.builder(
              itemCount: _datas.length,
              itemBuilder: (_, int position) {
                return new Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: new ListTile(
                    leading: new CircleAvatar(
                      child: Text(
                          "${MonthData.fromMap(_datas[position]).monthName.substring(0, 1)}"),
                    ),
                    title: new Text(
                        "Month: ${MonthData.fromMap(_datas[position]).monthName}"),
                    subtitle: new Text(
                        "Total: ${MonthData.fromMap(_datas[position]).totalAmount}"),
                    onTap: () => debugPrint(
                        "${MonthData.fromMap(_datas[position]).totalMonthPrice}"),
                  ),
                );
              }),
          // body: FirebaseAnimatedList(
          //   query: databaseReference,
          //   itemBuilder: (_, DataSnapshot snapshot,
          //       Animation<double> animation, int index) {
          //     return new Card(
          //       child: ListTile(
          //         leading: CircleAvatar(backgroundColor: Colors.red),
          //         title: Text(monthDatas[index].monthName),
          //         subtitle: Text(monthDatas[index].totalAmount),
          //       ),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
