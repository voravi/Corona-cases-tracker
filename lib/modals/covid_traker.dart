class Covid {
  final String? country;
  final String? totalCases;

  final String? totalDeaths;
  final String? totalRecover;
  final String? lastUpdated;

  Covid({
    required this.country,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecover,
    required this.lastUpdated,
  });

  factory Covid.fromMap({required Map data}) {
    return Covid(
      country: data["Country_text"],
      totalCases: data["Total Cases_text"],
      totalDeaths: data["Total Deaths_text"],
      totalRecover: data["Total Recovered_text"],
      lastUpdated: data["Last Update"],
    );
  }
}
