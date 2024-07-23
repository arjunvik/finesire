import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReaderStats(),
    );
  }
}

class ReaderStats extends StatefulWidget {
  @override
  _ReaderStatsState createState() => _ReaderStatsState();
}

class _ReaderStatsState extends State<ReaderStats> {
  int progressNumber = 543;
  bool isLoading = false;

  Future<void> fetchProgressNumber() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://www.randomnumberapi.com/api/v1.0/random?min=100&max=1000&count=1'));

    if (response.statusCode == 200) {
      setState(() {
        progressNumber = json.decode(response.body)[0];
        isLoading = false;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load progress number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amy's reader stats",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://example.com/avatar.jpg'), // Replace with actual URL
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'War and Peace',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    StatCard(
                      title: 'PROGRESS',
                      value: isLoading ? 'Loading...' : '$progressNumber',
                      subtitle: 'Out of 1,225 pages\n#5 among friends',
                      color: Colors.yellow,
                      icon: Icons.book,
                    ),
                    StatCard(
                      title: 'TIME',
                      value: '6:24',
                      subtitle: 'Global avg. read time for your progress 7:28\n23% faster',
                      color: Colors.orange,
                      icon: Icons.timer,
                    ),
                    StatCard(
                      title: 'STREAK',
                      value: '7',
                      subtitle: 'Day streak, come back tomorrow to keep it up!\n19% more consistent',
                      color: Colors.green,
                      icon: Icons.stacked_bar_chart,
                    ),
                    StatCard(
                      title: 'LEVEL',
                      value: '2',
                      subtitle: '145 reader points to level up!\nTop 5% for this book',
                      color: Colors.purple,
                      icon: Icons.star,
                    ),
                    StatCard(
                      title: 'Badges',
                      value: '',
                      subtitle: '',
                      color: Colors.lightBlue,
                      icon: Icons.badge,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: fetchProgressNumber,
                child: Text('Fetch Random Progress Number'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Add friends'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
