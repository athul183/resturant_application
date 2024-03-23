import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:readmore/readmore.dart';
import 'package:resturant_application/model/Resto.dart';
import 'package:http/http.dart' as http;
import 'package:resturant_application/screens/homescreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Restaurant restaurant;
  DetailPage({super.key, required this.restaurant,});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Position? _currentPosition;
  List<Review> review =[];
  List<Latlng> direction = [];

  Future getReview() async {
    var responce = await http.get(Uri.parse('https://run.mocky.io/v3/9c7d5c0d-5dd9-4b72-b158-fcf4f61a956b'));
    // print(responce.body);

    var jsondata = jsonDecode(responce.body);

    for (var eachReview in jsondata['restaurants'][0]['reviews']){
      final Reviews = Review(
        name: eachReview['name'], 
        date: eachReview['date'], 
        rating: eachReview['rating'], 
        comments: eachReview['comments']); 

      review.add(Reviews);
    }

    for (var eachDire in jsondata['restaurants'][0]['latlng']){
      final directions = Latlng(
        lat: eachDire['lat'], 
        lng: eachDire['lng']);

      direction.add(directions);
      
    }

    

    // print(resto.length);
  }

  void _launchGoogleMaps() async {
  // The latitude and longitude of the desired location
  final double latitude = 40.7128;
  final double longitude = -74.0060;

  
  // The URL to open Google Maps with the desired location
  final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
                    
                          children: [
                Stack(
                  children: [
                    Container(height: 250,width: double.infinity,
                  
                      decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),fit: BoxFit.cover)
                            
                          ),
                  
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 20),
                      child: TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage() ));
                      }, 
                      child: Icon(Icons.arrow_back_ios),
                      ),
                    )

                  ],
                  
                ),
                        
                const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                
                              Padding(
                                padding: const EdgeInsets.only(right: 110),
                                child: Text(
                                  widget.restaurant.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ),
                              
                              Container(height: 20,width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Text("4.3",style: TextStyle(color: Colors.white),),
                                Icon(Icons.star,size: 15,color: Colors.white,)
                              ],),
                              ),
                              
                            ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(right: 270),
                            child: Text(widget.restaurant.neighborhood),
             
                          ),
             
                          const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(children: [
                          const Icon(Icons.restaurant_menu_outlined,color: Colors.grey,),
                          const SizedBox(width: 8,),
                          Text(widget.restaurant.cuisine_type)
                        ],),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(children: [
                          const Icon(Icons.location_on,color: Colors.grey,),
                          const SizedBox(width: 8,),
                          Text(widget.restaurant.address)
                        ],),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(children: [
                          const Icon(Icons.time_to_leave,color: Colors.grey,),
                          const SizedBox(width: 8,),
                          Text('Wednesday :'+widget.restaurant.now)
                        ],),
                      ),
                      const SizedBox(height: 15,),
                      const Padding(
                        padding: EdgeInsets.only(right: 180),
                        child: Text("Rating and Reviews",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      ),
             
                      FutureBuilder(
                        future: getReview(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){

                            return Expanded(
                          child: ListView.builder(itemBuilder: (builder,index){
                            return Column(children: [
                          
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    
                                  
                                  
                                  Container(height: 20,width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text(review[index].rating.toString(),style: TextStyle(color: Colors.white),),
                                    Icon(Icons.star,size: 15,color: Colors.white,)
                                  ],),
                                  ),
                                  SizedBox(width: 20,),
                                  Text(
                                    review[index].name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  
                                ],
                                ),
                              ),

                              SizedBox(height: 2,),

                              // Padding(
                              //   padding: const EdgeInsets.only(left: 15,right: 15),
                              //   child: Text(review[index].comments),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15,right: 15),
                                child: ReadMoreText(
                                  trimLines: 2,
                                  textAlign: TextAlign.justify,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: "Read More",
                                  trimExpandedText: "Read Less",
                                  review[index].comments,
                                  lessStyle: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold
                                  ),
                                  moreStyle: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),

                              ),

                              const SizedBox(height: 15,),

                              

                              Padding(
                                padding: const EdgeInsets.only(right: 250),
                                child: Text(review[index].date),
                              ),

                          
                            ],);
                          } ,itemCount: 3),
                        );
                            
                          }
                          else{
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                        
                      )
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: (){
                _launchGoogleMaps();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.turn_right,color: Colors.white,),
                  Text("Go",style: TextStyle(color: Colors.white),)
                ],
              ),
              backgroundColor: Colors.orange,
              ),
    );
  }
}
