#ZJGenWoYou

> 轮播图的使用
``` 
  =========   轮播图调用该方法 =========
        let customView = CustomSliderView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 300), type: SliderViewSourceType.SourceTypeLocalSource, imageArray: imageArray, sliderTime: 3.0)
        customView.delegate = self
        self.view.addSubview(customView)
```

> SDWebImage 的导入
> 1. 上网下载SDWebImage包。下载地址：https://github.com/rs/SDWebImage
> 2. 找到SDWebImage.xcodeproj，并加入项目中
> 3. 在Build Phases中的Link Binary With Libraries选项卡中，加入ImageIO.framework、libSDWebImage.a
> 4. 在Build Settings中的Linking选项卡中找到Other Linker Flags，双击右边区域，在弹出的框中点击+按钮，输入-ObjC
> 5. 在我们的项目中添加一个h文件，取名为“SDWebImage+Header.h”，打开头文件，引入#import <SDWebImage/UIImageView+WebCache.h>
> 6. 在Build Settings 中 找到并双击Object-C Bridging Header 输入相对路径（"$(SRCROOT)/当前工程名字/需要包含头文件所在文件夹"）


