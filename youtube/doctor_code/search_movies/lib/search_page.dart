import 'package:flutter/material.dart';
import './model/movie_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //I'm now going to create a dummy list of movies
  // you can build your own list, I used th IMDB data so you can use the same source
  static List<MovieModel> main_movies_list = [
    MovieModel("Avatar", 2009, 7.9,
        "https://cdna.artstation.com/p/assets/images/images/031/645/214/large/shreyas-raut-avatar-2.jpg?1604210989"),
    MovieModel("I Am Legend", 2007, 7.2,
        "https://images2.9c9media.com/image_asset/2019_2_14_f02ce589-7434-4ef2-ae0f-1879c20072e2_png_2000x3000.jpg"),
    MovieModel("300", 2006, 7.7,
        "https://miro.medium.com/max/1200/1*Lila0tiJwH8hk6R0iDLabw.png"),
    MovieModel("The Avengers", 2012, 8.1,
        "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg"),
    MovieModel("The Wolf of Wall Street", 2013, 8.2,
        "https://m.media-amazon.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_.jpg"),
    MovieModel("Interstellar", 2014, 8.6,
        "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/45fc99105415493.619ded0619991.jpg"),
  ];

  // creating the list that we're going to display and filter
  List<MovieModel> display_list = List.from(main_movies_list);

  void updateList(String value) {
    // this is the function that will filter our list
    // we will be back to this list after a while
    // Now let's write our search function
    setState(() {
      display_list = main_movies_list
          .where((element) =>
              element.movie_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget _searchZone(String label, {required Function callback}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 22,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        _inputLabel(label),
        SizedBox(
          height: 20,
        ),
        _inputField(callback: callback),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _inputLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _inputField({required Function callback}) {
    // this is the input field widget
    return TextField(
      onChanged: (value) {
        // updateList(value);
        callback(value);
      },
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xff302360),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: "eg: Home Alone",
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 18, 13, 36),
        ),
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Colors.purple.shade900,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f1545),
      appBar: AppBar(
        backgroundColor: Color(0xff1f1545),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchZone("Search for a Movie", callback: updateList),
            Expanded(
              // Now let's create a function to display a text in case we don't get results
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                        "No result found",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.all(8),
                        title: Text(
                          display_list[index].movie_title!,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          display_list[index].movie_release_year.toString(),
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          "${display_list[index].rating}",
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              display_list[index].movie_poster_url!),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
