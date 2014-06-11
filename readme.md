班级通讯录
需求：
1、window的根视图控制器展示通讯录列表，每行展示头像和姓名和手机号(†)
2、点击某个联系人，可以展示详情页面，详情页面展示联系人的详细信息，包括：头像、姓名、性别、年龄、电话。(†)
3、联系人根据姓名拼音的首字母分组。(†)
4、按照MVC的设计模式完成作业。定义Model类，提供数据。(†)

最新作业需求:
1、通讯录页面分组展示所有联系人，每行cell展示联系人头像、联系人姓名、联系人电话号码(†)
2、通讯录列表中的数据可以删除，通过侧滑cell实现删除(†)
3、通讯录列表页面的导航栏设置，title：通讯录，右侧按钮：+，点击导航栏右侧按钮，push推出“添加联系人”页面(†)
4、点击通讯录列表页面中的cell，push推出“联系人详情页面”(†)
5、添加联系人页面导航栏右侧设置“完成”按钮，点击“完成”按钮，保存新联系人信息，并返回通讯录列表页面。直接点击返回按钮，不保存联系人信息，直接返回通讯录列表页面。(†)
6、添加联系人页面：点击imageView，从系统相册中获取图片，设置为联系人头像。相关类：UIImagePickerController(†)
7、添加联系人页面：输入年龄和联系方式的textField使用数字键盘(†)


附加需求(DIY):
模型类:
* 可以从一个文件初始化数据(†)
* 提供把数据写入数据源文件的方法(†)


优化方向:
* 单独的数据源,应用于导航栏控制器.(†)
* 查看详情页面,提供"编辑功能" + 合并"详细信息页和添加联系人页" 为"编辑页".(†)
* 点击"return" 键盘消失!(†)
* 编辑练习人信息时,如果页面正处于编辑状态,则弹窗提示是否确定离开!(†)
* 点击返回按钮,也能回收键盘.
* 能自动判断输入是否符合规则.
* 编辑页,右按钮在"保存"和"编辑"间切换!(†)
* 最后两个编辑框,禁止输入非数字.
* 设置app应用图标.
* 删除联系人时,出现弹出框提示.
* 使用KVO机制(†)

* 给方法分一下组!

作业需求:
*、UITableView使用两种cell分别展示男和女(†)
*、每行cell上展示头像、姓名、联系方式、介绍。cell需要自适应高度。(†)
* 重要更新:监听person!而不是监听数据源!
*.设置分区索引(†)
* AddressBookView和Modal的本身的命名容易引起误解!
* 重建建立group和文件夹的关联性,同时调整一下文件夹组织方式.
* 应该存在一个默认文件路径,文件不存在,可以自己创建;文件数据为空时,不应该影响程序的运行.因为可能确实没有数据.
* 把通讯录主页面作为单例,充当控制器?可以使用NSObject作为单例?
* 添加联系人页面,第一次点击,应该自动清除或者全选原来的"提示信息".
* 程序在3.5下运行会报错!