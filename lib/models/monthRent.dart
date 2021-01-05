import 'package:firebase_database/firebase_database.dart';

class MonthData {
  String _monthName;
  String _totalMonthPrice;
  // String _rentvalue;
  String _totalUnitValue;
  String _perTotalUnitValue;
  String _wasteValue;
  String _waterValue;
  String _totalAmount;
  int _id;
  String key;

  MonthData(
      this._monthName,
      this._totalMonthPrice,
      this._totalUnitValue,
      this._perTotalUnitValue,
      this._wasteValue,
      this._waterValue,
      this._totalAmount);
  MonthData.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        _monthName = snapshot.value("_monthName"),
        _totalMonthPrice = snapshot.value("_totalMonthPrice"),
        _totalUnitValue = snapshot.value("_totalUnitValue"),
        _perTotalUnitValue = snapshot.value("_perTotalUnitValue"),
        _wasteValue = snapshot.value("_wasteValue"),
        _waterValue = snapshot.value("_waterValue"),
        _totalAmount = snapshot.value("_totalAmount");
  toJson() {
    return {
      "monthName": _monthName,
      "totalMonthPrice": _totalMonthPrice,
      "totalUnitValue": _totalUnitValue,
      "perTotalUnitValue": _perTotalUnitValue,
      "wasteValue": _wasteValue,
      "waterValue": _waterValue,
      "totalAmount": _totalAmount
    };
  }

  MonthData.map(dynamic obj) {
    this._monthName = obj['monthName'];
    this._totalMonthPrice = obj['totalMonthPrice'];
    this._totalUnitValue = obj['totalUnitValue'];
    this._perTotalUnitValue = obj['perTotalUnitValue'];
    this._wasteValue = obj['wasteValue'];
    this._waterValue = obj['waterValue'];
    this._totalAmount = obj['totalAmount'];
    this._id = obj['id'];
  }

  String get monthName => _monthName;
  String get totalMonthPrice => _totalMonthPrice;
  String get totalUnitValue => _totalUnitValue;
  String get perTotaUnitValue => _perTotalUnitValue;
  String get wasteValue => _wasteValue;
  String get waterValue => _waterValue;
  String get totalAmount => _totalAmount;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["monthName"] = _monthName;
    map["totalMonthPrice"] = _totalMonthPrice;
    map["totalUnitValue"] = _totalUnitValue;
    map["perTotalUnitValue"] = _perTotalUnitValue;
    map["wasteValue"] = _wasteValue;
    map["waterValue"] = _waterValue;
    map["totalAmount"] = _totalAmount;

    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }

  MonthData.fromMap(Map<String, dynamic> map) {
    this._monthName = map["monthName"];
    this._totalMonthPrice = map["totalMonthPrice"];
    this._totalUnitValue = map["totalUnitValue"];
    this._perTotalUnitValue = map["perTotalUnitValue"];
    this._wasteValue = map["wasteValue"];
    this._waterValue = map["waterValue"];
    this._totalAmount = map["totalAmount"];
    this._id = map["id"];
  }
}
