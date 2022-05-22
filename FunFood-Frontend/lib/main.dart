import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart' as d;
import 'package:fun_food/presentation/register/splash_screen.dart';
import 'classes/user.dart';

AudioCache? musicCache;
AudioPlayer instance = AudioPlayer();
void playLoopedMusic() async {
  musicCache = AudioCache(prefix: "assets/");

  try {
    instance.dispose();
    instance = await musicCache!.loop("main.mp3");
  } catch (e) {
    
  }
  print(instance.state);
}

Future<void> pauseMusic() async {
  try{
print(instance.mode);
  await instance.pause();
  }catch(e){

  }
  
}

Future<void> resumeMusic() async {
  try{
print(instance.mode);
  await instance.resume();
  }catch(e){
    
  }
}

User? user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.green.withOpacity(0.6), // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fun Food',
      theme: ThemeData(
        primarySwatch: null,
        primaryColor: Colors.green.withOpacity(0.8),
      ),
      home: const SplashScreen(),
    );
  }
}
