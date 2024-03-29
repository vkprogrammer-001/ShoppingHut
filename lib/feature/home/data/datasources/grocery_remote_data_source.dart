// import 'package:dio/dio.dart';
// import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';

// class GroceryData {
//   static Future<List<ProductDataModel>> sampleData() async {
//     final Dio dio = Dio();
//     const baseUrl = 'https://fakestoreapi.com/products';
//     List<ProductDataModel> productInfo = [];
//     try {
//       Response productData = await dio.get(baseUrl);
//       print("user data: $productData");
//       for (var item in productData.data) {
//         ProductDataModel json = ProductDataModel.fromJson(item);
//         productInfo.add(json);
//       }
//       print("user info: $productInfo");
//     } on DioException catch (e) {
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         print('Dio error!');
//         print('STATUS: ${e.response?.statusCode}');
//         print('DATA: ${e.response?.data}');
//         print('HEADERS: ${e.response?.headers}');
//       } else {
//         // Error due to setting up or sending the request
//         print('Error sending request!');
//         print(e.message);
//       }
//     }
//     return productInfo;
//   }
// }
