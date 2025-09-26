class SearchModel {
  final String email;
  final String token;

  SearchModel({required this.email, required this.token});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      email: json['email'],
      token: json['token'],
    );
  }
}
