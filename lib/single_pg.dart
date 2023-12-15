import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Slider_modal.dart';


class FoodSingle extends StatelessWidget {
  const FoodSingle({super.key,required this.meal});
  final Meals meal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 42,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(meal.strMealThumb!),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(meal.strMeal!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(
                height: 10,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: Text(meal.strInstructions!))
            ],
          ),
        ),
      ),
    );
  }
}