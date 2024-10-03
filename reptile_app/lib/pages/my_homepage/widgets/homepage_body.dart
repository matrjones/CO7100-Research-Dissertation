import 'package:flutter/material.dart';
import 'package:reptile_app/models/vivarium.dart';
import 'package:reptile_app/pages/my_homepage/widgets/add_vivarium_card.dart';
import 'package:reptile_app/pages/my_homepage/widgets/vivarium_card.dart';
import 'package:reptile_app/pages/shared/search_bar.dart';
import 'package:reptile_app/pages/vivarium_display/vivarium_display.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// Body of the homepage
class HomepageBody extends StatefulWidget implements PreferredSizeWidget {
  const HomepageBody({super.key});
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 1);
  @override
  State<HomepageBody> createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  Timer? _timer;
  final searchController = TextEditingController();

  // Attaches controllers and fetches vivarium data for vivarium display cards
  @override
  void initState() {
    super.initState();
    searchController.addListener(updateSearch);
    fetchVivaria().then((data) {
      setState(() {
        allVivaria = data;
        visibleVivaria = List.from(allVivaria);
      });
    }).catchError((error) {
      throw error;
    });

    // Refreshes vivarium card data every 5 seconds to display most up-to-date data
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer)
    {
      fetchVivaria().then((data) {
        setState(() {
          allVivaria = data;
        });
        updateSearch();
      }).catchError((error) {
        throw error;
      });
    });
  }

  // Method to dispose of child objects when parent object is out of scope
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Call to the API endpoint and return vivarium list
  Future<List<Vivarium>> fetchVivaria() async {
    final response = await http.get(Uri.parse('http://192.168.1.153:8080/api/Vivarium/getall'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((item) => Vivarium.fromJson(item as Map<String, dynamic>)).toList();
    }
    else {
      throw Exception('Failed to fetch vivaria');
    }
  }

  // Method to update vivarium cards based on searchbar input
  void updateSearch() {
    setState(() {
      visibleVivaria.clear();
      for (int i = 0; i < allVivaria.length; i++) {
        if (allVivaria[i]
            .name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          visibleVivaria.add(allVivaria[i]);
        }
      }
    });
  }

  // List of vivaria
  late List<Vivarium> allVivaria;

  // List of visible vivaria
  List<Vivarium> visibleVivaria = [];

  // Build for the homepage body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MySearchBar(controller: searchController, text: "Search..."),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),

              // Adding cards to the homepage body with tap events
              itemCount: visibleVivaria.length + 1,
              itemBuilder: (context, index) {
                // Add cards for each vivarium
                if (index < visibleVivaria.length) {
                  return GestureDetector(
                      onTap: () { moveToVivariumDisplay(index: index); },
                      child: VivariumCard(vivarium: visibleVivaria[index]));
                }
                // Add "add vivarium" card when searchbar is empty
                if(searchController.text.isEmpty) {
                  return GestureDetector(
                      onTap: () { moveToVivariumDisplay(); },
                      child: const AddVivariumCard());
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to navigate to vivarium display page
  void moveToVivariumDisplay({int index = -1}) {
    // If index exists, navigate to vivarium display
    if(index > -1){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VivariumDisplay(
                title: "Vivarium Display",
                vivarium: visibleVivaria[index],
                detail: true,
              )
          )
      );
    }
    // Navigate to add vivarium page
    else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const VivariumDisplay(
                title: "Add Vivarium",
                vivarium: null,
                detail: false,
              )
          )
      );
    }
  }
}
