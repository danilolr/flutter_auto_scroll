import 'package:flutter_web/material.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automatic Scroll Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: MainAreaWidget(), flex: 5),
                Expanded(
                  child: NewsWidget(),
                  flex: 1,
                )
              ],
            ),
            flex: 5,
          ),
          Expanded(
            child: EventsListWidget(),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class EventsListWidget extends StatefulWidget {
  @override
  _EventsListWidgetState createState() => _EventsListWidgetState();
}

class _EventsListWidgetState extends State<EventsListWidget> {
  final ScrollController _scrollController = new ScrollController();

  double q = 0;

  initState() {
    super.initState();
    Observable.periodic(Duration(milliseconds: 100)).listen((val) {
      print(val);
      q = q + 10;
      _scrollController.animateTo(
        q,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 99),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final i = index % 10;
          return SizedBox(
            width: 200,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: Text("Event ${i + 1}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      final i = index % 30;
      return SizedBox(
        width: 200,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Center(
              child: Text("News $i"),
            ),
          ),
        ),
      );
    });
  }
}

class MainAreaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
