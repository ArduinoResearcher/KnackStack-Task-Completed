import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(KnackStack());
}

class Achievement {
  final String title;
  final String description;
  final String date; // New field for date
  final String language; // New field for programming language
  final double rating; // New field for rating

  Achievement({
    required this.title,
    required this.description,
    required this.date,
    required this.language,
    required this.rating,
  });
}

class KnackStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Achievement> achievements = [
    Achievement(
      title: 'Project 1',
      description: 'This is the first Project description.',
      date: '2023-09-10',
      language: 'Flutter',
      rating: 4.5,
    ),
    Achievement(
      title: 'Project 2',
      description: 'This is the second Project description.',
      date: '2023-09-15',
      language: 'Python',
      rating: 5.0,
    ),
    Achievement(
      title: 'Project 3',
      description: 'This is the third Project description.',
      date: '2023-09-20',
      language: 'JavaScript',
      rating: 3.5,
    ),
  ];

  String _selectedSortOption = 'Sort by Rating'; // Default sort option

  void _sortAchievements(String option) {
    setState(() {
      _selectedSortOption = option;
      if (option == 'Sort by Rating') {
        achievements.sort((a, b) => a.rating.compareTo(b.rating));
      } else if (option == 'Latest Completed') {
        achievements.sort((a, b) => b.date.compareTo(a.date));
      } else if (option == 'Programming Language') {
        achievements.sort((a, b) => a.language.compareTo(b.language));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(
                  'C:/Users/kuttu/Downloads/Knack Stack/BG.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            width: screenWidth,
            height: screenHeight * 0.3,
            child: Stack(
              children: [
                Positioned(
                  left: screenWidth * 0.04,
                  bottom: screenHeight * 0.13,
                  child: Text(
                    'Tasks Completed',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: screenWidth * 0.065,
                  bottom: screenHeight * 0.04,
                  height: screenHeight * 0.049,
                  width: screenWidth * 0.27,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PopupMenuButton<String>(
                          child: Text(
                            'Filters',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onSelected: _sortAchievements,
                          itemBuilder: (BuildContext context) {
                            return [
                              'Sort by Rating',
                              'Latest Completed',
                              'Programming Language',
                            ].map((String option) {
                              return PopupMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.6, // Use the remaining space
            child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AchievementDetailsScreen(
                          achievement: achievements[index],
                        ),
                      ),
                    );
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        achievements[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.07, // Variable text size
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Align to the right
                        children: [
                          Text(
                            achievements[index].date,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  screenWidth * 0.04, // Variable text size
                            ),
                          ),
                          RatingBarIndicator(
                            rating: achievements[index].rating,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize:
                                screenWidth * 0.04, // Variable rating bar size
                            unratedColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AchievementDetailsScreen extends StatelessWidget {
  final Achievement achievement;

  AchievementDetailsScreen({required this.achievement});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: DecorationImage(
            image: AssetImage(
              'C:/Users/kuttu/Downloads/Knack Stack/BG.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                achievement.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                achievement.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Project Date: ${achievement.date}',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  RatingBarIndicator(
                    rating: achievement.rating,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: screenWidth * 0.04, // Variable rating bar size
                    unratedColor: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
