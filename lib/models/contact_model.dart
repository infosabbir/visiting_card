const String tableContact = 'tbl_contact';
const String tblContactId = 'id';
const String tblContactName = 'name';
const String tblContactMobile = 'mobile';
const String tblContactLandLine = 'phone';
const String tblContactEmail = 'email';
const String tblContactAddress = 'address';
const String tblContactWebsite = 'website';
const String tblContactImage = 'image';
const String tblContactFavorite = 'favorite';
const String tblContactCompany = 'company';
const String tblContactDesignation = 'designation';

class ContactModel {
  int id;
  String name;
  String mobile;
  String landLine;
  String email;
  String company;
  String designation;
  String address;
  String website;
  bool favorite;
  String image;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.mobile,
    this.landLine = '',
    this.email = '',
    this.company = '',
    this.designation = '',
    this.address = '',
    this.website = '',
    this.favorite = false,
    this.image = 'images/person.png',
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactName: name,
      tblContactMobile: mobile,
      tblContactId: landLine,
      tblContactEmail: email,
      tblContactCompany: company,
      tblContactDesignation: designation,
      tblContactAddress: address,
      tblContactWebsite: website,
      tblContactImage: image,
      tblContactFavorite: favorite ? 1 : 0,
    };
    if (id > 0) {
      map[tblContactId] = id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        id: map[tblContactId],
        name: map[tblContactName],
        email: map[tblContactEmail],
        mobile: map[tblContactMobile],
        landLine: map[tblContactLandLine],
        address: map[tblContactAddress],
        company: map[tblContactCompany],
        designation: map[tblContactDesignation],
        website: map[tblContactWebsite],
        image: map[tblContactImage],
        favorite: map[tblContactFavorite] == 1 ? true : false,
      );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, mobile: $mobile, landLine: $landLine, email: $email, company: $company, designation: $designation, address: $address, website: $website, favorite: $favorite, image: $image}';
  }
}
