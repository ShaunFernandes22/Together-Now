import 'package:flutter/material.dart';
import 'package:together_now_ipd/Models/widgets/search_bar.dart';

class Person {
  final String name;
  final String description;
  final String imagePath;

  Person({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

class SearchNavigate extends StatefulWidget {
  const SearchNavigate({super.key});

  @override
  State<SearchNavigate> createState() => _SearchNavigateState();
}

class _SearchNavigateState extends State<SearchNavigate> {
  final List<Person> people = [
    Person(
        name: 'John Doe',
        description: 'Banking',
        imagePath: 'assets/Person1.png'),
    Person(
        name: 'Martinez K',
        description: 'Cooking',
        imagePath: 'assets/Person1.png'),
    Person(
        name: 'Mensah T',
        description: "Hospital",
        imagePath: 'assets/Person1.png'),
    Person(
        name: "Raj Shah",
        description: "Banking",
        imagePath: 'assets/Person1.png')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Volunteers"),
      ),
      body: Column(
        children: [
          // const CustomSearchBar(),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
            ),
            itemCount: people.length,
            itemBuilder: (context, index) {
              return PersonCard(person: people[index]);
            },
          ),
        ],
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            person.imagePath,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            person.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4.0),
          Text(person.description),
        ],
      ),
    );
  }
}
