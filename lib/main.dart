import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/provider/auth.dart';
import 'package:login_app/widget/nav-drawer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_)=>Auth(),
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final storage = const FlutterSecureStorage();

  void _attemptAuthentication() async
  {
    final key = await storage.read(key: 'auth');
    Provider.of<Auth>(context,listen:false).attempt(key!);
  }

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    _attemptAuthentication();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<Auth>(
          builder:
              (context,auth,child){
                if(auth.authenticated)
                {
                  return const Text('You are Login');
                }
                else{
                  return const Text('You are not login');
                }
              }
        ),
      ),
    );
  }
}
