//
//  JSON_API.h
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


/**
 *
 * Login User
 *
 **/
@interface Login_API : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *pseudo;
@property (nonatomic, copy) NSString *passowrd;
@end


/**
 *
 * Login User
 *
 **/
@interface Signup_API: NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthDay;
@property (nonatomic, copy) NSString *comeFrom;
@property (nonatomic, copy) NSString *registerAddress;
@property (nonatomic, copy) NSString *bussiness;
@property (nonatomic, copy) NSString *isFinancing;
@property (nonatomic, copy) NSString *aotm;
@property (nonatomic, copy) NSString *speciality;
@property (nonatomic, copy) NSString *shortSlab;
@property (nonatomic, copy) NSString *establishTime;
@property (nonatomic, copy) NSString *companyNumber;
@property (nonatomic, copy) NSString *isConsult;
@property (nonatomic, copy) NSString *isInformationOpen;
@property (nonatomic, copy) NSString *register_Address_Mame;
@property (nonatomic, copy) NSString *birthday;
@end

//------------------------------------------- University------------------------------------------- //

/**
 * University List
 * All Even function.
 * @access public
 * @return void
 * @status OK
 *  Order 1
 */

@interface School_data : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *province;
@property (nonatomic, copy)NSString *id_province;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *id_city;
@property (nonatomic, copy)NSString *photo;
@property (nonatomic, copy)NSString *hidden;
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *levelDetails;
@property (nonatomic, copy)NSString *student;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *typeDetails;
@property (nonatomic, copy)NSString *attribute;
@property (nonatomic, copy)NSString *attributeDetails;
@property (nonatomic, copy)NSString *visitors;
@property (nonatomic, copy)NSString *effective;
@property (nonatomic, copy)NSString *approuve;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *people;
@property (nonatomic, copy)NSString *is_like;

@property (nonatomic, copy)NSString *total_comments;
@property (nonatomic, copy)NSString *total_forms;
@property (nonatomic, copy)NSString *total_like;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

/**
 * Details University
 * All Even function.
 * @access public
 * @return void
 * @status OK
 *  Order 2
 */

@interface School_Details : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *cycle_id;
@property (nonatomic, copy)NSString *school_id;
@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *fee;
@property (nonatomic, copy)NSString *fee_apply;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *people;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *duration_study;
@property (nonatomic, copy)NSString *province;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *locationName;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *id_city;
@property (nonatomic, copy)NSString *photo;
@property (nonatomic, copy)NSString *cat_name;
@property (nonatomic, copy)NSString *duration;
@property (nonatomic, copy)NSString *background;
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *levelDetails;
@property (nonatomic, copy)NSString *student;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *typeDetails;
@property (nonatomic, copy)NSString *attribute;
@property (nonatomic, copy)NSString *attributeDetails;
@property (nonatomic, copy)NSString *visitors;
@property (nonatomic, copy)NSString *effective;
@property (nonatomic, copy)NSString *approuve;
@property (nonatomic, copy)NSString *climate;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *hidden;
@property (nonatomic, copy)NSString *is_like;
@property (nonatomic, copy)NSString *deleted;

@property (nonatomic, copy)NSString *admin;
@property (nonatomic, copy)NSString *air;
@property (nonatomic, copy)NSString *average;
@property (nonatomic, copy)NSString *shortDescription;
@property (nonatomic, copy)NSString *universities;
@property (nonatomic, copy)NSString *comments;
@property (nonatomic, copy)NSString *support_phone;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *phoneNumber;
@property (nonatomic, assign) NSInteger indexType;
@end

/**
 * Details University
 * All Even function.
 * @access public
 * @return void
 * @status OK
 *  Order 3
 */

@interface School_Comments: NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, strong) NSArray *create_time;
@property (nonatomic, copy) NSString *content;
@end



@interface SchoolDetail_Column_M_List : NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface SchoolDetail_Column_M : NSObject
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *CourseName;
@property (nonatomic, copy) NSString *cycle_id;
@property (nonatomic, copy) NSString *startingDate;
@property (nonatomic, copy) NSString *deadline;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *fee;
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *id;



@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSString *contents;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *create_time;

@end



@interface MasterDetail_Column_M : NSObject
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *CourseName;
@property (nonatomic, copy) NSString *startingDate;
@property (nonatomic, copy) NSString *deadline;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *fee;
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *id;

@end


@interface PhdDetail_Column_M : NSObject
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *CourseName;
@property (nonatomic, copy) NSString *startingDate;
@property (nonatomic, copy) NSString *deadline;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *fee;
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *id;

@end

//------------------------------------------- Students------------------------------------------- //

@interface StudentDetail_Column_M_List : NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

// Major User student
@interface User_major : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *major_name;
@property (nonatomic, copy) NSString *school_name;
@property (nonatomic, copy) NSString *start_study;
@property (nonatomic, copy) NSString *end_study;
@property (nonatomic, copy) NSString *mention_obtain;
@property (nonatomic, copy) NSString *deleting;
@property (nonatomic, strong) NSArray *create_time;
@end


// Profil User student
@interface User_profil : NSObject
@property (nonatomic, copy) NSString *Pid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *nationality;
@property (nonatomic, copy) NSString *passNumber;
@property (nonatomic, copy) NSString *homeAdress;
@property (nonatomic, strong) NSArray *chineseName;
@property (nonatomic, strong) NSArray *	emergencyPhone;
@property (nonatomic, strong) NSArray *emailAddress;
@property (nonatomic, strong) NSArray *fatherName;
@property (nonatomic, strong) NSArray *MotherName;
@property (nonatomic, strong) NSArray *create_time;
@end



/**
 * Student List
 * All Even function.
 * @access public
 * @return void
 * @status OK
 *  Order 1
 */

@interface Student_data : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *realname;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *head_image;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *bg_image;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *profession;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *admin;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *province_name;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *area_name;
@property (nonatomic, copy)NSString *living_in_china;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy)NSString *signup_end;
@property (nonatomic, copy)NSString *verify;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *group_name;
@property (nonatomic, copy) NSString *Codecountry;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *gender;

@end


/**
 * Details University
 * All Even function.
 * @access public
 * @return void
 * @status OK
 *  Order 2
 */

@interface Student_Details : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *cycle_id;
@property (nonatomic, copy)NSString *school_id;
@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *fee;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *people;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *province;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *locationName;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *id_city;
@property (nonatomic, copy)NSString *head_image;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *bg_image;
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *level;
@property (nonatomic, copy)NSString *levelDetails;
@property (nonatomic, copy)NSString *student;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *typeDetails;
@property (nonatomic, copy)NSString *attribute;
@property (nonatomic, copy)NSString *attributeDetails;
@property (nonatomic, copy)NSString *visitors;
@property (nonatomic, copy)NSString *effective;
@property (nonatomic, copy)NSString *approuve;
@property (nonatomic, copy)NSString *climate;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *air;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *sex;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *hiddenNote;
@property (nonatomic, copy)NSString *average;
@property (nonatomic, copy)NSString *shortDescription;
@property (nonatomic, copy)NSString *universities;
@property (nonatomic, copy)NSString *comments;
@property (nonatomic, assign) NSInteger indexType;
@property (nonatomic, copy)NSString *Codecountry;
@property (nonatomic, copy)NSString *signup_end;

@property (nonatomic, copy)NSString *realname;
@property (nonatomic, copy)NSString *profession;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *admin;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *verify;
@property (nonatomic, copy)NSString *province_name;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *area_name;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *living_in_china;
@property (nonatomic, copy)NSString *is_agence;
@property (nonatomic, assign) BOOL isShowProgress;
@property (nonatomic, copy) NSString *isShowProgressString;


@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *major_total;
@property (nonatomic, copy) NSString *comment_total;
@property (nonatomic, copy) NSString *view_total;
@property (nonatomic, strong) NSArray *honor;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *teacher_name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *is_buy;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *group_name;
@property (nonatomic, copy) NSString *total_school;
@property (nonatomic, copy) NSString *total_student;
@property (nonatomic, copy) NSString *total_application;
@property (nonatomic, copy) NSString *total_form_delete;
@property (nonatomic, copy) NSString *total_majors;
@property (nonatomic, copy) NSString *total_background;


@property (nonatomic, copy) NSString *tweet_sent;
@property (nonatomic, copy) NSString *tweet_receive;


@end




@interface StudentDetail_Column_M : NSObject
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *CourseName;
@property (nonatomic, copy) NSString *startingDate;
@property (nonatomic, copy) NSString *deadline;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *fee;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, copy) NSString *contents;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *video_url;
@property (nonatomic, assign) BOOL isOpen;


@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *major_name;
@property (nonatomic, copy) NSString *school_name;
@property (nonatomic, copy) NSString *start_study;
@property (nonatomic, copy) NSString *end_study;
@property (nonatomic, copy) NSString *mention_obtain;



@property (nonatomic, copy) NSString *nameSchool;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *head_image;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) NSArray *image_list;
@property (nonatomic, strong) NSArray *images;   // New

@end


@interface StudentDetail_Comment_M : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *head_image;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) NSArray *image_list;
@property (nonatomic, strong) NSArray *images;   // New
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *living_in_china;

@property (nonatomic, copy) NSString *photo;
@property (nonatomic, assign) BOOL *isBtnSlected;
@property (nonatomic, copy) NSString *id;
@end




// Background List
@interface BACKGROUND_IMAGES_LIST : NSObject
@property (nonatomic, strong) NSMutableArray *list;
+ (NSDictionary *)objectClassInArray;
@end


@interface Background_list : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *bg_image;
@property (nonatomic, copy) NSString *public;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *is_open;
@property (nonatomic, copy) NSString *is_apply;

// move
@property (nonatomic, copy) NSString *a_id;
@property (nonatomic, copy) NSString *head_image;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *active_info;
@property (nonatomic, copy) NSString *active_time;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *attend;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *organization;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end



// Program cycle List
@interface propertyService_topCategory_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end
// Program cycle
@interface propertyService_topCategory : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *cateid;
@property (nonatomic, copy)NSString *parentid;
//@property (nonatomic, copy)NSString *cate_name;
@property (nonatomic, copy)NSString *cat_name;


// Province
@property (nonatomic, copy)NSString *provinceid;
@property (nonatomic, copy)NSString *province_chinese;
@property (nonatomic, copy)NSString *province;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *province_description;
@property (nonatomic, copy)NSString *province_universities;

@end




// School List cat
@interface propertyService_secondCategory_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

// School List view
@interface propertyService_secondCategory : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *cateid;
@property (nonatomic, copy)NSString *parentid;

@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *fee;
@property (nonatomic, copy)NSString *cat_name;

// School name
@property (nonatomic, copy)NSString *nameSchool;

// City
@property (nonatomic, copy)NSString *locationName;
@property (nonatomic, copy)NSString *climate;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *air;
@property (nonatomic, copy)NSString *average;
@property (nonatomic, copy)NSString *shortDescription;
@property (nonatomic, copy)NSString *universities;
@property (nonatomic, copy)NSString *create_time;

@end






// All country
@interface All_Countries_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

// School List view
@interface Countries_List_view : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *countryCode;
@property (nonatomic, copy)NSString *countryName;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *currencyCode;
@property (nonatomic, copy)NSString *fipsCode;
@property (nonatomic, copy)NSString *isoNumeric;
@property (nonatomic, copy)NSString *north;
@property (nonatomic, copy)NSString *south;
@property (nonatomic, copy)NSString *east;
@property (nonatomic, copy)NSString *west;
@property (nonatomic, copy)NSString *capital;
@property (nonatomic, copy)NSString *continentName;
@property (nonatomic, copy)NSString *continent;
@property (nonatomic, copy)NSString *languages;
@property (nonatomic, copy)NSString *isoAlpha3;
@property (nonatomic, copy)NSString *geonameId;
@end



// All majors
@interface Major_M_List: NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end






@interface All_Province_List: NSObject
@property (nonatomic, strong) NSMutableArray *list;
+ (NSDictionary *)objectClassInArray;
@end

@interface Province_List_details : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *provinceid;
@property (nonatomic, copy) NSString *province_chinese;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *province_description;
@property (nonatomic, copy) NSString *province_universities;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *city_name;
@end


// Type of universities
@interface Type_Universities_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface Type_List_details : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end


@interface Attribute_Universities_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface Attribute_List_details : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *attribute;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end



@interface Teaching_languages_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface Teaching_language_details : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end


@interface Duration_study_List : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface Duration_details : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *years;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end






@interface Mobile_Config : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *qrcode_img;
@property (nonatomic, copy) NSString *fee_apply;
@property (nonatomic, copy) NSString *service_fee;
@property (nonatomic, copy) NSString *support_name;
@property (nonatomic, copy) NSString *google;
@property (nonatomic, copy) NSString *office_email;
@property (nonatomic, copy) NSString *facebook;
@property (nonatomic, copy) NSString *twitter;
@property (nonatomic, copy) NSString *instagram;
@property (nonatomic, copy) NSString *linkedln;
@property (nonatomic, copy) NSString *yahoo;
@end



/**
 * Cities List
 * All Even function.
 * @access public
 * @return void
 * @status OK
 *  Order 1
 */

@interface Cities_data : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *locationName;
@property (nonatomic, copy)NSString *climate;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *citytype;
@property (nonatomic, copy)NSString *air;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *average;
@property (nonatomic, copy)NSString *shortDescription;
@property (nonatomic, copy)NSString *universities;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *deleted;
@property (nonatomic, copy)NSString *total_school;
@property (nonatomic, copy)NSString *hidden;
@property (nonatomic, copy)NSString *is_like;
@property (nonatomic, copy)NSString *is_living;
@property (nonatomic, copy)NSString *admin;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end





@interface Users_data : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *head_image;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *realname;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *profession;
@property (nonatomic, copy)NSString *admin;
@property (nonatomic, copy)NSString *signup_end;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *facebook;
@property (nonatomic, copy)NSString *linkedln;
@property (nonatomic, copy)NSString *google;
@property (nonatomic, copy)NSString *is_disable;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *province_name;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *area_name;
@property (nonatomic, copy)NSString *homeAdress;
@property (nonatomic, copy)NSString *total_comments;
@property (nonatomic, copy)NSString *total_forms;
@property (nonatomic, copy)NSString *total_like;
@property (nonatomic, copy)NSString *bg_image;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end



@interface Users_view_data : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *head_image;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *deleted;

@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *realname;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *profession;
@property (nonatomic, copy)NSString *admin;
@property (nonatomic, copy)NSString *signup_end;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *facebook;
@property (nonatomic, copy)NSString *linkedln;
@property (nonatomic, copy)NSString *google;
@property (nonatomic, copy)NSString *sex;
@property (nonatomic, copy)NSString *is_disable;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *province_name;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *area_name;
@property (nonatomic, copy)NSString *homeAdress;
@property (nonatomic, copy)NSString *total_comments;
@property (nonatomic, copy)NSString *total_forms;
@property (nonatomic, copy)NSString *total_like;
@property (nonatomic, copy)NSString *bg_image;
@property (nonatomic, copy)NSString *birthday;
@property (nonatomic, copy)NSString *Codecountry;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@interface All_Users_list : NSObject
@property (nonatomic, strong)NSMutableArray *users;
@property (nonatomic, copy)NSString *total;
@property (nonatomic, copy)NSString *page;
@property (nonatomic, copy)NSString *uid;
+ (NSDictionary *)objectClassInArray;
@end





@interface School_description : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *photo;
@property (nonatomic, copy)NSString *cityName;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *comment_total;
@property (nonatomic, copy)NSString *like_total;


@property (nonatomic, copy)NSString *bg_image;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *verify;
@property (nonatomic, copy)NSString *realname;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *city_name;


@property (nonatomic, copy)NSString *info;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end


@interface All_comments : NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface User_list_view : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *cycle_id;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;

@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSString *contents;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end




// Move------------------------------>


@interface JiaZhengDingDanMList : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface PropertyServiceMList : NSObject
@property (nonatomic, retain) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end

@interface kuaiDiDingDanM_List : NSObject
@property (nonatomic, retain) NSMutableArray *orderInfo;
+ (NSDictionary *)objectClassInArray;
@end


@interface JiaZhengDingDanM : NSObject
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) NSString *appointid;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *contact_name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, retain)JiaZhengDingDanMList *category;
@property (nonatomic, strong) NSMutableArray *info_imgs;
@property (nonatomic, strong) NSString * attitude_score;
@property (nonatomic, assign)int is_evaluate;


// mine
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *cycle_id;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;
@property (nonatomic, copy)NSArray *image;

@property (nonatomic, copy)NSString *contents;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *tweet_open;


@end

@interface PropertyServiceM : NSObject
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) NSString *appoint;
@property (nonatomic, copy) NSString *appointid;
@property (nonatomic, copy) NSString *contact_name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, retain)propertyService_topCategory *category;
@property (nonatomic, strong) NSMutableArray *info_imgs;
@property (nonatomic, strong) NSString * attitude_score;
@property (nonatomic, assign)int is_evaluate;

// mine
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *cycle_id;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;
@property (nonatomic, copy)NSArray *image;
@property (nonatomic, copy)NSString *contents;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *tweet_open;

@end

@interface kuaiDiDingDanM : NSObject
@property (nonatomic, copy) NSString *hairid;
@property (nonatomic, copy) NSString *express_name;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *status; //0:未接受，1接受,2取消预约,3拒绝接单
@property (nonatomic, assign)int is_evaluate;
@property (nonatomic, copy) NSString *delete_time;

// mine
@property (nonatomic, copy)NSString *details;
@property (nonatomic, copy)NSString *cycle_id;
@property (nonatomic, copy)NSString *startingDate;
@property (nonatomic, copy)NSString *deadline;
@property (nonatomic, copy)NSArray *image;
@property (nonatomic, copy)NSString *contents;
@property (nonatomic, copy)NSString *fullName;
@property (nonatomic, copy)NSString *nameSchool;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, copy)NSString *nationality;
@property (nonatomic, copy)NSString *avatar_user;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *CourseName;
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *city_name;
@property (nonatomic, copy)NSString *tweet_open;

@end






@interface JiaZhengDingDanM_Category : NSObject
@property (nonatomic, copy) NSString *cate_name;
@end

@interface PropertyService_Category : NSObject
@property (nonatomic, copy) NSString *cate_name;
@end





@interface ALL_GRADUATE : NSObject
@property (nonatomic, strong) NSMutableArray *data;
+ (NSDictionary *)objectClassInArray;
@end



@interface gradutate_view : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *avatar_user;
@property (nonatomic, copy) NSString *nationality;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *authentify;

@property (nonatomic, copy) NSString *issue_type;
@property (nonatomic, copy) NSString *mID;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *p_name;
@property (nonatomic, copy) NSString *major_name;
@property (nonatomic, copy) NSString *school_name;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *start_study;
@property (nonatomic, copy) NSString *end_study;
@property (nonatomic, copy) NSString *mention_obtain;
@property (nonatomic, copy) NSString *create_time;


@end




@interface Gradutate_details : NSObject
@property (nonatomic, copy) NSString *avatar_user;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *mID;
@property (nonatomic, copy) NSString *authentify;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *p_name;
@property (nonatomic, copy) NSString *major_name;
@property (nonatomic, copy) NSString *school_name;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *end_study;
@property (nonatomic, copy) NSString *mention_obtain;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *cdkey;

@property (nonatomic, copy) NSString *nationality;
@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, strong) NSMutableArray *student;
+ (NSDictionary *)objectClassInArray;
@end



// Student_data







