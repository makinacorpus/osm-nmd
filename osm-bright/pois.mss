
#pois[zoom >= 18] {
  text-name:'[name]';
  text-face-name:@sans;
  text-size:10;
  text-fill:@road_text;
  text-halo-fill:@road_halo;
  text-halo-radius: 1;
  text-dy: 9;
  text-wrap-width: 30;
  text-placement: interior;
  [zoom>=19] { text-size:11; }
  [zoom>=20] { text-size:12; text-allow-overlap: true}
  [amenity = 'fast_food'] {
    point-file: url('symbols/16-fast-food.png');
 	point-placement: interior;
  }
  [amenity = 'cafe'] {
    point-file: url('symbols/16-cafe.png');
  	point-placement: interior;
  }
  [amenity = 'restaurant'] {
    point-file: url('symbols/16-restaurant.png');
  	point-placement: interior;
  }
  [amenity = 'parking'] {
    point-file: url('symbols/16-parking.png');
  	point-placement: interior;
  }
  [amenity = 'hospital'] {
    point-file: url('symbols/hospital.p.16.png');
  	point-placement: interior;
  }
  [amenity = 'post_office'] {
    point-file: url('symbols/16-poste.png');
  	point-placement: interior;
  }
  [amenity = 'bank'] {
    point-file: url('symbols/16-banque.png');
  	point-placement: interior;
  }
  [amenity = 'bicycle_rental'] {
    point-file: url('symbols/16-bicloo.png');
  	point-placement: interior;
  }
  [amenity = 'toilets'] {
    point-file: url('symbols/toilets.p.20.png');
  	point-placement: interior;
  }
  [amenity = 'telephone'] {
    point-file: url('symbols/telephone.p.16.png');
  	point-placement: interior;
  }
  [amenity = 'recycling'] {
    point-file: url('symbols/recycling.p.16.png');
  	point-placement: interior;
  }
  [amenity = 'car_sharing'] {
    point-file: url('symbols/16-marguerite.png');
  	point-placement: interior;
  }
  [amenity = 'cinema'] {
    point-file: url('symbols/16-cinema.png');
  	point-placement: interior;
  }
  [amenity = 'school'] {
    point-file: url('symbols/16-ecole-primaire.png');
  	point-placement: interior;
    point-allow-overlap:true;
  }
  [amenity = 'university'],
  [amenity = 'college'] {
    point-file: url('symbols/16-structure-universitaire.png');
  	point-placement: interior;
  }
  [tourism = 'hotel'],
  [tourism = 'hostel'],
  [tourism = 'motel'] {
    point-file: url('symbols/16-hotel.png');
  	point-placement: interior;
  }
  [shop = 'bakery'] {
    point-file: url('symbols/16-boulangerie.png');
  	point-placement: interior;
  }
  [shop = 'mall'],
  [shop = 'department_store'] {
    point-file: url('symbols/16-magasin.png');
  	point-placement: interior;
  }
  [shop = 'supermarket'] {
    point-file: url('symbols/16-alimentation.png');
  	point-placement: interior;
  }
}

/*
A AFFICHER

* Fast-food
* Cafés
* Restos/ Brasseries
* Boulangeries
Hôtellerie
* Parkings
* Hôpitaux
Commerces
Centres commerciaux
* Super marchés (caddies)
* Postes
* Banques
* Vélos (abris, bicloo)
Pistes cyclables
Stations tramway/ busway
Tracés tramway
* Toilettes  publiques
* Cabines téléphoniques
* Points de recyclage
* Marguerite ?
* Bicloo ?
* Cinéma
* Universités/établissement scolaires

*/