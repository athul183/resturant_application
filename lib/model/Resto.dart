class Restaurant{

  final String name;
  final String cuisine_type;
  final String address;
  final String neighborhood;
  final String now;

  

  Restaurant({
    required this.name,  
    required this.cuisine_type, 
    required this.address,
    required this.neighborhood,
    required this.now,
  
    
    
  });

}

class Review {
    String name;
    String date;
    int rating;
    String comments;

    Review({
        required this.name,
        required this.date,
        required this.rating,
        required this.comments,
      
    });

}

class Latlng {
    final double lat;
    final double lng;

    Latlng({
        required this.lat,
        required this.lng,
    });

}


