import 'package:flutter/material.dart';
import '../model/meals_model.dart';
import '../services/api_data_source.dart';
import 'detail_meals.dart';

class MealsPage extends StatelessWidget {
  final String category;
  final ApiDataSource apiDataSource = ApiDataSource.instance;

  MealsPage({required this.category, required String categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals - $category'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiDataSource.loadMeals(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            MealsModel mealsModel = MealsModel.fromJson(snapshot.data!);
            List<Meals>? meals = mealsModel.meals;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns in the grid
                crossAxisSpacing: 8.0, // Set the spacing between columns
                mainAxisSpacing: 8.0, // Set the spacing between rows
              ),
              itemCount: meals?.length ?? 0,
              itemBuilder: (context, index) {
                Meals meal = meals![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMealPage(mealId: meal.idMeal ?? ''),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          meal.strMealThumb ?? '',
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            meal.strMeal ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
