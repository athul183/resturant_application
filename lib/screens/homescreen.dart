import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resturant_application/model/Resto.dart';
import 'package:resturant_application/screens/detailscreen.dart';
import 'package:resturant_application/screens/login.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  List<Restaurant> hotel =[];

  Future getResto() async {
    var responce = await http.get(Uri.parse('https://run.mocky.io/v3/9c7d5c0d-5dd9-4b72-b158-fcf4f61a956b'));
    // print(responce.body);

    var jsondata = jsonDecode(responce.body);

    for (var eachResto in jsondata['restaurants']){
      final Restos = Restaurant(
        name: eachResto['name'], 
        cuisine_type: eachResto['cuisine_type'], 
        address: eachResto['address'],
        neighborhood: eachResto['neighborhood'],
        now: eachResto['operating_hours']['Wednesday'],
        
        
        
      );      
      hotel.add(Restos);

    }

    // print(resto.length);


  }

  final List<String> imageUrls = [
  'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://media.istockphoto.com/id/1343182422/photo/empty-rustic-design-restaurant-with-wooden-furniture-and-some-decorative-plants.webp?b=1&s=170667a&w=0&k=20&c=et0uadwZ9NPZbg-t8nRENoJh5I_aqTCVqEhO2kMcywc=',
  'https://media.istockphoto.com/id/1457979959/photo/snack-junk-fast-food-on-table-in-restaurant-soup-sauce-ornament-grill-hamburger-french-fries.webp?b=1&s=170667a&w=0&k=20&c=A_MdmsSdkTspk9Mum_bDVB2ko0RKoyjB7ZXQUnSOHl0=',
  'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHJlc3RhdXJhbnR8ZW58MHx8MHx8fDA%3D',
  'https://images.unsplash.com/photo-1424847651672-bf20a4b0982b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHJlc3RhdXJhbnR8ZW58MHx8MHx8fDA%3D',
  'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHJlc3RhdXJhbnR8ZW58MHx8MHx8fDA%3D',
  'https://media.istockphoto.com/id/1498929146/photo/hispanic-waiter-taking-order-from-multiracial-couple.webp?b=1&s=170667a&w=0&k=20&c=wUECgLgUQNnrO9cFEM51meMZUBgWJQhzM0BTzr3849s=',
  'https://media.istockphoto.com/id/1457547035/photo/waiter-working-at-a-cafe-preparing-a-delivery-order.webp?b=1&s=170667a&w=0&k=20&c=_qbtzS-nlZI_r9by7p-TGIvtHSCu00DWU-f8_3oXpb4=',
];


  @override
  Widget build(BuildContext context) {
    getResto();
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding:  EdgeInsets.only(left: 20),
          child: Text("RESTAURANTS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        ),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
          }, 
          icon: const Icon(Icons.logout), 
          label: const Text("Log Out",style: TextStyle(color: Colors.white),),style: const ButtonStyle(
            iconColor: MaterialStatePropertyAll(Colors.white),
            ),
          )
        ],
        ),
        body: FutureBuilder(

          future: getResto(),
          builder: (context, snapshot) {
            
            if(snapshot.connectionState == ConnectionState.done){

              return Expanded(
            child: ListView.builder(itemBuilder: (builder, index){
              
              final details = hotel[index];
              
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(restaurant: details)));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 200,
                        width: 400,
                        
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(imageUrls[index]),fit: BoxFit.cover)
                          
                        ),
                        ),
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 180),
                          child: Text(
                            hotel[index].name,style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        
                        Container(height: 20,width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('3.7',style: TextStyle(color: Colors.white),),
                          Icon(Icons.star,size: 15,color: Colors.white,)
                        ],),
                        )
                      ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(children: [
                        const Icon(Icons.restaurant_menu_outlined,color: Colors.grey,),
                        const SizedBox(width: 8,),
                        Text(hotel[index].cuisine_type)
                      ],),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(children: [
                        const Icon(Icons.location_on,color: Colors.grey,),
                        const SizedBox(width: 8,),
                        Text(hotel[index].address)
                      ],),
                    )
                  ],
                ),
              );
            
            },
            itemCount: hotel.length
            ),
                  );

            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        
        )
          
    );
  }
}