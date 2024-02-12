import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmashots/Constants/Constant.dart';
import 'package:pharmashots/Constants/color_resource.dart';
import 'package:pharmashots/Constants/components.dart';
import 'package:pharmashots/Constants/fonts.dart';
import 'package:pharmashots/Posts/postModal.dart';
import 'package:pharmashots/Widget/post_bookmark_widget.dart';

class categoryTabpostlistwidget extends StatelessWidget {
  PostModal postlist;
  List<PostModal>? allpost;
  int? read_index;
  String? read_mode="web";
  String show_category;
  categoryTabpostlistwidget(

      @required this.postlist,
      {
        this.allpost,
        this.show_category ="no",
        this.read_index,
        this.read_mode,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 228,
          width: MediaQuery.of(context).size.width * 75,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(22),
          // ),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                      onTap: (){
                        var link=  MAIN_URL+"/"+postlist.Id.toString()+"/"+postlist.slug.toString();
                        link=postlist.fulllink.toString();
                        if(read_mode=="web"){
                          openInAppWeb(context,link);
                        }else{
                          print("ok");
                          openInReadPost(context,allpost!,read_index!);
                        }

                      },
                      child:Container(
                        height: 162,
                       // width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image:
                            NetworkImage(postlist.image_url.toString()),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ))),
              Positioned(
                right: 0,
                bottom: 0,
                left: 0,
                top: 168,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .64,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              var link=  MAIN_URL+"/"+postlist.Id.toString()+"/"+postlist.slug.toString();
                              if(read_mode=="web"){
                                openInAppWeb(context,link);
                              }else{
                                openInReadPost(context,allpost!,read_index!);
                              }
                            },
                            child:Text(
                              postlist.title.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: FormaDJRDisplayBold.copyWith(
                                color: ColorResources.BLACK,
                              ),
                            )),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,top: 4),
                          child: Row(
                            children: [
                              if(show_category=="yes")
                                InkWell(
                                  onTap: () {
                                   // Navigator.pushReplacement(
                                   //     context,
                                   //     MaterialPageRoute(
                                   //         builder: (BuildContext context) =>
                                   //             PostByCategory(
                                   //               title: postlist.catlist![0].category_name.toString(),
                                   //               catId: int.parse(postlist.catlist![0].id.toString()),
                                   //             )));
                                  },
                                  child:postlist.catlist!.length > 0?Text(postlist.catlist![0].category_name.toString(),style: HelveticaBold.copyWith(
                                    color: ColorResources.Orange,
                                  ),):Container(),
                                ),
                              // Container(
                              // width: MediaQuery.of(context).size.width-100,
                              // height: 30,
                              // child:ListView.builder(
                              // scrollDirection: Axis.horizontal,
                              // itemBuilder: (ctx,index){
                              // return Text(postlist.catlist![index].category_name.toString(),style: HelveticaBold.copyWith(
                              //     color: ColorResources.Orange,
                              //   ),);
                              // },
                              //   itemCount:postlist.catlist!.length,
                              // )
                              //   ,
                              // ),
                              Spacer(),
                              //  Icon(Icons.share),
                              InkWell(
                                  onTap:(){
                                    var link=  MAIN_URL+"/"+postlist.Id.toString()+"/"+postlist.slug.toString();
                                    var t=postlist.title.toString()+" "+link;
                                    onShare(context,postlist.title.toString(),t.toString());

                                  },
                                  child:SvgPicture.asset(
                                    'assets/images/icons svg/Icon-feather-share.svg',
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                width: 12,
                              ),
                              // Icon(Icons.bookmark),
                              PostBookmarkWidget(iSBookmarked: postlist.is_bookmarked,Id: postlist.Id.toString(),color: Colors.black,h: 14,w: 13,),

                              // SvgPicture.asset('assets/images/icons svg/Icon ionic-ios-bookmark.svg',
                              //   height: 15,
                              //   width: 14,
                              // ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
