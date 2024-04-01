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
  final String title;
  const SearchNavigate({required this.title, super.key});

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
        imagePath: 'assets/Person1.png'),
    Person(
        name: "Varun Viswanath",
        description: "Banking",
        imagePath: 'assets/Person1.png'),
    Person(
        name: "Sneha S",
        description: "Banking",
        imagePath: 'assets/Person1.png'),
    Person(
        name: "Neel Gabani",
        description: "Doctor",
        imagePath: 'assets/Person1.png'),
    Person(
        name: "Hemant Singh",
        description: "developer",
        imagePath: 'assets/Person1.png'),
  ];

  late List<Person> filteredPeople = [];

  @override
  void initState() {
    super.initState();
    filteredPeople = people; // Initially, display all people
  }

  void _filterSearchResults(String query) {
    List<Person> searchResults = people.where((person) {
      // Check if the person's name or description contains the search query
      return person.name.toLowerCase().contains(query.toLowerCase()) ||
          person.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredPeople = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // const CustomSearchBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged:
                  _filterSearchResults, // Call the filtering method on text change
              decoration: InputDecoration(
                labelText: 'Search by name or task description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemCount: filteredPeople.length,
              itemBuilder: (context, index) {
                return PersonCard(person: filteredPeople[index]);
              },
            ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
