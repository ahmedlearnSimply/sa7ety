// 'name': event.name,
//       'image': '',
//       'specialization': '',
//       'rating': 3,
//       'email': event.email,
//       'phone1': '',
//       'phone2': '',
//       'bio': '',
//       'openHour': '',
//       'closeHour': '',
//       'address': '',
//       'uid': user?.uid,
class DoctorModel {
  String? name;
  String? image;
  String? specialization;
  int? rating;
  String? email;
  String? phone1;
  String? phone2;
  String? bio;
  String? openHour;
  String? closeHour;
  String? address;
  String? uid;
  //* constructor
  DoctorModel({
    this.name,
    this.image,
    this.specialization,
    this.rating,
    this.email,
    this.phone1,
    this.phone2,
    this.bio,
    this.openHour,
    this.closeHour,
    this.address,
    this.uid,
  });

  //* from json
  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        name: json['name'],
        image: json['image'],
        specialization: json['specialization'],
        rating: json['rating'],
        email: json['email'],
        phone1: json['phone1'],
        phone2: json['phone2'],
        bio: json['bio'],
        openHour: json['openHour'],
        closeHour: json['closeHour'],
        address: json['address'],
        uid: json['uid'],
      );
  //* to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'specialization': specialization,
      'rating': rating,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      'bio': bio,
      'openHour': openHour,
      'closeHour': closeHour,
      'address': address,
      'uid': uid,
    };
  }
}
