
class ProductResponse {
  final List<Product> products;
  final int total;
  final int page;
  final int totalPages;
  final bool hasNextPage;

  ProductResponse({
    required this.products,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'totalPages': totalPages,
      'hasNextPage': hasNextPage,
    };
  }
}

class Product {
  final Ratings ratings;
  final String id;
  final String name;
  final String slug;
  final String description;
  final String? shortDescription;
  final Category? category;
  final String? featuredImage;
  final List<String>? images;
  final double price;
  final double? discountPrice;
  final int stock;
  final String? sku;
  final String? brand;
  final List<String> tags;
  final bool isFeatured;
  final bool isActive;
  final List<dynamic> attributes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Product({
    required this.ratings,
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.shortDescription,
    this.category,
    this.featuredImage,
    this.images,
    required this.price,
    this.discountPrice,
    required this.stock,
    this.sku,
    this.brand,
    required this.tags,
    required this.isFeatured,
    required this.isActive,
    required this.attributes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      ratings: json['ratings'] != null
          ? Ratings.fromJson(json['ratings'] as Map<String, dynamic>)
          : Ratings(average: 0, count: 0),
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['shortDescription'],
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      featuredImage: json['featuredImage'],
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : null,
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: json['discountPrice'] != null
          ? (json['discountPrice'] as num).toDouble()
          : null,
      stock: json['stock'] ?? 0,
      sku: json['sku'],
      brand: json['brand'],
      tags: json['tags'] != null
          ? List<String>.from(
              (json['tags'] as List<dynamic>).map((e) => e.toString()))
          : [],
      isFeatured: json['isFeatured'] ?? false,
      isActive: json['isActive'] ?? true,
      attributes: json['attributes'] ?? [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratings': ratings.toJson(),
      '_id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'shortDescription': shortDescription,
      'category': category?.toJson(),
      'featuredImage': featuredImage,
      'images': images,
      'price': price,
      'discountPrice': discountPrice,
      'stock': stock,
      'sku': sku,
      'brand': brand,
      'tags': tags,
      'isFeatured': isFeatured,
      'isActive': isActive,
      'attributes': attributes,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class Ratings {
  final double average;
  final int count;

  Ratings({required this.average, required this.count});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      average: (json['average'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average': average,
      'count': count,
    };
  }
}

class Category {
  final String id;
  final String name;
  final String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
    };
  }
}