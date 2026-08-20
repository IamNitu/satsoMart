import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sasto_mart/core/api/api_endpoints.dart';
import 'package:sasto_mart/features/home/models/product_model.dart';

class ProductsApi {
  Future<ProductResponse> getProducts() async{
    try{
      final baseUrl = dotenv.env["API_HOST"];
      final uri =Uri.parse('$baseUrl${ApiEndpoints.products}');

      final response = await http.get(uri);

      if(response.statusCode ==200){
        final json  = jsonDecode(response.body);
        return ProductResponse.fromJson(json);
      }
      else{
        throw Exception(
          'failed to load products ${response.statusCode}'
        );
      }
    }
    catch(e){
      throw Exception(
        'Failed to load products ${e}'
      );
    }
  }
}