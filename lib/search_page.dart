import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  // Simulating search results
  List<Map<String, String>> searchResults = [
    {'name': 'John Doe', 'bloodType': 'A+', 'distance': '3.5 miles'},
    {'name': 'Jane Smith', 'bloodType': 'O-', 'distance': '1.2 miles'},
    {'name': 'Mike Johnson', 'bloodType': 'B-', 'distance': '2.8 miles'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for Donors', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Search for Blood Donors",
                  hintText: "Enter blood type, name, or location",
                  prefixIcon: Icon(Icons.search, color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onSubmitted: (String value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Searching for: $value')));
                  // Here you would implement actual search logic
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final result = searchResults[index];
                  return _buildResultCard(context, result);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, Map<String, String> result) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.red),
        title: Text(result['name'] ?? '',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Blood Type: ${result['bloodType'] ?? ''}'),
            Text('Distance: ${result['distance'] ?? ''}'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Implement navigation to donor's detail page or show more info
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Donor details accessed for ${result['name']}')));
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}