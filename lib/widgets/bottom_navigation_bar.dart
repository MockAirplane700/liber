import 'package:flutter/material.dart';
import 'package:liber/pages/favourites.dart';
import 'package:liber/pages/home.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Favourites()

  ];

  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));

    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Favourites()));
    }
  }
  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.selectedIndex;
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: 'Saved sites'
          ),
        ],
      currentIndex: _selectedIndex,
      onTap: _itemTapped,
      selectedItemColor: Colors.black,
    );
  }
}
