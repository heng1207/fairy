//
//  CommonTool.m
//  UME
//
//  Created by XY on 2018/1/12.
//  Copyright © 2018年 XY. All rights reserved.
//

#import "CommonTool.h"

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"


@implementation CommonTool
+ (BOOL)isLogin
{
    NSString *token = [kUserDefaults objectForKey:kToken];
    if ([self isNullToString:token])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (void)MsgBox:(NSString *)msg WithView:(UIView*)view
{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    hud.detailsLabel.text=msg;
    [hud hideAnimated:YES afterDelay:1.5];
    
}

//判断是否为正确邮箱
+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}


// 从身份中截取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

//生成二维码
+ (UIImage *)createQRCodeForString:(NSString *)qrString withImageViewSize:(CGSize)size{
    NSData * stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter * qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    //容错率  “L”：7% “M”：15% “Q”：25% “H”：30% QR码有容错能力，QR码图形如果有破损，仍然可以被机器读取内容，最高可以到7%~30%面积破损仍可被读取，所以很多二维码的中间都有头像之类的图片但仍然可以识别
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    //二维码大小
    CGRect extent = CGRectIntegral(qrFilter.outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:qrFilter.outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaleImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage * image = [UIImage imageWithCGImage:scaleImage];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaleImage);
    return image;
}

//判断手机号
+ (BOOL)isTelePhone:(NSString*)TelePhone
{
    //^[\u4e00-\u9fa5]{1,7}$|^[\dA-Za-z_]{1,14}$
    NSString *NameCheck = @"^1(3|4|5|7|8)\\d{9}$";
    NSPredicate *NameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",NameCheck];
    return [NameTest evaluateWithObject:TelePhone];
    
}
//是否为空
+ (BOOL)isNullToString:(id)string
{
    NSString *str = [NSString stringWithFormat:@"%@",string];
    
    if ([str isEqual:@"NULL"] || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqual:NULL] || [[str class] isSubclassOfClass:[NSNull class]] || str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"])
    {
        return YES;
        
    }
    else
    {
        
        return NO;
    }
}

//获取内容的宽高
+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.height;
}

+ (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}

/**
 *  只限制字母和数字
 */
+ (BOOL)onlyAllowLettersAndNumbers:(NSString *)string
{
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
}

/**
 *  判断是不是手机号
 */
+ (NSString *)valiMobile:(NSString *)mobile
{
    if (mobile.length < 11)
    {
        return @"手机号不正确,请输入正确的手机号码";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3)
        {
            return @"正确";
        }else
        {
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}

+ (NSString *)YYMMDDtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+ (NSString *)YYMMDDGGGtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+ (NSString *)DDYYMMDDGGGtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)YYYYMMtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)MMDDHHmmtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH: mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)HHmmtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)YYYYMMDDHHmmtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)YYYYMMddHHtimeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 *  获取当前天数时间几点几分的时间戳
 *
 *  @return return 时间戳
 */
+ (NSTimeInterval)setCurrentlyDaySetHour:(NSInteger)hour setMinute:(NSInteger)minute setSec:(NSInteger)sec
{
    if (hour == 24) {//如果是24时，则是第二天的00点，所以做细微处理
        hour = 23;
        minute = 59;
        sec = 59;
    }
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [greCalendar setTimeZone: timeZone];
    
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
    
    //  定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setDay:dateComponents.day];
    [dateComponentsForDate setMonth:dateComponents.month];
    [dateComponentsForDate setYear:dateComponents.year];
    [dateComponentsForDate setHour:hour];
    [dateComponentsForDate setMinute:minute];
    [dateComponentsForDate setSecond:sec];
    
    NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
    
    return [dateFromDateComponentsForDate timeIntervalSince1970];
}

/**
 *  获取时间，并转换为字符串
 *
 *  @return return 返回字符串
 */
+ (NSString *)stringFromDateSetDateFormat:(NSString *)formatString
{
    NSDate *date =[NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatString];//设置时间显示的格式，此处使用的formater格式要与字符串格式完全一致，否则转换失败
    NSString *dateStr = [formater stringFromDate:date];//将日期转换成字符串
    return dateStr;
}

+ (NSString *)updateTimeForTimestamp:(NSString *)timestamp {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [timestamp integerValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60)
    {
        return @"刚刚";
    }
    
    NSInteger mins = time/60;
    if (mins < 60)
    {
        return [NSString stringWithFormat:@"%ld分钟前",mins];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

+ (NSMutableAttributedString *)transformWithStr:(NSString *)str Index:(NSInteger)index Length:(NSInteger)length Color:(UIColor *)color
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(index,length)];
    return attributedStr;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSData *)toJSONData:(id)theData
{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+ (UIImage *)imageFromURLString:(NSString *)urlstring
{
    return [UIImage imageWithData:[NSData  dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

+ (NSMutableAttributedString *)compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *timeStr;
    NSMutableAttributedString *result;
    if (timeInterval < 60) {
        timeStr = [NSString stringWithFormat:@"刚刚"];
        result = [self transformWithStr:timeStr Index:0 Length:0 Color:[UIColor similarRedColor]];
        
    }
    else if((temp = timeInterval/60) <60){
//        NSString *tempStr = [NSString stringWithFormat:@"%d",temp];
//        timeStr = [NSString stringWithFormat:@"%d分钟前发布",temp];
//        result = [self transformWithStr:timeStr Index:0 Length:tempStr.length Color:[UIColor similarRedColor]];
        NSString *tempStr = @"";
        timeStr = [NSString stringWithFormat:@"今天发布",temp];
        
        result = [self transformWithStr:timeStr Index:0 Length:tempStr.length Color:[UIColor similarRedColor]];
    }

    else if((temp = temp/60) <24){
//        NSString *tempStr = [NSString stringWithFormat:@"%d",temp];
//        timeStr = [NSString stringWithFormat:@"%d小时前发布",temp];
        NSString *tempStr = @"";
        timeStr = [NSString stringWithFormat:@"今天发布",temp];

        result = [self transformWithStr:timeStr Index:0 Length:tempStr.length Color:[UIColor similarRedColor]];

    }
    
    else if((temp = temp/24) <30){
        NSString *tempStr = [NSString stringWithFormat:@"%d",temp];
        timeStr = [NSString stringWithFormat:@"%d天前发布",temp];
        result = [self transformWithStr:timeStr Index:0 Length:tempStr.length Color:[UIColor similarRedColor]];

    }
    
    else if((temp = temp/30) <12){
        NSString *tempStr = [NSString stringWithFormat:@"%d",temp];
        timeStr = [NSString stringWithFormat:@"%d月前发布",temp];
        result = [self transformWithStr:timeStr Index:0 Length:tempStr.length Color:[UIColor similarRedColor]];

    }
    else{
        temp = temp/12;
        NSString *tempStr = [NSString stringWithFormat:@"%d",temp];
        timeStr = [NSString stringWithFormat:@"%d年前发布",temp];
        result = [self transformWithStr:timeStr Index:0 Length:tempStr.length Color:[UIColor similarRedColor]];
    }
    
    return  result;
}

+ (NSString *)compareCurrentTimeStr:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
}

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDate *startDate = [self stringToDate:startTime];
    NSDate *endDate = [self stringToDate:endTime];
    //计算两个中间差值
    NSInteger day = [self numberOfDaysWithFromDate:startDate toDate:endDate];
    NSString * dateValue = [NSString stringWithFormat:@"%d",day];
    return dateValue;
}

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    NSLog(@" -- >>  comp : %@  << --",comp);
    return comp.day;
    
}

//字符串转日期
+ (NSDate *)stringToDate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil]];
    
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}

+ (NSMutableDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString
{
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSArray *FirstArr=[AllString componentsSeparatedByString:FirstSeparateString];
    
    for (int i=0; i<FirstArr.count; i++) {
        NSString *Firststr=FirstArr[i];
        NSArray *SecondArr=[Firststr componentsSeparatedByString:SecondSeparateString];
        [dic setObject:SecondArr[1] forKey:SecondArr[0]];
        
    }
    
    return dic;
}

+ (UIImage *)getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays =
    [NSArray arrayWithObjects:
     [NSNull null], @"周日", @"周一", @"周二", @"周三",@"周四", @"周五", @"周六", nil];
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     
     NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
     
     [calendar setTimeZone: timeZone];
     
     NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
     
     NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
     
     return [weekdays objectAtIndex:theComponents.weekday];
     
    }
     
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}


@end
