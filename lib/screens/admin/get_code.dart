import 'package:shared_preferences/shared_preferences.dart';

Future<String> getSecretCode() async {
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? secretCode = prefs.getString('secret_code');
  
  
  return secretCode ?? '';
}