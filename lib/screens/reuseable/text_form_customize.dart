import 'package:admin/constants.dart';
import 'package:admin/models/Cast.dart';
import 'package:admin/models/Category.dart';
import 'package:admin/models/Country.dart';
import 'package:admin/models/Director.dart';
import 'package:admin/models/Keyword.dart';
import 'package:admin/models/Language.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';


class TextEditFormFill extends StatefulWidget {
  TextInputType inputType;
  TextEditingController controller;
  String initValue;
  double height;
  double width;
  String hintText;
  String labelText;
  Widget suffixIcon;
  Function onTap;
  Color color;
  Color backgroundColor;
  int maxLine;
  bool dropdownBox;
  bool readOnly;
  String helperText;
  bool obscureText;
  var data;

  TextEditFormFill({
    this.controller,
    this.initValue,
    this.height = 48,
    this.width,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.color,
    this.backgroundColor = secondaryColor,
    this.maxLine = 100,
    this.readOnly = false,
    this.onTap,
    this.dropdownBox = false,
    this.helperText,
    this.obscureText = true,
    this.data = null,
    this.inputType = TextInputType.text,
  });

  @override
  _TextEditFormFillState createState() => _TextEditFormFillState();
}

class _TextEditFormFillState extends State<TextEditFormFill> with SingleTickerProviderStateMixin {
  int page = 1;
  int perPage = 20;
  int pages = 1;
  var totalRows;

  var data;
  List rows;

  bool _isTyping = false;
  bool _isOpenDropdown = false;

  GlobalKey _key;
  bool isDropDownOpen = false;
  Offset dropPosition;
  Size fieldSize;
  OverlayEntry _overlayEntry;
  BorderRadius _borderRadius;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    widget.controller.addListener(_textEditListener);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = BorderRadius.circular(defaultBorderRadius);
    super.initState();
    rows = widget.data;
  }

  _textEditListener() {
    if (widget.controller.text != '') {
      _isTyping = true;
      _fetchData();
      if(!isDropDownOpen && rows!=null)
        openDropDown();
    } else {
      _isTyping = false;
      if(isDropDownOpen)
        closeDropDown();
    }
    setState(() {});
  }

  _dropdownOnTap(){
    if(rows!=null)
      isDropDownOpen?closeDropDown():openDropDown();
  }

  void closeDropDown() {
    _overlayEntry.remove();
    _animationController.reverse();
    isDropDownOpen = !isDropDownOpen;
  }

  findButton() {
    RenderBox renderBox = context.findRenderObject();
    fieldSize = renderBox.size;
    dropPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openDropDown() {
    findButton();
    _overlayEntry = dropdown();
    Overlay.of(context).insert(_overlayEntry);
    isDropDownOpen = !isDropDownOpen;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  _fetchData() async {
    switch (widget.labelText) {
      case 'title':
        break;
      case 'Categories':
        Category.filter_params['q'] = widget.controller.text;
        data = (await Category.find())['data'];
        break;
      case 'Casts':
        Cast.filter_params['q'] = widget.controller.text;
        data = (await Cast.find())['data'];
        break;
      case 'Languages':
        Language.filter_params['q'] = widget.controller.text;
        data = (await Language.find())['data'];
        break;
      case 'Countries':
        Country.filter_params['q'] = widget.controller.text;
        data = (await Country.find())['data'];
        break;
      case 'Directors':
        Director.filter_params['q'] = widget.controller.text;
        data = (await Director.find())['data'];
        break;
      default:
        break;
    }
    if(data !=null){
      totalRows = data['totalRows'];
      pages = (totalRows / perPage).ceil();
      rows = data['data'];
    }

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.labelText ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: widget.height,
            width: widget.width ?? MediaQuery.of(context).size.width,
            // width: width ?? MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius:  BorderRadius.circular(defaultBorderRadius)),
            child: TextFormField(
              keyboardType: widget.inputType ,
              initialValue: widget.initValue,
              controller: widget.controller,
              cursorColor: Colors.white,
              style: TextStyle(fontSize: 12.0),
              obscureText: !widget.obscureText,
              onTap: widget.onTap ?? (widget.dropdownBox?_dropdownOnTap:null),
              readOnly: widget.readOnly,
              minLines: 1,
              maxLines: widget.maxLine,
              decoration: InputDecoration(
                  hintText: widget.hintText ?? '',
                  helperText: widget.helperText,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  suffixIcon: widget.suffixIcon ?? cleanText()),
            ),
          ),
        ],
      ),
    );
  }

  cleanText() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _isTyping ? 30 : 0.0,
      height: _isTyping ? 30 : 0.0,
      child: _isTyping
          ? InkWell(
              onTap: () {
                widget.controller.text = '';
              },
              child: Icon(Icons.cancel),
            )
          : null,
    );
  }

  OverlayEntry dropdown() {
    return OverlayEntry(
      builder: (context){
        return Positioned(
          top: dropPosition.dy + fieldSize.height,
          left: dropPosition.dx,
          width: fieldSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                  padding: const EdgeInsets.only(top: defaultPadding),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: _borderRadius,
                  ),
                  child: Theme(
                    data: ThemeData(
                      iconTheme: IconThemeData(
                        color: primaryColor,
                      ),
                    ),
                    child: Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: rows.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              widget.controller.text = rows[index]['name'];
                              closeDropDown();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              width: MediaQuery.of(context).size.width,
                              height: 40.0,
                              child: dropdownItem(rows[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  dropdownItem(data){
    print(data);
    return Text(data['name'].toString());
  }
}



//----------------------------------------------------------------
class InputTag extends StatefulWidget {
  String title;
  List<String> suggestionItems;
  Function addItem;
  Function removeItem;

  InputTag({ 
    Key key,
    this.title,
    this.suggestionItems,
    this.addItem,
    this.removeItem,
     }) : super(key: key);

  @override
  _InputTagState createState() => _InputTagState();
}

class _InputTagState extends State<InputTag> {
  List _items = [];
  List<String> _suggestionItems; 

  String _currentStarInput = '';
  double _fontSize = 14;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  void initState() {
   _suggestionItems = widget.suggestionItems;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(widget.title)
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: defaultPadding),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Tags(
                    key:_tagStateKey,
                    itemCount: _items.length,
                    heightHorizontalScroll: 48,
                    horizontalScroll: true, 
                    spacing: 2,
                    textField: TagsTextField(
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      autofocus: false,
                      textStyle: TextStyle(fontSize: _fontSize),
                      constraintSuggestion: true,
                      suggestions: _suggestionItems,
                      onSubmitted: (str) {
                        setState(() {
                          _items.add(Item(title: str,));
                        });
                        print(_items);
                        widget.addItem(str);
                      },
                      onChanged: (str) {
                        setState(() {
                          _currentStarInput = str;
                        });
                      }
                    ),                           
                    itemBuilder: (index){          
                          final Item item = _items[index];
                          return ItemTags(
                                index: index,
                                title: item.title,
                                customData: item.customData,
                                textStyle: TextStyle( fontSize: _fontSize,),  
                                removeButton: ItemTagsRemoveButton(
                                  onRemoved: (){
                                      setState(() {
                                          _items.removeAt(index);
                                          widget.removeItem(index);
                                      });
                                      return true;
                                  },
                                ),
                                onPressed: (item) => print(item),
                          );
                  
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showDialog();
                    },
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  _showDialog() {
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          title: Text('Are you sure?'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  _items.add(Item(title: _currentStarInput));
                  _suggestionItems.add(_currentStarInput);
                  widget.addItem(_currentStarInput);
                });
                Navigator.pop(context);
              }
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              }
            )
          ],
        );
      });
  }
}