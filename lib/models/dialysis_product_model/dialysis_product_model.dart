class DialysisProductModel {
  bool? result;
 var message;
  List<Products>? products;
  var page;

  DialysisProductModel({this.result, this.message, this.products, this.page});

  DialysisProductModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class Products {
  var id;
 var name;
 var image;
 var mrp;
 var sellingPrice;
 var description;
  var status;
 var createdAt;
 var updatedAt;
 var is_wishlist;
 var ratings;

  Products(
      {this.id,
        this.name,
        this.image,
        this.mrp,
        this.sellingPrice,
        this.description,
        this.status,
        this.is_wishlist,
        this.createdAt,
        this.ratings,
        this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
    image = json['image']??"";
    mrp = json['mrp']??"";
    ratings = json['ratings']??"";
    is_wishlist = json['is_wishlist']??"";
    sellingPrice = json['selling_price']??"";
    description = json['description']??"";
    status = json['status']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['mrp'] = this.mrp;
    data['is_wishlist'] = this.is_wishlist;
    data['ratings'] = this.ratings;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
