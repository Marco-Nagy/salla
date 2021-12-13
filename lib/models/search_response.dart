class SearchResponse {
  bool status;
  dynamic data;

  SearchResponse({
    required this.status,
    this.data,
  });

  factory SearchResponse.fromJson(Map<dynamic, dynamic> json) {
    return SearchResponse(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int currentPage;
  List data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      data: (json["data"] as List)
          .map((json) => SearchData.fromJson(json))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class SearchData {
  int id;
  dynamic price;
  String image;
  String name;
  String description;
  List images;
  bool inFavorites;
  bool inCart;

  SearchData({
    required this.id,
    required this.description,
    required this.image,
    required this.images,
    required this.inCart,
    required this.inFavorites,
    required this.name,
    this.price,
  });

  factory SearchData.fromJson(Map<dynamic, dynamic> json) {
    return SearchData(
      id: json['id'],
      price: json['price'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      images: json['images'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
