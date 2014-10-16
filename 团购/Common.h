
//dock上条目的尺寸
#define kDockItemW 100
#define kDOckItemH 80

//topMenu尺寸
#define kTopMenuButtonW 120
#define kTopMenuButtonH 44

//下拉button尺寸
#define kDropButtonW 120
#define kDropButtonH 70

//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define MyLog(...)

// 城市改变的通知
#define kCityChangeNote @"cityChange"
#define kDistrictChangeNote @"districtChange"
#define kCategoryChangeNote @"categoryChange"
#define kOrderChangeNote @"orderChange"



// 城市的key
#define kCityKey @"city"

#endif