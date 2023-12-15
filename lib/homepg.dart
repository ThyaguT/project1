import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:machinetest/Category_modal.dart';

import 'Slider_modal.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<SliderModal> getData() async {
    Response response = await get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=b"));
    if (response.statusCode == 200) {
      var body = SliderModal.fromJson(jsonDecode(response.body));
      return body;
    } else {
      return throw "";
    }
  }
  Future<CategoryModal> getcat() async {
    Response response = await get(
        Uri.parse("http://www.themealdb.com/api/json/v1/1/categories.php"));
    if (response.statusCode == 200) {
      var body = CategoryModal.fromJson(jsonDecode(response.body));
      return body;
    } else {
      return throw "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.account_circle_sharp,color: Colors.white,),
          title: Text("FoodCourt",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.black,
          actions: [Icon(Icons.account_balance_outlined,color: Colors.white,)],
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                "Today's Meal",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<SliderModal>(
                future: getData(),
                builder: (BuildContext context,
                    AsyncSnapshot<SliderModal> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightGreen,
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    List<Meals>? mealsList = snapshot.data!.meals;
                    return CarouselSlider.builder(
                        itemCount: 6,
                        itemBuilder: (context, index, realindex) {
                          return Card(
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              mealsList![index].strMealThumb!),fit: BoxFit.fitWidth)),
                                ),
                                Text(mealsList![index].strMeal!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(autoPlay: true));
                  } else {
                    return const Center(
                      child: Text('Something Went Wrong'),
                    );
                  }
                }),
            Text("Popular Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: MediaQuery.of(context).size.height,
              child: FutureBuilder<CategoryModal>(
                  future: getcat(),
                  builder: (context, AsyncSnapshot<CategoryModal> snapshot) {
                    return GridView.builder(
                        itemCount:14,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context,index){
                          if(snapshot.hasData){
                            List<Categories>? categories = snapshot.data!.categories;
                            return Card(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                categories![index].strCategoryThumb!),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                  Text(
                                    categories![index].strCategory!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                                  )
                                ],
                              ),
                            );
                          }else {
                            return const Center(
                              child: Text('Something Went Wrong'),
                            );
                          }
                        });
                  }),
            )


          ],
        ),);
  }
}
