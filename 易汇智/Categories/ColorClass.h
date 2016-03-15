//
//  ColorClass.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#ifndef GeneralFramework_ColorClass_h
#define GeneralFramework_ColorClass_h
/**
 *  颜色
 */
#define RGB(r, g, b)                    [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]
#define kDefaultEmptyTextColor          RGB(122, 122, 122)      //列表为空时的提醒文字颜色
#define kDefaultViewColor               RGB(236, 236, 236)      //self.view的默认背景颜色

#endif
