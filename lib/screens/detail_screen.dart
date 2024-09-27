// screens/detail_screen.dart
import 'package:famous_project/models/famous_model.dart';
import 'package:flutter/material.dart';
import '../models/person_detail.dart';
import '../services/api_service.dart';
import 'image_view_screen.dart';

class DetailScreen extends StatefulWidget {
  final FamousPerson person;

  DetailScreen({required this.person});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<PersonDetail> _personDetail;
  late Future<List<String>> _personImages;

  @override
  void initState() {
    super.initState();
    _personDetail = ApiService.getPersonDetail(widget.person.id);
    _personImages = ApiService.getPersonImages(widget.person.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.person.profilePath.isNotEmpty
                ? Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.person.profilePath}',
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/no_image.png'),
            SizedBox(height: 16),
            FutureBuilder<PersonDetail>(
              future: _personDetail,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No details found.'));
                }

                final detail = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Born: ${detail.birthday}'),
                    Text('Place of Birth: ${detail.placeOfBirth}'),
                    SizedBox(height: 16),
                    Text(detail.biography),
                    SizedBox(height: 16),
                    Text(
                      'Images',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _buildImageList(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageList() {
    return FutureBuilder<List<String>>(
      future: _personImages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No images found.'));
        }

        final images = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final image = images[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewScreen(
                        imageUrl: 'https://image.tmdb.org/t/p/original$image'),
                  ),
                );
              },
              child: Image.network(
                'https://image.tmdb.org/t/p/w500$image',
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
