import 'package:flutter/material.dart';

Map<String, dynamic> _categories = {
  "responseCode": "1",
  "responseText": "List categories.",
  "responseBody": [
    {"category_id": "1", "category_name": "Meditation"},
    {"category_id": "2", "category_name": "Anxiety"},
    {"category_id": "3", "category_name": "Bipolar Disorder (BPD)"},
    {"category_id": "4", "category_name": "Depression"},
    {"category_id": "5", "category_name": "PTSD"},
  ],
  "responseTotalResult": 5
};
Map<String, dynamic> _description = {
  "responseCode": "1",
  "responseText": "List categories.",
  "responseBody": [
    {"category_id": "1", "description": "Go here for a quick exercise"},
    {"category_id": "2", "description": "Find ways to reduce your anxiety"},
    {"category_id": "3", "description": "Find ways to deal with your BPD"},
    {"category_id": "4", "description": "Find ways to fight your depression"},
    {
      "category_id": "5",
      "description": "Please seek professional if you suffer from severe PTSD"
    },
  ],
  "responseTotalResult": 5
};
