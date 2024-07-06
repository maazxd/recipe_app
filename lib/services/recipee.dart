// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';

class Recipepage extends StatelessWidget {
  final Recipe recipe;
  Recipepage({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text("recipebook"),
      ),
      body: _buildUI(
        context,
      ),
    );
  }

  Widget _buildUI(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipedetails(context),
          _recipeing(context),
          _recipeinstr(context),
        ],
      ),
    );
  }

  Widget _recipeImage(
    BuildContext context,
  ) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(recipe.image))),
    );
  }

  Widget _recipedetails(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${recipe.cuisine},${recipe.difficulty}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Text(
            recipe.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            " Prep Time ${recipe.prepTimeMinutes} Minutes | Cooking Time ${recipe.cookTimeMinutes}  Minutes",
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
          ),
          Text(
            "${recipe.rating.toString()} ⭐ | ${recipe.reviewCount} reviews",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _recipeing(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        children: recipe.ingredients.map((i) {
          return Row(
            children: [
              const Icon(
                Icons.check_box,
              ),
              Text(" $i"),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _recipeinstr(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recipe.instructions.map(
          (i) {
            return Text(
              "${recipe.instructions.indexOf(i)}. |$i\n",
              maxLines: 3,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15.0),
            );
          },
        ).toList(),
      ),
    );
  }
}
