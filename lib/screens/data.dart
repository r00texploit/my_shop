import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';

List<Map<String, dynamic>> populars = [
  {
    'name': 'Pain Relief',
    'is_favorited': Random().nextBool(),
    'price': 35,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to reduce pain, inflammation, and swelling in conditions that affect joints and muscles.",
    "company": "Pharma Inc.",
    "section": "Analgesics",
    "color": "White",
    "number": 100,
    "type": "Tablet"
  },
  {
    'name': 'Antibiotic',
    'is_favorited': Random().nextBool(),
    'price': 45,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Helps kill or inhibit the growth of bacteria, commonly used for treating bacterial infections.",
    "company": "BestCure LLC",
    "section": "Antibiotics",
    "color": "Blue",
    "number": 150,
    "type": "Capsule"
  },
  {
    'name': 'Anti-inflammatory',
    'is_favorited': Random().nextBool(),
    'price': 65,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Reduces inflammation and can be used to treat conditions like arthritis.",
    "company": "HealthPlus Corp.",
    "section": "Anti-inflammatory",
    "color": "Green",
    "number": 200,
    "type": "Cream"
  },
  {
    'name': 'Cough Syrup',
    'is_favorited': Random().nextBool(),
    'price': 34,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to treat coughs caused by the common cold, bronchitis, and other breathing illnesses.",
    "company": "MediCare Solutions",
    "section": "Respiratory",
    "color": "Red",
    "number": 120,
    "type": "Syrup"
  },
  {
    'name': 'Vitamin Supplement',
    'is_favorited': Random().nextBool(),
    'price': 40,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Provides essential vitamins and minerals to support overall health and well-being.",
    "company": "VitaHealth Ltd.",
    "section": "Supplements",
    "color": "Yellow",
    "number": 250,
    "type": "Pill"
  }
];

List<Map<String, dynamic>> news = [
  {
    'name': 'Antihistamine',
    'is_favorited': Random().nextBool(),
    'price': 80,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to relieve or prevent the symptoms of hay fever and other types of allergy.",
    "company": "GlobalPharm",
    "section": "Allergy",
    "color": "Pink",
    "number": 180,
    "type": "Tablet"
  },
  {
    'name': 'Anti-depressant',
    'is_favorited': Random().nextBool(),
    'price': 35,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Helps to alleviate the symptoms of depression by affecting the neurotransmitters in the brain.",
    "company": "Serene Pharma",
    "section": "Psychiatric",
    "color": "Purple",
    "number": 90,
    "type": "Capsule"
  },
  {
    'name': 'Anti-fungal',
    'is_favorited': Random().nextBool(),
    'price': 25,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to treat fungal infections by destroying the fungal cells or stopping their growth.",
    "company": "FungiFree Inc.",
    "section": "Antifungal",
    "color": "Brown",
    "number": 70,
    "type": "Cream"
  },
  {
    'name': 'Anti-anxiety',
    'is_favorited': Random().nextBool(),
    'price': 30,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to treat anxiety disorders by reducing symptoms such as fear, tension, and irritability.",
    "company": "CalmCo Pharmaceuticals",
    "section": "Psychiatric",
    "color": "Orange",
    "number": 110,
    "type": "Pill"
  },
  {
    'name': 'Anti-viral',
    'is_favorited': Random().nextBool(),
    'price': 23,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to treat viral infections by inhibiting the development of the virus within the host cell.",
    "company": "ViroStop Ltd.",
    "section": "Antiviral",
    "color": "Black",
    "number": 130,
    "type": "Syrup"
  },
  {
    'name': 'Anti-malaria',
    'is_favorited': Random().nextBool(),
    'price': 75,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to treat and prevent malaria by killing the parasites that cause the disease.",
    "company": "MalariaNoMore Inc.",
    "section": "Antimalarial",
    "color": "Green",
    "number": 160,
    "type": "Tablet"
  },
  {
    'name': 'Anti-diarrheal',
    'is_favorited': Random().nextBool(),
    'price': 89,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to reduce the frequency of diarrhea and improve the consistency of stools.",
    "company": "DigestWell Pharma",
    "section": "Gastrointestinal",
    "color": "White",
    "number": 200,
    "type": "Pill"
  },
  {
    'name': 'Anti-nausea',
    'is_favorited': Random().nextBool(),
    'price': 38,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to prevent and treat nausea and vomiting associated with various conditions.",
    "company": "EaseUp Pharmaceuticals",
    "section": "Gastrointestinal",
    "color": "Yellow",
    "number": 95,
    "type": "Syrup"
  },
  {
    'name': 'Anti-allergy',
    'is_favorited': Random().nextBool(),
    'price': 90,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Used to treat allergic reactions by blocking the action of histamine.",
    "company": "AllerGone Labs",
    "section": "Allergy",
    "color": "Red",
    "number": 85,
    "type": "Capsule"
  },
  {
    'name': 'Anti-fungal',
    'is_favorited': Random().nextBool(),
    'price': 35,
    'image':
        'https://images.pexels.com/photos/3683081/pexels-photo-3683081.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    "description":
        "Effective in treating fungal infections of the skin, hair, and nails by killing the fungal cells.",
    "company": "FungiFree Inc.",
    "section": "Antifungal",
    "color": "Blue",
    "number": 50,
    "type": "Cream"
  },
];

void uploadData() async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  for (var product in populars) {
    await db.collection('product').add(product);
  }

  for (var product in news) {
    await db.collection('product').add(product);
  }
}
