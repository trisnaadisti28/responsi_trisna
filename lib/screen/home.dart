import 'package:flutter/material.dart';
import '../model/kategori_model.dart';
import '../services/api_data_source.dart';
import 'package:http/http.dart' as http;

import 'detail_meals.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meals Categories"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CategoriesModel kategoriModel =
            CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(kategoriModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CategoriesModel data) {
    return ListView.builder(
      itemCount: data.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(data.data![index]);
      },
    );
  }

  Widget _buildItemUsers(Data kategoriModel) {
    return InkWell(
      onTap: () {
        // Handle tap action
        // For example, navigate to the detail page
        // Navigator.push(
        //   context,
        //     MaterialPageRoute(
        //        builder: (context) => DetailPage(idCategory: kategoriModel.idCategory!),
        //     ),
        // );
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PageDetailUser(idUser: kategoriModel.id!),
        //   ),
        // );
      },
      child: Center(
      child: Card(
        elevation: 4, // Add elevation for a shadow effect
        margin: EdgeInsets.all(8), // Add margin for spacing between cards
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                  image: DecorationImage(
                    image: NetworkImage(kategoriModel.strCategoryThumb!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kategoriModel.strCategory!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Add more information or details if needed
                    // For example, you can add a description
                    Text(
                      kategoriModel.strCategoryDescription ?? '',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
