import 'package:flutter/material.dart';
import '../model/kategori_model.dart';
import '../services/api_data_source.dart';
import 'meals_page.dart';

class CategoriesPage extends StatelessWidget {
  final ApiDataSource apiDataSource = ApiDataSource.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meals Categories"),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiDataSource.loadCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            CategoriesModel categoriesModel = CategoriesModel.fromJson(snapshot.data!);
            List<Data>? categories = categoriesModel.data;
            return ListView.builder(
              itemCount: categories?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealsPage(
                          categoryId: categories![index].idCategory ?? '',
                          category: categories![index].strCategory ?? '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.network(
                            categories![index].strCategoryThumb ?? '',
                            height: MediaQuery.of(context).size.height/2.5,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              categories[index].strCategory ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              categories[index].strCategoryDescription ?? '',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          )
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
