import 'package:tstore/utils/constants/image_strings.dart';

import '../../features/shop/model/banner_model.dart';
import '../../features/shop/model/brand_category_model.dart';
import '../../features/shop/model/brand_model.dart';
import '../../features/shop/model/category_model.dart';

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
