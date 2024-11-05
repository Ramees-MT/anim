/// Main function to run the Flutter app.
 import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mac-like Dock with Drag Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DockPage(),
    );
  }
}

/// A page that displays a dock similar to the Mac dock.
class DockPage extends StatefulWidget {
  @override
  _DockPageState createState() => _DockPageState();
}

class _DockPageState extends State<DockPage> {
  /// List of icons in the dock.
  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.settings,
    Icons.notifications,
    Icons.email,
  ];

  /// The index of the currently dragged icon, or null if no icon is being dragged.
  int? draggingIndex;

  /// The offset for the current drag operation.
  Offset dragOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(icons.length, (index) {
              return buildDockIcon(index);
            }),
          ),
        ),
      ),
    );
  }

  /// Builds an individual icon in the dock.
  Widget buildDockIcon(int index) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          draggingIndex = index;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          dragOffset += details.delta;
        });
      },
      onPanEnd: (details) {
        setState(() {
          // Animate the icon back to its slot
          draggingIndex = null;
          dragOffset = Offset.zero;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          draggingIndex == index ? dragOffset.dx : 0,
          draggingIndex == index ? dragOffset.dy : 0,
          0,
        ),
        child: Icon(
          icons[index],
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
