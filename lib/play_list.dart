import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> destinations = [];

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  void fetchPlaces() async {
    final response = await http.get(Uri.parse('https://yourapi.com/api/getAllPlace'));
    if (response.statusCode == 200) {
      setState(() {
        destinations = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load places');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Popular Destinations")),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(destinations[index]['name']),
          );
        },
      ),
    );
  }
}
