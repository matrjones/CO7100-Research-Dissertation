import 'package:flutter/material.dart';
import 'package:reptile_app/models/vivarium.dart';
import 'package:reptile_app/pages/my_homepage/widgets/add_vivarium_card.dart';
import 'package:reptile_app/pages/my_homepage/widgets/vivarium_card.dart';
import 'package:reptile_app/pages/shared/search_bar.dart';
import 'package:reptile_app/pages/vivarium_display/vivarium_display.dart';

class HomepageBody extends StatefulWidget implements PreferredSizeWidget {
  const HomepageBody({super.key});
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 1);
  @override
  State<HomepageBody> createState() => _HomepageBodyState();
}

class _HomepageBodyState extends State<HomepageBody> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(updateSearch);
    visibleVivaria = List.from(allVivaria);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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

  // LIST OF VIVARIA
  List<Vivarium> allVivaria = [
    Vivarium(
      name: 'Viv 1',
      lighting: true,
      temperature: 28.0,
    ),
    Vivarium(
      name: 'Vivarium 2',
      lighting: false,
      temperature: 29.9,
    ),
    Vivarium(
      name: 'Vivarium 3',
      lighting: true,
      temperature: 38.7,
    )
  ];

  // LIST OF VISIBLE VIVARIA
  List<Vivarium> visibleVivaria = [];

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
              itemCount: visibleVivaria.length + 1,
              itemBuilder: (context, index) {
                if (index < visibleVivaria.length) {
                  return GestureDetector(
                      onTap: () { moveToVivariumDisplay(index); },
                      child: VivariumCard(vivarium: visibleVivaria[index]));
                }
                if(searchController.text.isEmpty) {
                  return const AddVivariumCard();
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void moveToVivariumDisplay(int index) {
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
}
