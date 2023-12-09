import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/details_model.dart';
import '../services/api_data_source.dart';

class DetailMealPage extends StatelessWidget {
  final String mealId;
  final ApiDataSource apiDataSource = ApiDataSource.instance;

  DetailMealPage({required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Details'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiDataSource.loadDetails(int.parse(mealId)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            DetailsModel detailsModel = DetailsModel.fromJson(snapshot.data!);
            Meals meal = detailsModel.meals![0];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    meal.strMealThumb ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      meal.strMeal ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      meal.strInstructions ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  FloatingActionButton.extended(
                    onPressed: () {
                      _launchYouTube(meal.strYoutube ?? '');
                    },
                    icon: Icon(Icons.play_arrow),
                    label: Text('Watch Tutorial'),
                    backgroundColor: Colors.brown,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _launchYouTube(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
