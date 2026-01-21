class UserModel {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String gender;
  final List<String> languages;
  final String motherLanguages;

  final String? bio;
  final List<String> photos;
  final Map<String, dynamic>? location; // {'lat': 18.5204, 'long': 73.8567}
  final bool isVerified;
  final bool isblock;

//- Habits
  final String smoking; // option - regularly, Never, Sometimes
  final String drinking; // option - regularly, Never, Sometimes

// - LifeStyle
  final String workout; // option - regularly, Never, Sometimes
  final String diet; // option - non-veg, vegetarian, other,

// Religion
  final String religion;

// looking type of relationship
  final List<String> relationship;
  final String
      currentRelationshipStatus; // option - Single, inRelationShip, marital, divorce, widow, Widower

// professional
  final String professional; // option - Business, student, employee,
  final String
      education; // option- 10th pass, 12th, undergraduate,post-graduate,
  final String companyName;
  final String jobTitle;

//Interest
  final List<String> interests; //options - Fitness, Dancing, etc.

  UserModel(
    this.firstName,
    this.lastName,
    this.languages,
    this.motherLanguages,
    this.isblock,
    this.smoking,
    this.drinking,
    this.workout,
    this.diet,
    this.religion,
    this.relationship,
    this.professional,
    this.education,
    this.companyName,
    this.jobTitle,
    this.currentRelationshipStatus, {
    required this.uid,
    this.email,
    this.phoneNumber,
    required this.dob,
    required this.gender,
    this.bio,
    this.photos = const [],
    this.location,
    this.isVerified = false,
    this.interests = const [],
  });
}




























