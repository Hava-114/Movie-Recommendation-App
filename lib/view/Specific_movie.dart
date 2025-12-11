import 'package:flutter/material.dart';
import 'package:movie_app/widgets/mainscaff.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view.dart';

import 'package:url_launcher/url_launcher.dart';


class Specific_movie extends StatefulWidget {
  final int id;
  Specific_movie(this.id);

  @override
  _SpecificMovieState createState() => _SpecificMovieState();
}

class _SpecificMovieState extends State<Specific_movie> {
  double userRating = 0;  // ⭐ store user's rating
  Future<void> callfunc(String uri) async{
    final Uri url=Uri.parse(uri);
     if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw "Could not launch $url";
  }

  }
  @override
  void initState() {
    super.initState();
    Provider.of<MovieView>(context, listen: false).fetchMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MovieView>(context);
    final movie = vm.selectedMovie;

    return MainScaffold(
      body: Stack(
        children: [
          // ---------------- BACKGROUND IMAGE ----------------
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: movie != null
                ? Image.asset(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    color: Colors.purple.withOpacity(0.5),
                    colorBlendMode: BlendMode.multiply,
                  )
                : Container(color: Colors.black),
          ),

          // ---------------- CONTENT ----------------
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.65),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // BACK BUTTON
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),

                    // -------- POSTER --------
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: movie != null
                            ? Image.asset(movie.posterUrl,
                                height: 230, fit: BoxFit.cover)
                            : Container(height: 230, color: Colors.purple),
                      ),
                    ),

                    SizedBox(height: 20),

                    // -------- MOVIE NAME --------
                    Text(
                      movie?.name ?? '',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 10),

                    // -------- GENRE --------
                    Row(
                      children: [
                        Text(
                          'Genre: ${movie?.genre ?? ''}',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),

                    SizedBox(height: 5),

                    // -------- RATING DISPLAY --------
                    Row(
                      children: [
                        Text(
                          'Rating: ',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        SizedBox(width: 4),
                        Text(
                          movie?.rating.toString() ?? '',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),
                    Text('Watch on',style: TextStyle(color:Colors.white,fontSize: 16),),
                    Center(child: Container(width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                    ElevatedButton(onPressed: (){
                        callfunc('www.amazon.com');
                    }, child: Text('Amazon',style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: (){
                        callfunc('www.netflix.com');
                    }, child: Text('Netflix',style:TextStyle(color: Colors.white)),),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: (){
                        callfunc('www.hotstar.com');
                    }, child: Text('Hotstar',style: TextStyle(color:Colors.white))),
                    ],),),),
                    SizedBox(height: 25),
                    Text(
                      "Overview:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      movie?.review ?? '',
                      style: TextStyle(fontSize: 15, height: 1.5, color: Colors.white70),
                    ),

                    SizedBox(height: 30),

                    // -------- REVIEW INPUT BOX (IMPROVED) --------
                    Text(
                      "Write your Review:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    SizedBox(height: 10),

                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Type your review here...",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.12),
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white30),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Your Rating:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    SizedBox(height: 10),

                    StarRatingInput(
                      rating: userRating,
                      onRatingSelected: (value) {
                        setState(() {
                          userRating = value;
                        });
                      },
                    ),

                    SizedBox(height: 40),

                    Text(
                      'Reviews:',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),

                    SizedBox(height: 8),
                    Row(children: [
                      Icon(Icons.person,color: Colors.white),
                      SizedBox(width: 10),
                      Expanded(child:
                    Text(
                      'Explosions, stunts, and adrenaline; pure blockbuster entertainment.',
                      style: TextStyle(fontSize: 15, height: 1.5, color: Colors.white70),
                    ),),],),
                    SizedBox(height:12,),
                    Row(children: [
                      Icon(Icons.person,color: Colors.white),
                      SizedBox(width: 10),
                      
                    Text('I really loved this movie..',style: TextStyle(fontSize: 15, height: 1.5, color: Colors.white70),),
                  
                    ],),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRatingInput extends StatelessWidget {
  final double rating;
  final Function(double) onRatingSelected;

  StarRatingInput({required this.rating, required this.onRatingSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingSelected(index + 1.0),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 30,
          ),
        );
      }),
    );
  }
}
