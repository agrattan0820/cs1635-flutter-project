import 'package:flutter/material.dart';
import 'package:grosseries/models/food_category.dart';
import 'package:grosseries/models/food_item.dart';
import 'package:grosseries/view_models/food_category_view_model.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/food_add_form.dart';
import '../components/food_category_card.dart';

class AddFoodCategoryView extends StatefulWidget {
  const AddFoodCategoryView({super.key});

  @override
  State<AddFoodCategoryView> createState() => _AddFoodCategoryViewState();
}

class _AddFoodCategoryViewState extends State<AddFoodCategoryView> {
  FoodCategory? _selectedCategory;

  List<FoodItem>? _filteredList;

  void _onCardTapped(FoodCategory category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  static String _foodItemDisplay(FoodItem item) => item.name;

  @override
  Widget build(BuildContext context) {
    var foodItems = context.watch<FoodItemViewModel>().foodItems;
    var foodCategories = context.watch<FoodCategoryViewModel>().foodCategories;

    void onFoodSelection(FoodItem item) {
      debugPrint('You just selected ${_foodItemDisplay(item)}');
      context.read<FoodItemViewModel>().updateSelectedFoodItem(item);
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 600,
              decoration: BoxDecoration(color: Colors.yellow[100]),
              padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
              child: FoodAddForm(foodItem: item),
            );
          });
    }

    void getFilteredList(List<FoodItem> inputlist) {
      if (_selectedCategory != null) {
        List<FoodItem> outputList = inputlist
            .where(
                (o) => foodCategories[o.category].id == _selectedCategory?.id)
            .toList();

        setState(() {
          _filteredList = outputList;
        });
      } else {
        setState(() {
          _filteredList = inputlist;
        });
      }
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
        color: Colors.yellow[200],
        child: Center(
          child: Column(
            children: [
              Autocomplete(
                displayStringForOption: _foodItemDisplay,
                optionsBuilder: ((textEditingValue) {
                  if (textEditingValue.text == "") {
                    return const Iterable<FoodItem>.empty();
                  }
                  return foodItems.where((FoodItem item) {
                    return item.name
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                }),
                optionsViewBuilder: (context, onAutoCompleteSelect, options) {
                  return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                        elevation: 0,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 200,
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              itemCount: options.length,
                              separatorBuilder: (context, i) {
                                return const Divider();
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final FoodItem option =
                                    options.elementAt(index);
                                return ListTile(
                                  onTap: () => onFoodSelection(option),
                                  title: Text(option.name),
                                  trailing:
                                      foodCategories[option.category].icon,
                                  // child: Padding(
                                  //   padding: const EdgeInsets.all(16.0),
                                  //   child: Text(option.name),
                                  // ),
                                );
                              },
                            )),
                      ));
                },
                onSelected: (FoodItem selection) {
                  onFoodSelection(selection);
                },
                fieldViewBuilder: ((context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                      debugPrint("You just typed a new entry $value");
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(16),
                        width: 16,
                        child: Icon(
                          Icons.search,
                          color: Colors.yellow[800],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 24,
              ),
              _selectedCategory != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (() => setState(() {
                                  _selectedCategory = null;
                                })),
                            child: const FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              size: 24,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Container(
                              transform:
                                  Matrix4.translationValues(-18.0, 0.0, 0.0),
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              decoration: BoxDecoration(
                                  color: _selectedCategory?.color[100],
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                _selectedCategory?.name ?? "Category",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              _selectedCategory != null && _filteredList != null
                  ? Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListView.separated(
                          itemCount: _filteredList!.length,
                          separatorBuilder: (context, i) {
                            return const Divider();
                          },
                          itemBuilder: (((context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                title: Text(_filteredList![index].name),
                                onTap: () =>
                                    onFoodSelection(_filteredList![index]),
                                // trailing: CircleAvatar(
                                //   backgroundImage:
                                //       NetworkImage(foodItems[index].image),
                                // ),
                              ),
                            );
                          })),
                        ),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: foodCategories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FoodCategoryCard(
                                text: foodCategories[index].name,
                                cardColor: foodCategories[index].color,
                                icon: foodCategories[index].icon,
                                onPress: () {
                                  _onCardTapped(foodCategories[index]);
                                  getFilteredList(foodItems);
                                }),
                          );
                        }),
                      ),
                    )
              // const FoodAddForm()
            ],
          ),
        ),
      ),
    );
  }
}
