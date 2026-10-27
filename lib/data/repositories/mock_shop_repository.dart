import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/combo_model.dart';

class MockShopRepository {
  // Stable Unsplash athletic apparel image URLs
  static const String _heroBannerImg =
      'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=1200&q=80';
  static const String _categoriesBannerImg =
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1200&q=80';
  static const String _combosBannerImg =
      'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=1200&q=80';
  static const String _brandStoryImg =
      'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&w=1200&q=80';
  static const String _streetGymImg =
      'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?auto=format&fit=crop&w=1200&q=80';

  static const String _shortsBlackImg =
      'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?auto=format&fit=crop&w=800&q=80';
  static const String _shortsGreenImg =
      'https://images.unsplash.com/photo-1562157873-818bc0726f68?auto=format&fit=crop&w=800&q=80';
  static const String _shortsTrainingImg =
      'https://images.unsplash.com/photo-1539185441755-769473a23570?auto=format&fit=crop&w=800&q=80';
  static const String _shortsNavyImg =
      'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&w=800&q=80';
  static const String _trackpantsImg =
      'https://images.unsplash.com/photo-1552902865-b72c031ac5ea?auto=format&fit=crop&w=800&q=80';
  static const String _tshirtImg =
      'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=800&q=80';
  static const String _vestImg =
      'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=800&q=80';
  static const String _capImg =
      'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?auto=format&fit=crop&w=800&q=80';
  static const String _comboPackImg =
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80';

  List<ProductModel> getProducts() {
    return const [
      ProductModel(
        id: 'p1',
        name: '4-Way Stretch Gym Shorts',
        category: 'Shorts',
        subcategory: 'Gym Shorts',
        price: 499,
        originalPrice: 699,
        discountPercent: 17,
        rating: 4.5,
        reviewCount: 1200,
        imageUrl: _shortsBlackImg,
        galleryImages: [
          _shortsBlackImg,
          _shortsTrainingImg,
          _shortsNavyImg,
        ],
        description:
            'Engineered for maximum mobility and comfort during high-intensity training. Features sweat-wicking lightweight 4-way stretch fabric with deep secure zipper pockets.',
        features: [
          '4-Way Stretch',
          'Breathable Fabric',
          'Quick Dry',
        ],
        availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
        availableColorNames: ['Black', 'Olive Green', 'Light Grey', 'Navy Blue'],
        isTrending: true,
        isWishlisted: true,
      ),
      ProductModel(
        id: 'p2',
        name: 'Cargo Trackpants',
        category: 'Trackpants',
        subcategory: 'Casual',
        price: 598,
        originalPrice: 999,
        discountPercent: 40,
        rating: 4.6,
        reviewCount: 850,
        imageUrl: _trackpantsImg,
        galleryImages: [
          _trackpantsImg,
          _shortsBlackImg,
        ],
        description:
            'Rugged yet athletic cargo joggers designed for street style and warm-ups. Built with tapered ankle cuffs and reinforced cargo utility pockets.',
        features: [
          'Reinforced Stitching',
          'Tapered Ankle Fit',
          '6 Utility Pockets',
        ],
        availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
        availableColorNames: ['Black', 'Olive Green', 'Dark Grey'],
        isTrending: true,
        isWishlisted: true,
      ),
      ProductModel(
        id: 'p3',
        name: 'Performance Shorts',
        category: 'Shorts',
        subcategory: 'Running Shorts',
        price: 559,
        originalPrice: 699,
        discountPercent: 20,
        rating: 4.3,
        reviewCount: 860,
        imageUrl: _shortsGreenImg,
        galleryImages: [_shortsGreenImg, _shortsBlackImg],
        description:
            'Ultra-lightweight moisture-resistant running shorts featuring side splits for unrestricted stride and reflective logo accents.',
        features: ['Reflective Detailing', 'Inner Mesh Lining', 'Hidden Key Pocket'],
        availableSizes: ['S', 'M', 'L', 'XL'],
        availableColorNames: ['Olive Green', 'Black', 'Navy Blue'],
        isTrending: false,
        isWishlisted: false,
      ),
      ProductModel(
        id: 'p4',
        name: 'Training Shorts',
        category: 'Shorts',
        subcategory: 'Gym Shorts',
        price: 519,
        originalPrice: 649,
        discountPercent: 20,
        rating: 4.4,
        reviewCount: 980,
        imageUrl: _shortsTrainingImg,
        galleryImages: [_shortsTrainingImg, _shortsBlackImg],
        description:
            'Durable daily driver training shorts made to withstand barbell knurling and high reps without pilling or tearing.',
        features: ['Anti-Pilling Tech', 'Elastic Waistband', 'Quick Dry'],
        availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
        availableColorNames: ['Black', 'Dark Grey'],
        isTrending: false,
        isWishlisted: false,
      ),
      ProductModel(
        id: 'p5',
        name: 'Lightweight Shorts',
        category: 'Shorts',
        subcategory: 'Casual',
        price: 479,
        originalPrice: 599,
        discountPercent: 20,
        rating: 4.2,
        reviewCount: 760,
        imageUrl: _shortsNavyImg,
        galleryImages: [_shortsNavyImg, _shortsBlackImg],
        description:
            'Feather-light fabric designed for hot summer days, casual lounge sessions, and post-workout recovery.',
        features: ['Ultra Lightweight', 'Breathable Mesh', 'Comfort Drawstring'],
        availableSizes: ['S', 'M', 'L', 'XL'],
        availableColorNames: ['Navy Blue', 'Light Grey', 'Black'],
        isTrending: false,
        isWishlisted: false,
      ),
      ProductModel(
        id: 'p6',
        name: 'Oversized T-Shirt',
        category: 'T-Shirts',
        subcategory: 'Casual',
        price: 649,
        originalPrice: 799,
        discountPercent: 19,
        rating: 4.7,
        reviewCount: 1520,
        imageUrl: _tshirtImg,
        galleryImages: [_tshirtImg],
        description:
            'Drop-shoulder oversized silhouette crafted with heavy 240 GSM organic cotton blend. Perfect gym-to-street staple.',
        features: ['240 GSM Cotton', 'Drop Shoulder Fit', 'Ribbed Crewneck'],
        availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
        availableColorNames: ['Light Grey', 'Black', 'Off-White'],
        isTrending: true,
        isWishlisted: true,
      ),
      ProductModel(
        id: 'p7',
        name: 'Gym Vest',
        category: 'T-Shirts',
        subcategory: 'Gym Shorts',
        price: 429,
        originalPrice: 549,
        discountPercent: 22,
        rating: 4.4,
        reviewCount: 640,
        imageUrl: _vestImg,
        galleryImages: [_vestImg],
        description:
            'Deep-cut athletic stringer tank top that highlights physique while providing maximum ventilation for chest and back workouts.',
        features: ['Deep Cut Armholes', 'Soft Cotton Blend', 'Non-Chafing Hem'],
        availableSizes: ['S', 'M', 'L', 'XL'],
        availableColorNames: ['Black', 'Grey', 'Army Green'],
        isTrending: false,
        isWishlisted: true,
      ),
      ProductModel(
        id: 'p8',
        name: '11FIT Athletic Cap',
        category: 'Accessories',
        subcategory: 'Casual',
        price: 399,
        originalPrice: 599,
        discountPercent: 33,
        rating: 4.5,
        reviewCount: 410,
        imageUrl: _capImg,
        galleryImages: [_capImg],
        description:
            'Curved brim breathable snapback cap with 3D rubberized 11FIT logo and sweat-absorbent inner band.',
        features: ['Moisture Absorbing', 'Adjustable Snapback', 'Water-Repellent'],
        availableSizes: ['Free Size'],
        availableColorNames: ['Black', 'Charcoal'],
        isTrending: false,
        isWishlisted: false,
      ),
    ];
  }

  List<CategoryModel> getCategories() {
    return const [
      CategoryModel(
        id: 'c1',
        title: 'Shorts',
        imageUrl: _shortsBlackImg,
        itemCount: 32,
      ),
      CategoryModel(
        id: 'c2',
        title: 'Trackpants',
        imageUrl: _trackpantsImg,
        itemCount: 18,
      ),
      CategoryModel(
        id: 'c3',
        title: 'T-Shirts',
        imageUrl: _tshirtImg,
        itemCount: 24,
      ),
      CategoryModel(
        id: 'c4',
        title: 'Combos',
        imageUrl: _comboPackImg,
        itemCount: 12,
      ),
      CategoryModel(
        id: 'c5',
        title: 'Accessories',
        imageUrl: _capImg,
        itemCount: 15,
      ),
      CategoryModel(
        id: 'c6',
        title: 'New Arrivals',
        imageUrl: _heroBannerImg,
        itemCount: 20,
      ),
    ];
  }

  List<ComboModel> getCombos() {
    return const [
      ComboModel(
        id: 'combo_1',
        title: 'T-Shirt + Shorts Combo',
        packType: '2 Pack',
        price: 999,
        originalPrice: 1400,
        savings: 401,
        imageUrl: _tshirtImg,
        includedItems: ['Oversized Athletic T-Shirt', '4-Way Stretch Gym Shorts'],
      ),
      ComboModel(
        id: 'combo_2',
        title: 'T-Shirt + Shorts + Trackpants',
        packType: '3 Pack',
        price: 1499,
        originalPrice: 2097,
        savings: 598,
        imageUrl: _comboPackImg,
        includedItems: ['Performance Tee', '4-Way Stretch Shorts', 'Cargo Trackpants'],
      ),
      ComboModel(
        id: 'combo_3',
        title: 'Complete Gym Bundle',
        packType: '3 Pack',
        price: 1399,
        originalPrice: 1999,
        savings: 600,
        imageUrl: _streetGymImg,
        includedItems: ['Gym Vest', 'Training Shorts', '11FIT Cap'],
      ),
      ComboModel(
        id: 'combo_4',
        title: 'Essentials Accessories Pack',
        packType: 'Accessories',
        price: 799,
        originalPrice: 1199,
        savings: 400,
        imageUrl: _capImg,
        includedItems: ['Athletic Snapback Cap', 'Shaker Bottle', 'Sweat Wristbands'],
      ),
    ];
  }

  // Banner image getters
  String get heroBannerImg => _heroBannerImg;
  String get categoriesBannerImg => _categoriesBannerImg;
  String get combosBannerImg => _combosBannerImg;
  String get brandStoryImg => _brandStoryImg;
  String get streetGymImg => _streetGymImg;
}
