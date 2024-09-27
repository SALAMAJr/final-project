import 'package:famous_project/models/famous_model.dart';
import 'package:famous_project/provider/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FamousPerson>> _famousPersons;

  @override
  void initState() {
    super.initState();
    _famousPersons = ApiService.getPopularPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famous Persons'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<FamousPerson>>(
        future: _famousPersons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          }
          final persons = snapshot.data!;
          final favoritesProvider = Provider.of<FavoritesProvider>(context);

          return ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, index) {
              final person = persons[index];
              final isFavorite = favoritesProvider.isFavorite(person);

              return ListTile(
                leading: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                title: Text(person.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(person: person),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    favoritesProvider.toggleFavorite(person);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
