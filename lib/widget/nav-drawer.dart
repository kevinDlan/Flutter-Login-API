import 'package:flutter/material.dart';
import 'package:login_app/provider/auth.dart';
import 'package:login_app/screens/posts-screen.dart';
import 'package:login_app/screens/login-screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(builder: (context, auth, child){
      if(auth.authenticated)
          {return ListView(
            children: <Widget>[
               ListTile(
                title: Text(auth.user?.name ?? 'UserName'),
                subtitle: const Text('Online'),
                leading: const Icon(Icons.person),
              ),
              ListTile(
                title: const Text('Post'),
                subtitle: const Text('add new post'),
                leading: const Icon(Icons.add_circle),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostScreen()));
                },
              ),
              ListTile(
                title: const Text('Logout'),
                subtitle: const Text('Login on App'),
                leading: const Icon(Icons.login),
                onTap: () {
                  Provider.of<Auth>(context,listen: false).logout();
                },
              ),
            ],
          );}else
          {return ListView(
          children: <Widget>[
            ListTile(
                title: const Text('Login'),
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }
            ),
            const ListTile(
              title: Text('Register'),
              leading: Icon(Icons.person),
            ),
          ],
        );}
    })
    );
  }
}
