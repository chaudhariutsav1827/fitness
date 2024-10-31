import 'package:fitness/models/category_model.dart';
import 'package:fitness/models/diet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
  }

  @override
  void initState() {
    _getInitialInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          searchField(),
          const SizedBox(height: 40),
          categorySection(categories),
          const SizedBox(height: 40),
          dietSection(diets),
        ],
      ),
    );
  }
}

Widget dietSection(List<DietModel> diets) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "Recommendation\nfor diet",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: diets.length,
          itemBuilder: (context, index) {
            DietModel diet = diets[index];
            return dietItem(diet);
          },
        ),
      ),
    ],
  );
}

Widget dietItem(DietModel diet) {
  return Container(
    width: 210,
    margin: const EdgeInsets.only(left: 25, right: 25),
    decoration: BoxDecoration(
      color: diet.boxColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(diet.iconPath),
        Text(
          diet.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        Text(
          "${diet.level} | ${diet.duration} | ${diet.calorie}",
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xff786F72),
            fontSize: 13,
          ),
        ),
        GestureDetector(
          child: Container(
            height: 45,
            width: 130,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  diet.viewIsSelected
                      ? const Color(0xff9DCEFF)
                      : Colors.transparent,
                  diet.viewIsSelected
                      ? const Color(0xff92A3FD)
                      : Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                "view",
                style: TextStyle(
                    color: diet.viewIsSelected
                        ? Colors.white
                        : const Color(0xffc588F2),
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget categorySection(List<CategoryModel> categories) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "Category",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            CategoryModel category = categories[index];
            return categoryItem(category);
          },
        ),
      ),
    ],
  );
}

Widget categoryItem(CategoryModel category) {
  return Container(
    width: 100,
    margin: const EdgeInsets.only(left: 25, right: 25),
    padding: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
      color: category.boxColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(category.iconPath),
          ),
        ),
        Text(
          category.name,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

AppBar appBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    title: const Text(
      "Breakfast",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          "assets/icons/Arrow-Left2.svg",
          height: 20,
          width: 20,
        ),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            "assets/icons/dots.svg",
            height: 5,
            width: 5,
          ),
        ),
      ),
    ],
  );
}

Widget searchField() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0,
        ),
      ],
    ),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        hintText: "Search Pancake",
        hintStyle: const TextStyle(
          color: Color(0xffDDDADA),
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/icons/Search.svg",
          ),
        ),
        suffixIcon: SizedBox(
          width: 100,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const VerticalDivider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset("assets/icons/Filter.svg"),
                ),
              ],
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
