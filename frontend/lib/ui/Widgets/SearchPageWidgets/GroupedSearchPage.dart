import 'package:flutter/material.dart';
import 'package:size_hub/ui/Widgets/SearchPageWidgets/SearchBar.dart';
import 'package:size_hub/ui/Widgets/SearchPageWidgets/SearchPageCategories.dart';
import 'package:size_hub/ui/Pages/MapPage.dart';

class GroupedSearchPage extends StatefulWidget {
  GroupedSearchPage({Key key}) : super(key: key);

  @override
  _GroupedSearchPageState createState() => _GroupedSearchPageState();
}

class _GroupedSearchPageState extends State<GroupedSearchPage> {
  var fakeData = [
    {
      'icon': Icons.trending_up,
      'onPressed': null,
      'text': 'Trending',
      'image':
          'https://images.lululemon.com/is/image/lululemon/LW6BNZS_038292_2?wid=1440&op_usm=0.5,2,10,0&fmt=webp&qlt=90,1&fit=constrain,0&op_sharpen=0&resMode=sharp2&iccEmbed=0&printRes=72',
      'firstColor': Colors.purple,
      'secondColor': Colors.purpleAccent
    },
    {
      'icon': Icons.star_rate,
      'onPressed': null,
      'text': 'Featured',
      'image':
          'https://images.lululemon.com/is/image/lululemon/LW5DAQS_046691_2?wid=1080&op_usm=0.5,2,10,0&fmt=webp&qlt=90,1&fit=constrain,0&op_sharpen=0&resMode=sharp2&iccEmbed=0&printRes=72',
      'firstColor': Colors.pink,
      'secondColor': Colors.pinkAccent
    },
    {
      'icon': Icons.group,
      'onPressed': null,
      'text': 'Following',
      'image':
          'https://images.lululemon.com/is/image/lululemon/LW3DFMS_045852_1?wid=1080&op_usm=0.5,2,10,0&fmt=webp&qlt=90,1&fit=constrain,0&op_sharpen=0&resMode=sharp2&iccEmbed=0&printRes=72',
      'firstColor': Colors.orange,
      'secondColor': Colors.orangeAccent
    },
    {
      'icon': Icons.map,
      'onPressed': MapPage(),
      'text': 'Location',
      'image':
          'https://images.lululemon.com/is/image/lululemon/LW2BLGS_034270_1?wid=1080&op_usm=0.5,2,10,0&fmt=webp&qlt=90,1&fit=constrain,0&op_sharpen=0&resMode=sharp2&iccEmbed=0&printRes=72',
      'firstColor': Colors.green,
      'secondColor': Colors.greenAccent
    },
    {
      'icon': Icons.favorite,
      'onPressed': null,
      'text': 'Favorites',
      'image':
          'https://images.lululemon.com/is/image/lululemon/LW3DUTS_029610_1?wid=1080&op_usm=0.5,2,10,0&fmt=webp&qlt=90,1&fit=constrain,0&op_sharpen=0&resMode=sharp2&iccEmbed=0&printRes=72',
      'firstColor': Colors.red,
      'secondColor': Colors.redAccent
    },
    {
      'icon': Icons.search,
      'onPressed': null,
      'text': 'Search Item',
      'image':
          'https://images.lululemon.com/is/image/lululemon/LW1CPWS_0001_1?wid=1080&op_usm=0.5,2,10,0&fmt=webp&qlt=90,1&fit=constrain,0&op_sharpen=0&resMode=sharp2&iccEmbed=0&printRes=72',
      'firstColor': Colors.blue,
      'secondColor': Colors.blueAccent
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemCount: fakeData.length,
                itemBuilder: (_, index) {
                  var category = fakeData[index];
                  return GestureDetector(
                      onTap: () {
                        if (fakeData[index]['onPressed'] != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      fakeData[index]['onPressed']));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SearchPageCategories(
                          icon: category['icon'],
                          text: category['text'],
                          image: category['image'],
                          firstColor: category['firstColor'],
                          secondColor: category['secondColor'],
                        ),
                      ));
                }),
          ),
        )
      ],
    );
  }
}
