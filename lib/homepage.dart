import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> places = []; // Danh sách điểm đến

  @override
  void initState() {
    super.initState();
    fetchPlaces(); // Gọi API để tải dữ liệu
  }

  // Hàm gọi API để lấy danh sách điểm đến
  Future<void> fetchPlaces() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/places/getAllPlace'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        places = data;
      });
    } else {
      throw Exception('Failed to load places');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi Guy!'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your destination',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Hotels'),
                _buildCategoryButton('Flights'),
                _buildCategoryButton('All'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Popular Destinations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildPlaceGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(title),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }

  Widget _buildPlaceGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return _buildPlaceItem(places[index]);
      },
    );
  }

  Widget _buildPlaceItem(Map<String, dynamic> place) {
    return Card(
      child: Column(
        children: [
          Image.network(place['image'], fit: BoxFit.cover), // Lấy ảnh từ API
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              place['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Text('Rating: ${place['rating']}'),
        ],
      ),
    );
  }
}
