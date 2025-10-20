class LmsData {
  final int month;
  final double l;
  final double m;
  final double s;

  LmsData({
    required this.month,
    required this.l,
    required this.m,
    required this.s,
  });

  factory LmsData.fromJson(Map<String, dynamic> json) {
    return LmsData(
      month: json['Month'] as int,
      l: (json['L'] as num).toDouble(),
      m: (json['M'] as num).toDouble(),
      s: (json['S'] as num).toDouble(),
    );
  }
}