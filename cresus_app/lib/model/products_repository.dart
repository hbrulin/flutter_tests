import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product> [
      Product(
        category: Category.green,
        id: 0,
        name: 'EPARGNE 0',
        rate: 2,
      ),
      Product(
        category: Category.green,
        id: 1,
        name: 'EPARGNE 1',
        rate: 2,
      ),
      Product(
        category: Category.green,
        id: 2,
        name: 'EPARGNE 2',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 3,
        name: 'EPARGNE 3',
        rate: 3,
      ),
      Product(
        category: Category.green,
        id: 4,
        name: 'EPARGNE 4',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 5,
        name: 'EPARGNE 5',
        rate: 3,
      ),
      Product(
        category: Category.green,
        id: 6,
        name: 'EPARGNE 6',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 7,
        name: 'EPARGNE 6',
        rate: 4,
      ),
      Product(
        category: Category.green,
        id: 8,
        name: 'EPARGNE 7',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 9,
        name: 'EPARGNE 8',
        rate: 4,
      ),
      Product(
        category: Category.green,
        id: 10,
        name: 'EPARGNE 9',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 11,
        name: 'EPARGNE 10',
        rate: 2,
      ),
      Product(
        category: Category.green,
        id: 12,
        name: 'EPARGNE 11',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 13,
        name: 'EPARGNE 12',
        rate: 2,
      ),
      Product(
        category: Category.green,
        id: 14,
        name: 'EPARGNE 13',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 15,
        name: 'EPARGNE 14',
        rate: 2,
      ),
      Product(
        category: Category.green,
        id: 16,
        name: 'EPARGNE 15',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 17,
        name: 'EPARGNE 16',
        rate: 2,
      ),
      Product(
        category: Category.green,
        id: 18,
        name: 'EPARGNE 17',
        rate: 2,
      ),
      Product(
        category: Category.ethical,
        id: 19,
        name: 'EPARGNE 18',
        rate: 3,
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}