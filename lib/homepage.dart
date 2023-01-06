import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/remote_service.dart';
import 'package:movies_app/trending_movies.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  List<Result>? trendingMovies;
  List<Result>? topRatedMovies;
  List<Result>? nowPlaying;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getTrendingMoviesData();
    getTopratedMoviesData();
    getNowPlayingData();
  }

  getTrendingMoviesData() async {
    trendingMovies = await RemoteService().getPosts();
    print(trendingMovies);
    if (trendingMovies != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  getTopratedMoviesData() async {
    topRatedMovies = await RemoteService2().getPosts();
    print(trendingMovies);
    if (trendingMovies != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  getNowPlayingData() async {
    nowPlaying = await RemoteService3().getPosts();
    print(trendingMovies);
    if (trendingMovies != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 64, 64, 64),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Builder(builder: (context) {
                            return IconButton(
                              icon: Icon(
                                Icons.menu,
                                size: 30,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                // code to execute when the IconButton is pressed
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          }),
                          SizedBox(width: 20),
                          Text(
                            'What\'s New',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      // handle search icon press
                    },
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                // add a logout option in the side panel
                Builder(builder: (context) {
                  return ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () async {
                      // handle logout
                      await FirebaseAuth.instance.signOut();
                      // navigate to login screen
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                      // Navigator.pushReplacementNamed(context, '/login');
                    },
                  );
                }),
              ],
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Trending Movies',
                      style: TextStyle(
                        color: Color.fromRGBO(220, 220, 220, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 300,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: isLoaded,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trendingMovies?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 200,
                                        height: 250,
                                        color: Colors.grey.shade900,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500/${trendingMovies?[index]?.posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      clipBehavior: Clip.none,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${trendingMovies?[index]?.title}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Top Rated Movies',
                      style: TextStyle(
                        color: Color.fromRGBO(220, 220, 220, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 300,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: isLoaded,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: topRatedMovies?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 200,
                                        height: 250,
                                        color: Colors.grey.shade900,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500/${topRatedMovies?[index]?.posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      clipBehavior: Clip.none,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${topRatedMovies?[index]?.title}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Now Playing',
                      style: TextStyle(
                        color: Color.fromRGBO(220, 220, 220, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 300,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: isLoaded,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: nowPlaying?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 200,
                                        height: 250,
                                        color: Colors.grey.shade900,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w500/${nowPlaying?[index]?.posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      width: 150,
                                      height: 50,
                                      clipBehavior: Clip.none,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          '${nowPlaying?[index]?.title}',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Scaffold(
// appBar: AppBar(
// title: const Text('Home Page'),
// automaticallyImplyLeading: false,
// ),
// body: Center(
// child: TextButton(
// child: const Text('Logout'),
// onPressed: () {
// // Add code to log out and navigate back to the login page
// // Sign out from Firebase
// FirebaseAuth.instance.signOut();
//
// // Pop the HomePage route from the stack
// Navigator.pop(context);
// },
// ),
// ),
// ),
