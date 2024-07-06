import 'package:flutter/material.dart';

import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/dataservices.dart';
import 'package:recipe_app/services/recipee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealtypefilter = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("recipe book"),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _recipeTypebuttons(),
          _recipeslist(),
        ],
      ),
    );
  }

  Widget _recipeTypebuttons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                _mealtypefilter = "snacks";
              },
              child: const Text("snacks"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealtypefilter = "breakfast";
                });
              },
              child: const Text("breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                _mealtypefilter = "lunch";
              },
              child: const Text("lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FilledButton(
              onPressed: () {
                _mealtypefilter = "dinner";
              },
              child: const Text("dinner"),
            ),
          )
        ],
      ),
    );
  }

  Widget _recipeslist() {
    return Expanded(
      child: FutureBuilder(
          future: Dataservices().getRecipes(
            _mealtypefilter,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("unable to load"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Recipe recipe = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Recipepage(
                        recipe: recipe,
                      );
                    }));
                  },
                  contentPadding: const EdgeInsets.only(top: 20.0),
                  isThreeLine: true,
                  subtitle: Text(
                      "${recipe.cuisine}\n difficulty:${recipe.difficulty}"),
                  title: Text(
                    recipe.name,
                  ),
                  leading: Image.network(
                    recipe.image,
                  ),
                  trailing: Text("${recipe.rating.toString()}  ⭐"),
                );
              },
            );
          }),
    );
  }
}
