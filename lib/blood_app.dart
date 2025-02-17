import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'profile_page.dart';
import 'post_page.dart';

class BloodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blood App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BloodAppHome(),
      ),
    );
  }
}

class BloodAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood App'),
        backgroundColor: Colors.red,
      ),
      body: IndexedStack(
        index: appState.selectedIndex,
        children: [
          
          HomePage(),
          SearchPage(),
          ProfilePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage()),
          );
        },
        child: Icon(Icons.add, size: 32, color: Colors.white),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.home,
                        color: appState.selectedIndex == 0
                            ? Colors.red
                            : Colors.grey),
                    onPressed: () => appState.updateIndex(0),
                  ),
                  IconButton(
                    icon: Icon(Icons.search,
                        color: appState.selectedIndex == 1
                            ? Colors.red
                            : Colors.grey),
                    onPressed: () => appState.updateIndex(1),
                  ),
                ],
              ),
              SizedBox(width: 40), // Space for Floating Action Button
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.sms,
                        color: appState.selectedIndex == 3
                            ? Colors.red
                            : Colors.grey),
                    onPressed: () => appState.updateIndex(3),
                  ),
                  IconButton(
                    icon: Icon(Icons.person,
                        color: appState.selectedIndex == 2
                            ? Colors.red
                            : Colors.grey),
                    onPressed: () => appState.updateIndex(2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
