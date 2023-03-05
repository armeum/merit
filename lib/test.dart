import 'package:shared_preferences/shared_preferences.dart';



addStringToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('stringValue', "abc");
}

addIntToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue', 123);
}

addDoubleToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('doubleValue', 115.0);
}

addBoolToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('boolValue', true);
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? stringValue = prefs.getString('stringValue');
  return stringValue;
}
getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool('boolValue');
  return boolValue;
}
getIntValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int? intValue = prefs.getInt('intValue');
  return intValue;
}
getDoubleValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return double
  double? doubleValue = prefs.getDouble('doubleValue');
  return doubleValue;
}

// int intValue= await prefs.getInt('intValue') ?? 0;
removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove("stringValue");
  //Remove bool
  prefs.remove("boolValue");
  //Remove int
  prefs.remove("intValue");
  //Remove double
  prefs.remove("doubleValue");
}
