import '../models/clothing_item.dart';

final List<ClothingItem> mockClothingItems = [
  const ClothingItem(
    id: 'c1',
    name: 'Classic Vintage Denim Jacket',
    category: 'Jackets',
    price: 89.99,
    rating: 4.8,
    reviewCount: 142,
    description:
        'A timeless denim jacket crafted from premium durable cotton denim. Features a classic collar, button front, and dual chest flap pockets. Perfect for layering in any season.',
    imageUrl:
        'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=600&auto=format&fit=crop',
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: [0xFF2B4C7E, 0xFF1C1C1C, 0xFF7A8B99],
    isPopular: true,
  ),
  const ClothingItem(
    id: 'c2',
    name: 'Minimalist Cotton Crewneck T-Shirt',
    category: 'T-Shirts',
    price: 29.99,
    rating: 4.6,
    reviewCount: 230,
    description:
        'Ultra-soft 100% organic combed cotton t-shirt with a standard modern fit. Breathable, preshrunk, and built to withstand daily wear and repeated wash cycles.',
    imageUrl:
        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop',
    availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    availableColors: [0xFFFFFFFF, 0xFF000000, 0xFF808080, 0xFF2D5A27],
    isPopular: true,
  ),
  const ClothingItem(
    id: 'c3',
    name: 'Elegant Floral Summer Midi Dress',
    category: 'Dresses',
    price: 64.50,
    rating: 4.9,
    reviewCount: 98,
    description:
        'Lightweight, flowy chiffon midi dress featuring a charming floral print, sweetheart neckline, and subtle side slit. Ideal for warm weekend outings and events.',
    imageUrl:
        'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=600&auto=format&fit=crop',
    availableSizes: ['XS', 'S', 'M', 'L'],
    availableColors: [0xFFE6C280, 0xFFC05C5C, 0xFF3D5A80],
    isPopular: true,
  ),
  const ClothingItem(
    id: 'c4',
    name: 'Slim-Fit Stretch Chino Pants',
    category: 'Pants',
    price: 49.99,
    rating: 4.5,
    reviewCount: 112,
    description:
        'Versatile stretch-cotton chinos designed with a tailored slim silhouette, flexible waistband, and slant pockets. Ideal for both casual and smart-casual looks.',
    imageUrl:
        'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=600&auto=format&fit=crop',
    availableSizes: ['30', '32', '34', '36'],
    availableColors: [0xFF2C3E50, 0xFF8D6E63, 0xFF37474F],
    isPopular: false,
  ),
  const ClothingItem(
    id: 'c5',
    name: 'Cozy Oversized Knit Sweater',
    category: 'Sweaters',
    price: 59.95,
    rating: 4.7,
    reviewCount: 87,
    description:
        'Warm and soft cable-knit sweater made with a premium wool-blend yarn. Designed with relaxed dropped shoulders and ribbed cuffs for maximum comfort.',
    imageUrl:
        'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=600&auto=format&fit=crop',
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: [0xFFEAE6E1, 0xFFB0A89E, 0xFF5C4033],
    isPopular: true,
  ),
  const ClothingItem(
    id: 'c6',
    name: 'Urban Leather Streetwear Sneakers',
    category: 'Shoes',
    price: 119.00,
    rating: 4.9,
    reviewCount: 310,
    description:
        'Modern low-top leather sneakers with cushioned memory foam insoles and durable rubber outsoles. Clean design that pairs seamlessly with any outfit.',
    imageUrl:
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600&auto=format&fit=crop',
    availableSizes: ['38', '39', '40', '41', '42', '43', '44'],
    availableColors: [0xFFFFFFFF, 0xFF121212, 0xFF8A8A8A],
    isPopular: true,
  ),
  const ClothingItem(
    id: 'c7',
    name: 'Water-Resistant Hooded Windbreaker',
    category: 'Jackets',
    price: 79.99,
    rating: 4.4,
    reviewCount: 65,
    description:
        'Lightweight weather-proof outerwear engineered with breathable lining, adjustable drawcord hood, and zippered utility pockets. Great for outdoor adventures.',
    imageUrl:
        'https://images.unsplash.com/photo-1548883354-7622d03aca27?w=600&auto=format&fit=crop',
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: [0xFF2A3439, 0xFF1E3A8A, 0xFF047857],
    isPopular: false,
  ),
  const ClothingItem(
    id: 'c8',
    name: 'Tailored Linen Casual Shirt',
    category: 'T-Shirts',
    price: 44.99,
    rating: 4.6,
    reviewCount: 78,
    description:
        '100% natural European flax linen button-down shirt. Exceptionally breathable, moisture-wicking, and pre-washed for relaxed soft texture.',
    imageUrl:
        'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=600&auto=format&fit=crop',
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: [0xFFFDFBF7, 0xFF87CEEB, 0xFFB0C4DE],
    isPopular: false,
  ),
];

final List<String> mockCategories = [
  'All',
  'T-Shirts',
  'Jackets',
  'Pants',
  'Dresses',
  'Sweaters',
  'Shoes',
];
