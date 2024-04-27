import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/api_helper_client.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../common/api_helper.dart';
import '../../common/pref_manager.dart';


class CreateBlogsScreen extends StatefulWidget {
  const CreateBlogsScreen({super.key});

  @override
  State<CreateBlogsScreen> createState() => _CreateBlogsScreenState();
}

class _CreateBlogsScreenState extends State<CreateBlogsScreen> {
  var blogTitleController=TextEditingController();
  HtmlEditorController controller = HtmlEditorController();

  String path = "";
  XFile? _imageFiler;
  final ImagePicker _picker = ImagePicker();
  var type;
  var getHtmlText='';

  Future<String> getToken() async {
    var token = "";
    await PrefManager.getUserData().then((value) => {
      debugPrint("Token------------>${value.token}", wrapWidth: 5000),
      setState(() {
        token = value.token;
      }),
    });
    return token;
  }

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFiler = pickedFile;
      path = _imageFiler!.path;
    });
  }

  updateBlogs() async {
    var token = await getToken();
    ApiBaseClient apiBaseHelper = ApiBaseClient();

    var baseUrl = "${apiBaseHelper.appDoctorMainUrl}create_blogs";
    var uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest(
      "POST",
      uri,
    );

    request.headers["authorization"] = "Bearer $token";
    request.fields["title"] = blogTitleController.text.toString();
    request.fields["description"] = getHtmlText.toString();
    request.files.add(http.MultipartFile.fromBytes(
        'image', await File(_imageFiler!.path).readAsBytesSync(),
        filename: _imageFiler.toString().split('/').last))
    ;
    try {
      debugPrint("kjhkgkgkgh===>"+jsonEncode(request.fields));
      http.Response response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print("hfjdsgfmdfjgdfgdjkg=====>${response.body.toString()}");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${jsonDecode(response.body)['message']}")));
      } else {
        print("hfjdsgfmdfjgdfgdjkg=====>${response.body.toString()}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode}"),
          ),
        );
      }
    } catch (exception) {
      debugPrint("exception:==>$exception");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:InkWell(
        onTap: (){
          if(path==""){
            Fluttertoast.showToast(msg: "Please select image...");
          }
          else if(blogTitleController.text.isEmpty||getHtmlText==""){
            Fluttertoast.showToast(msg: "Please enter title and blog...");
          }
          else
            {
              updateBlogs();
            }

        },
        child: Container(
          width: 150,
          height: 45,
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor
          ),
          child: CustomText(text: 'Submit',color: AppColors.whiteColor,),
        ),
      ),
      appBar: DesignConfig.appBar(context, double.infinity, 'Create Blogs'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              imageWidget(),
              DesignConfig.space(h: 20),
              editBox(),
              DesignConfig.space(h: 20),
              blogEditorWidget(),
              
            ],
          ),
        ),
      ),
    );
  }



  Widget imageWidget(){
    return InkWell(
      onTap: (){
        getImage(ImageSource.gallery);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(maxHeight: 130.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
              image: FileImage(File(path)),fit: BoxFit.cover
          )
        ),
        child:path==""?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/gallery.svg'),
            CustomText(text: 'Add blog cover image',fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xFFC5C5C5),)

          ],
        ):Container(),
      ),
    );
  }
  
  Widget editBox(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(text: 'Title',fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.blackColor,),
        DesignConfig.space(h: 10),
        CustomUi.editBox('Blog Title', blogTitleController, TextInputType.text),
      ],
    );
  }

  Widget blogEditorWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomText(text: 'Blog',fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.blackColor,),
        HtmlEditor(

          controller: controller,
          htmlEditorOptions: const HtmlEditorOptions(
            hint: 'Your text here...',
            shouldEnsureVisible: true,
            //initialText: "<p>text content initial, if any</p>",
          ),
          htmlToolbarOptions: HtmlToolbarOptions(
            toolbarPosition: ToolbarPosition.aboveEditor, //by default
            toolbarType: ToolbarType.nativeScrollable, //by default
            onButtonPressed:
                (ButtonType type, bool? status, Function? updateStatus) {
              return true;
            },
            onDropdownChanged: (DropdownType type, dynamic changed,
                Function(dynamic)? updateSelectedItem) {
              return true;
            },
            mediaLinkInsertInterceptor:
                (String url, InsertFileType type) {
              print(url);
              return true;
            },
          ),
          otherOptions: OtherOptions(height: 200),
          callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
            print('html before change is $currentHtml');
          }, onChangeContent: (String? changed) {
            getHtmlText=changed.toString();
            print('content changed to $changed');
          }, onChangeCodeview: (String? changed) {
            print('code changed to $changed');
          }, onChangeSelection: (EditorSettings settings) {
            print('parent element is ${settings.parentElement}');
            print('font name is ${settings.fontName}');
          }, onDialogShown: () {
            print('dialog shown');
          }, onEnter: () {
            print('enter/return pressed');
          }, onFocus: () {
            print('editor focused');
          }, onBlur: () {
            print('editor unfocused');
          }, onBlurCodeview: () {
            print('codeview either focused or unfocused');
          }, onInit: () {
            print('init');
          },
              onImageUploadError: (FileUpload? file, String? base64Str,
                  UploadError error) {

                print(base64Str ?? '');
                if (file != null) {
                  print(file.name);
                  print(file.size);
                  print(file.type);
                }
              }, onKeyDown: (int? keyCode) {
                print('$keyCode key downed');
                print(
                    'current character count: ${controller.characterCount}');
              }, onKeyUp: (int? keyCode) {
                print('$keyCode key released');
              }, onMouseDown: () {
                print('mouse downed');
              }, onMouseUp: () {
                print('mouse released');
              }, onNavigationRequestMobile: (String url) {
                print(url);
                return NavigationActionPolicy.ALLOW;
              }, onPaste: () {
                print('pasted into editor');
              }, onScroll: () {
                print('editor scrolled');
              }),
          plugins: [
            SummernoteAtMention(
                getSuggestionsMobile: (String value) {
                  var mentions = <String>['test1', 'test2', 'test3'];
                  return mentions
                      .where((element) => element.contains(value))
                      .toList();
                },
                mentionsWeb: ['test1', 'test2', 'test3'],
                onSelect: (String value) {
                  print(value);
                }),
          ],
        ),





      ],
    );
  }
}
