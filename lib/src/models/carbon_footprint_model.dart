class CarbonFootprint {
  int id;
  double totalDistance;
  String tier;
  double footprint;
  int user;

  CarbonFootprint({
    required this.id,
    required this.totalDistance,
    required this.tier,
    required this.footprint,
    required this.user,
  });

  // Factory constructor to create an instance from JSON
  factory CarbonFootprint.fromJson(Map<String, dynamic> json) {
    return CarbonFootprint(
      id: json['id'],
      totalDistance: json['total_distance'],
      tier: json['tier'],
      footprint: json['footprint'],
      user: json['user'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_distance': totalDistance,
      'tier': tier,
      'footprint': footprint,
      'user': user,
    };
  }
}
