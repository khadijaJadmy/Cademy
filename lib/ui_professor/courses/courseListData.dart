class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.category = '',
    this.price = '',
    this.langue = '',
    this.rating = 4.5,
    this.creator = '',
  });

  String imagePath;
  String titleTxt;
  String category;
  String price;
  double rating;
  String langue;
  String creator;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath:
          'https://datact.io/wp-content/uploads/2019/11/python_classic.jpg',
      titleTxt: 'Python',
      category: 'Programmation',
      price: '788',
      langue: 'Arabe',
      rating: 4.4,
      creator: 'Dr.Sabry',
    ),
    HotelListData(
      imagePath:
          'https://www.frontguys.fr/wp-content/uploads/2020/06/Couverture3_Figma.jpg',
      titleTxt: 'Design',
      category: 'Figma',
      price: '678',
      langue: 'English',
      rating: 4.4,
      creator: 'Dr.Mouchawrb',
    ),
    HotelListData(
      imagePath:
          'https://www.mathweb.fr/euclide/wp-content/uploads/2019/06/maths.jpg',
      titleTxt: 'Proba',
      category: 'Maths',
      price: '470',
      langue: 'Français',
      rating: 4.4,
      creator: 'Dr.Nagid',
    ),
    HotelListData(
      imagePath:
          'https://cdn01.alison-static.net/courses/1816/alison_courseware_intro_1816.jpg',
      titleTxt: 'Algebra',
      category: 'Maths',
      price: '350',
      langue: 'Français',
      rating: 4.4,
      creator: 'Dr.Sami',
    ),
    HotelListData(
      imagePath: 'https://itexpert.fr/content/images/2021/02/Miniature-1.png',
      titleTxt: 'Design Pattern',
      category: 'IHM',
      price: '200',
      langue: 'Anglais',
      rating: 4.4,
      creator: 'Dr.Jack',
    ),
  ];
}
