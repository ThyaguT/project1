import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:machinetest/single_pg.dart';

import 'Category_modal.dart';
import 'Slider_modal.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,title: Text("Menu",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height,
            child: FutureBuilder<SliderModal>(
                future: getData(),
                builder: (context, AsyncSnapshot<SliderModal> snapshot) {
                  return GridView.builder(
                      itemCount:14,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context,index){
                        if(snapshot.hasData){
                          Meals meals=snapshot.data!.meals![index];
                          return InkWell(onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodSingle(meal: meals,)));
                          },
                            child: Card(
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
                                                meals.strMealThumb!),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                  Text(
                                    meals.strCategory!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15,color:Colors.white),
                                  )
                                ],
                              ),
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
      ),
    );
  }
}
