import 'package:tstore/features/shop/model/product_attribute_model.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/constants/image_strings.dart';

import '../../features/shop/model/banner_model.dart';
import '../../features/shop/model/brand_category_model.dart';
import '../../features/shop/model/brand_model.dart';
import '../../features/shop/model/category_model.dart';
import '../../features/shop/model/product_variation_model.dart';

class TDummyData {
  // banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: TImages.banner1, targetScreen: "/order", active: false),
    BannerModel(
        imageUrl: TImages.banner2, targetScreen: "/order", active: true),
    BannerModel(
        imageUrl: TImages.banner3, targetScreen: "/order", active: true),
    BannerModel(
        imageUrl: TImages.banner4, targetScreen: "/order", active: true),
    BannerModel(
        imageUrl: TImages.banner5, targetScreen: "/order", active: true),
    BannerModel(
        imageUrl: TImages.banner6, targetScreen: "/order", active: true),
    BannerModel(
        imageUrl: TImages.banner7, targetScreen: "/order", active: true),
    BannerModel(
        imageUrl: TImages.banner8, targetScreen: "/order", active: true),
  ];

  //categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
    CategoryModel(
        id: '5',
        name: 'Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true),
    CategoryModel(
        id: '2',
        name: 'Electronics',
        image: TImages.electronicsIcon,
        isFeatured: true),
    CategoryModel(
        id: '3', name: 'Clothes', image: TImages.clothIcon, isFeatured: true),
    CategoryModel(
        id: '4', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
    CategoryModel(
        id: '6', name: 'Shoes', image: TImages.shoeIcon, isFeatured: true),
    CategoryModel(
        id: '7',
        name: 'Cosmetics',
        image: TImages.cosmeticsIcon,
        isFeatured: true),
    CategoryModel(
        id: '14',
        name: 'Jewelery',
        image: TImages.jeweleryIcon,
        isFeatured: true),

    // sub categories
    // sports
    CategoryModel(
        id: '8',
        name: 'Sports Shoes',
        image: TImages.sportIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '9',
        name: 'Track Suits',
        image: TImages.sportIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '10',
        name: 'Sports Equipments',
        image: TImages.sportIcon,
        isFeatured: true,
        parentId: '1'),
    // furniture
    CategoryModel(
        id: '11',
        name: 'Bedroom Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '12',
        name: 'Kitchen Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '13',
        name: 'Office Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true,
        parentId: '1'),
    // electronics
    CategoryModel(
        id: '11',
        name: 'Bedroom Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '12',
        name: 'Kitchen Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true,
        parentId: '1'),
    CategoryModel(
        id: '13',
        name: 'Office Furniture',
        image: TImages.furnitureIcon,
        isFeatured: true,
        parentId: '1'),
  ];

  // products
  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        stock: 15,
        title: "Green Nike sports shoe",
        salePrice: 30,
        thumbnail: TImages.productImage1,
        price: 135,
        isFeatured: true,
        description: "Green Nike sports shoe",
        brand: BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo, productCount: 265, isFeatured: true),
        images: [TImages.productImage1, TImages.productImage23, TImages.productImage21, TImages.productImage9],
        sku: 'ABR4568',
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(
            name: 'Color',
            values: ["Green","Black","Red"]
          ),ProductAttributeModel(
            name: 'Size',
            values: ["EU 30","EU 32","EU 36"]
          ),
        ],
        productVariations: [
          ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: TImages.productImage1,
            description: "This is description of the product",
            attributeValues: {
              'Color':'Green',
              'Size':'EU 34'
            }
          ),ProductVariationModel(
            id: '2',
            stock: 44,
            price: 144,
            salePrice: 132.6,
            image: TImages.productImage2,
            description: "This is description of the second product",
            attributeValues: {
              'Color':'Black',
              'Size':'EU 32'
            }
          ),
        ],

        productType: "ProductType.variable",),
    ProductModel(
        id: '002',
        stock: 15,
        title: "Blue T-Shirts for all ages",
        salePrice: 30,
        thumbnail: TImages.productImage69,
        price: 35,
        isFeatured: true,
        description: "Green Nike sports shoe",
        brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo, productCount: 265, isFeatured: true),
        images: [TImages.productImage68, TImages.productImage69, TImages.productImage5],
        sku: 'ABR4568',
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(
            name: 'Color',
            values: ["Green","Black","Red"]
          ),ProductAttributeModel(
            name: 'Size',
            values: ["EU 34","EU 36"]
          ),
        ],


        productType: "ProductType.single",),
  ];

  // brands
  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        name: 'Nike',
        image: TImages.nikeLogo,
        productCount: 265,
        isFeatured: true),
    BrandModel(
        id: '2',
        name: 'Adidas',
        image: TImages.adidasLogo,
        productCount: 95,
        isFeatured: true),
    BrandModel(
        id: '3',
        name: 'Jordan',
        image: TImages.jordanLogo,
        productCount: 36,
        isFeatured: true),
    BrandModel(
        id: '4',
        name: 'Puma',
        image: TImages.pumaLogo,
        productCount: 65,
        isFeatured: true),
    BrandModel(
        id: '5',
        name: 'Apple',
        image: TImages.appleLogo,
        productCount: 16,
        isFeatured: true),
    BrandModel(
        id: '6',
        name: 'ZARA',
        image: TImages.zaraLogo,
        productCount: 36,
        isFeatured: true),
    BrandModel(
        id: '7',
        name: 'Samsung',
        image: TImages.electronicsIcon,
        productCount: 36,
        isFeatured: true),
    BrandModel(
        id: '8',
        name: 'Kenwood',
        image: TImages.kenwoodLogo,
        productCount: 36,
        isFeatured: true),
    BrandModel(
        id: '9',
        name: 'IKEA',
        image: TImages.ikeaLogo,
        productCount: 36,
        isFeatured: true),
    BrandModel(
        id: '10',
        name: 'Acer',
        image: TImages.acerlogo,
        productCount: 16,
        isFeatured: true),
  ];

//brand category
  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '1', categoryId: '8'),
    BrandCategoryModel(brandId: '1', categoryId: '9'),
    BrandCategoryModel(brandId: '1', categoryId: '10'),
    BrandCategoryModel(brandId: '2', categoryId: '1'),
    BrandCategoryModel(brandId: '2', categoryId: '8'),
    BrandCategoryModel(brandId: '2', categoryId: '9'),
    BrandCategoryModel(brandId: '2', categoryId: '10'),
    BrandCategoryModel(brandId: '3', categoryId: '1'),
    BrandCategoryModel(brandId: '3', categoryId: '8'),
    BrandCategoryModel(brandId: '3', categoryId: '9'),
    BrandCategoryModel(brandId: '3', categoryId: '10'),
  ];
}
