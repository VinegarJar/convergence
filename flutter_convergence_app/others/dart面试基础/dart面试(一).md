
//熟悉常用的数据结构、算法、多线程，熟练使用STL等标准库；(熟悉musicxml,midi优先)

# iOS常用数据结构
1.数据结构 集合结构 线性结构 树形结构 图形结构
  1.1、集合结构：就是一个集合，就是一个圆圈中有很多个元素，元素与元素之间没有任何关系 。
  1.2、线性结构 ：就是一个条线上站着很多个人。 这条线不一定是直的。也可以是弯的。也可以是值的 相当于一条线被分成了好几段的样子。 线性结构是一对一的关系。
  1.3、树形结构 ：做开发的肯定或多或少的知道xml 解析  树形结构跟他非常类似。也可以想象成一个金字塔。树形结构是一对多的关系
  1.4、图形结构：这个就比较复杂了。 无穷、无边、 无向（没有方向）图形机构 你可以理解为多对多 类似于我们人的交集关系。
  2.数据结构的存储
    a.顺序存储结构：连续的内存地址，比如数组
   b.链式存储结构 单向链表 双向链表 循环链表
  c.二叉树/平衡二叉树

# iOS常用算法  
  算法，冒泡排序、选择排序、插入排序、快速排序、二分法查找、希尔排序、戴克斯特拉算法，快捷算法，动态规划，堆排序，归并排序。

# iOS常用多线程
  1个进程中可以开启多条线程，多条线程可以并行（同时）执行不同的任务
  iOS中多线程的实现方案
  NSThread  使用更加面向对象 。 2.简单易用，可直接操作线程对象
  GCD 旨在替代NSThread等线程技术,充分利用设备的多核 自动管理线程生命周期
  NSOperation 基于GCD（底层是GCD,比GCD多了一些更简单实用的功能,使用更加面向对象

# 关于musicxml,midi 
  Musicxml是一种开放的、基于xml的用于电子乐谱信息交换与电子乐谱发布的文件格式
  MIDI(Musical Instrument Digital Interface)乐器数字接口,MIDI是编曲界最广泛的音乐标准格式，可称为“计算机能理解的乐谱”。它用音符的数字控制信号来记录音乐

# STL等标准库
  1.主要由容器、迭代器、算法组成
   向量(vetor)
   列表(list)
   双向队列(deque)
   集合(set)
   多重集合(multiset)
   栈(stack)
   队列(queue)
   映射(map)
   



# 关于Flutter性能优化-淘宝特价版
1.流畅度优化
    优化点一:UI耗时操作处理,使用compute优化处理耗时操作,Isolate线程隔离
    疑问:可以看到，本来是很流畅的转圈，当我点击按钮计算的时候，UI出现了卡顿，为什么会出现卡顿，
    因为我们的计算默认是在UI线程中的，当我们调用countEven的时候，这个计算需要耗时，
    而在这期间，UI是没有机会去调用刷新的，因此会卡顿，计算完成后，UI恢复正常刷新
    优化点二: Loading优化点最精确的刷新范围,使用RepaintBoundary限制重绘边界,极大的提升性能
    优化点三:最合适的组件 const 包裹组件
2.内存情况优化
    优化点一:大内存之image,
        内存过大的原因,如下 
        第一点 IamgeCache
              LiveImage(正在使用中的图片);
              PendingImage(正在加载/解码中的图片);
              CacheImage(缓存中的图片);

        第二点  PlatfomRuner 
               UIRuner
               GPURuner
               IORuner(负责图片解码)

    优化点二:正确释放不要的对象
           对通知/监听体系的依赖释放问题
           eventBus.on监听要释放
           eventBus.off或者eventBus.destroy释放监听
           对监听对象context移除
           timer释放

    优化点三:针对机型分级的定制化策略
          优化低端机IamgeCache的上限
3.用户体验优化
     优化点一:CPU开销优化 
       Texture纹理渲染的高开销,在合理区间暂停动图;
       长列表滚动出屏幕时自动暂停;Flutter路由跳转时暂停;
       VisibilityDetector监听在屏状态,在当前屏幕内的比例
     优化点二:滚动手感优化



# 关于Flutter里面性能优化
1.延迟加载和延迟加载组件提升 Flutter 应用性能
优化点一: lazy loding & deferred componet组件 
优化点二:  FutureBuilder

2.利用图片占位符防止布局跳动,果你想使用一个 widget 而不是图片作为占位符，
你可以使用 Image.frameBuilder,有了占位符，布局再也不会跳来跳去了，而且图片也有了渐现效果：

3.你可以调用 precacheImage 方法来预缓存图片。

4.通过GlobalKey局部刷新方式
  StreamBuilder 实现局部刷新,达到 性能优化
  使用Provider实现 Flutter 的局部刷新，提高界面渲染性能

5.在 Flutter web app 中禁用导航过渡动画

6.优化应用的大小问题

Flutter使用了 Kernel Snapshot模式编译
flutter build apk --target-platform=android-arm64 --debug

AOT打包。以Android为例
flutter build apk --target-platform=android-arm64 --release
libapp.so：业务代码产物
flutter.so：Flutter引擎

Flutter还又一种Profile模式，，
主要用于性能分析阶段，用于分析真实设备的实际运行性能，跟Release并无太大差异，只是多了对服务扩展的支持


6.利用ListView.builder做高性能的列表

优化点1
是按需构建列表元素,也就是只有那些可见得元素才会调用itemBuilder 构建元素，这样对于大列表而言性能开销自然会小很多。

优化点2
禁用 addAutomaticKeepAlives 和 addRepaintBoundaries 特性
addAutomaticKeepAlives 特性默认是 true，意思是在列表元素不可见后可以保持元素的状态，从而在再次出现在屏幕的时候能够快速构建。这其实是一个拿空间换时间的方法，会造成一定程度得内存开销。可以设置为 false 关闭这一特性。缺点是滑动过快的时候可能会出现短暂的白屏（实际会很少发生）。
addRepaintBoundaries 是将列表元素使用一个重绘边界（Repaint Boundary）包裹，从而使得滚动的时候可以避免重绘。而如果列表很容易绘制（列表元素布局比较简单的情况下）的时候，可以关闭这个特性来提高滚动的流畅度。

优化点3：尽可能将列表元素中不变的组件使用 const 修饰
使用 const 相当于将元素缓存起来实现共用，若列表元素某些部分一直保持不变，那么可以使用 const 修饰。

优化点4：(https://blog.csdn.net/txaz6/article/details/120063374)
滑动不加载，停止滑动加载,使得列表更加流畅，我们需要了解懒加载，也称延迟加载,滚动结束了刷新页面加载图片
需要一个bool来控制是否加载,开始滚动的时候,刷新页面不加载图片,加载占位图;

优化点5：使用 itemExtent 确定列表元素滚动方向的尺寸
对于很多列表，我们在滚动方向上的尺寸是提前可以根据 UI设计稿知道的，如果能够知道的话，那么使用 itemExtent 属性制定列表元素在滚动方向的尺寸，可以提升性能。这是因为，如果不指定的话，在滚动过程中，会需要推算每个元素在滚动方向的尺寸从而消耗计算资源。




# 关于Flutter里面dart语法糖?.的理解
1.dart语法糖?.理解
解答:它的意思是问号？左边如果返回为null,那么就返回右边的值
实例: A?.B说明
解答:如果A等于null,那么A?.B必然等于null,如果A不等于null,那么A?.B等价于A.B
2.关于模型解析Animaly类来理解?.语法糖
Animaly animaly = Animaly("cat");
Animaly? empty = null;

打印print(animaly.name); animaly非空,可以直接访问name属性值
打印 print(empty?.name); empty为空,使用empty?.name,能读取属性值为null,不会崩溃
打印 print(empty.name); empty为空,使用empty.name,读取属性值,抛出异常值为
Null check operator used on a null value(要空值安全检查)

# 关于Flutter里面dart语法糖??的理解
1.dart语法糖??的理解
解答:它的意思是??前的值为空,则使用??后的值
实例: A??B,如果A等于null,那么A??B取值为B,如果A不等于null,那么A??B取值为A

Animaly? empty = null;
打印 print(empty?.name ?? '获取不到值');
empty 为空，本来要返回 null，由于有 ??，返回 获取不到值

var b ?? = "hello";
如果b等于null的情况下,使用(?? = "hello"),那么b就等于hello;如果b不等于null,那则不作任何操作
三目运算的简写
var b ??  "hello"; 等同于 var b ?? = "hello";

# 关于Flutter里面dart语法糖..级联运算符的理解
实例:
   final Persons persons = Persons()
    ..name = "张三"
    ..eat()
    ..run();

  print(persons.name);
  ..级联运算符操作,执行了给name赋值,调用了eat方法调用了run方法

# 关于Flutter里面dart语法糖小结理解
1.操作符?,表示放在类型后面的当前变量可以为null;
         例如Sting a 和Sting ? b,a不能null,b可以取值为null
2.操作符?.是操作符?的升级版,表示不为null的情况下使用,例如
         Sting ? str;打印print(str?.length()); // 使用`?.` 替换 `.` .
         例如Sting a 和Sting ? b,a不能null,b可以取值为null      
3.操作符!,表示此变量不可以为null,如果为null则会抛出异常,请谨慎使用


# 关于Flutter里面fianl和const理解应用
1.fianl和const的相同性
Dart中用final和const做常量的声明;被final和const声明的变量值无法被修改;
1.fianl和const的不同性
const的值在编译期确定,final的值要到运行时才能确定,例如获取当前时间DateTime.now()就用final申明
static const  编译阶段静态常量   static final 运行阶段获取的常量 


# 关于Flutter里面类,抽象类,接口,继承和Mixins混入的理解应用
 抽象类的理解, 抽象类通过abstract关键字定义; 子类继承抽象类,必须实现抽象方法;
 如果把抽象类当接口实现,就必须实现它的所有属性和方法;抽象类不能被实例化,只有继承的子类可以被实例化;
 抽象类通过implements接口extends继承以及通过mixin混入实现调用抽象类方法,
 实现顺序是extends继承>mixins混入>implements接口
当你使用 extends 继承或者implements接口方式一个抽象类时没有必要覆写抽象类中所有的方法, 但是抽象类中的 getter 和 setter 是必须覆写的 。


abstract class MysqlA implements DB 抽象类,使用implements接口实现,可以不用实现DB抽象类的所有方法和属性

abstract class MysqlCDB with DB  抽象类,,可以不用实现DB抽象类的所有方法和属性

通过mixin混入DB实现调用,mixin MysqlC on DB 

1.抽象类通过implements接口方式,实现多个抽象类的方法,继承只能扩展一个类，但是接口可以实现扩展到多个类
2.extends继承,不能多继承,只能单独extends继承,可以通过implements接口或者with混入调用
3.Mixins 无法实例化(Mixins can't be instantiated),mixins（关键字 with）


# Flutter性能优化的技巧
StateWidget组件使用,少用setState();整个页面刷新,只刷新当前组件


# Flutter中的四棵树  Widget和 element 和 RenderObject 和Layer
1.根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 Element 类。
2.根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自RenderObject 类。
3.根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 Layer 类。

Widget会被inflate（填充）到Element，并由Element管理底层渲染树。Widget并不会直接管理状态及渲染,而是通过State这个对象来管理状态。Flutter创建Element的可见树，相对于Widget来说，是可变的，通常界面开发中，我们不用直接操作Element,而是由框架层实现内部逻辑。就如一个UI视图树中，可能包含有多个TextWidget(Widget被使用多次)，但是放在内部视图树的视角，这些TextWidget都是填充到一个个独立的Element中。Element会持有renderObject和widget的实例。记住，Widget 只是一个配置，RenderObject 负责管理布局、绘制等操作。
在第一次创建 Widget 的时候，会对应创建一个 Element， 然后将该元素插入树中。如果之后 Widget 发生了变化，则将其与旧的 Widget 进行比较，并且相应地更新 Element。重要的是，Element 不会被重建，只是更新而已。

# Flutter 如何与 Android iOS 通信
Flutter 通过 PlatformChannel 与原生进行交互，其中 PlatformChannel 分为三种
1.BasicMesageChannel；用于传递字符串和半结构化的信息
2.MethodChannel;用于传递方法调用,flutter主动调用native的方法,并获得相应的返回值
3.EventChannel;用于数据流event streams）的通信。

# Flutter 什么是widget? 在flutter里有几种类型的widget？分别有什么区别？能分别说一下生命周期吗？
widget在flutter里面是基础UI组件,
分为statefulWidget和statelessWidget两种,statelessWidget不会自己重新构建自己，
但是statefulWidget会重新构建自己;
statelessWidget的生命周期，生命周期只有build过程。build是用来创建Widget的，在每次页面刷新时会调用build。

StatefulWidget的生命周期依次为：
createElement创建元素树,子类一般不会重写此方法调用
createState,是StatefulWidget创建State的方法，只调用一次
initState,是StatefulWidget创建后调用的第一个方法,只执行一次,这时View没有渲染,但StatefulWidget 已经被加载到渲染树里了,一般在这里进行初始化操作

didChangeDependencies,是会在initState后立即调用，当StatefulWidget依赖的InheritedWidget发生变化之后，didChangeDependencies才会调用，所以didChangeDependencies可以调用多次。(备注：widget树中，若节点的父级结构中的层级 或 父级结构中的任一节点的widget类型有变化，节点会调用didChangeDependencies；若仅仅是父级结构某一节点的widget的某些属性值变化，节点不会调用didChangeDependencies)

build方法会在didChangeDeoendencies之后立即调用,在之后setState()刷新时,每次会重新调用build绘制
addPostFrameCallback是StatefulWidget渲染结束之后的回调,只会调用一次,一般是在initState里添加回调：

didUpdateWidget，状态发生改变的时候调用备注:（widget树中，若节点调用setState方法，节点本身不会触发didUpdateWidget，此节点的子节点 会 调用didUpdateWidget）

deactivate页面切换时候会触发调用
dispose(组件移除时)一般在dispose中做一些取消监听、动画的操作，和initState相对使用


# 说说Flutter的APP的生命周期函数，AppLifecycleState
AppLifecycleState.paused,应用进入后台 paused
AppLifecycleState.resumed,应用进入前台 resumed活跃中
AppLifecycleState.inactive,应用进入非活动状态 , 如来了个电话 , 电话应用进入前台
AppLifecycleState.detached,应用程序仍然在 Flutter 引擎上运行 , 但是与宿主 View 组件分离


# 说说什么是flutter里的key? 有什么用？
key是Widgets，Elements和SemanticsNodes的标识符。
key有LocalKey 和 GlobalKey两种。
Globalkey可以主动获取以及主动改变子控件的状态。(备注:GlobalKey允许 Widget 在应用中的任何位置更改父级而不会丢失 State。)
LocalKey 如果要修改集合中的控件的顺序或数量。包含ValueKey ，ObjectKey，UniqueKey

# 介绍下Flutter的FrameWork层和Engine层，以及它们的作用
lutter的FrameWork层是用Drat编写的框架（SDK），它实现了一套基础库，包含Material（Android风格UI）和Cupertino（iOS风格）的UI界面，下面是通用的Widgets（组件），之后是一些动画、绘制、渲染、手势库等。这个纯 Dart实现的 SDK被封装为了一个叫作 dart:ui的 Dart库。我们在使用 Flutter写 App的时候，直接导入这个库即可使用组件等功能。

Flutter的Engine层是Skia 2D的绘图引擎库，其前身是一个向量绘图软件，Chrome和 Android均采用 Skia作为绘图引擎。Skia提供了非常友好的 API，并且在图形转换、文字渲染、位图渲染方面都提供了友好、高效的表现。Skia是跨平台的，可以轻松实现对原生界面的绘制,性能媲美原生

# 理解介绍下Flutter中的Widget、State、Context 概念
Widget：在Flutter中，几乎所有东西都是Widget。将一个Widget想象为一个可视化的组件（或与应用可视化方面交互的组件），当你需要构建与布局直接或间接相关的任何内容时，你正在使用Widget。
Widget树：Widget以树结构进行组织。包含其他Widget的widget被称为父Widget(或widget容器)。包含在父widget中的widget被称为子Widget。
Context：是已创建的所有Widget树结构中的某个Widget的位置引用,将context作为widget树的一部分,其中context所对应的widget被添加到此树中,一个context只从属于一个widget，它和widget一样是链接在一起的，并且会形成一个context树
State：定义了StatefulWidget实例的行为，它包含了用于”交互/干预“Widget信息的行为和布局。应用于State的任何更改都会强制重建Widget。

# Dart中var与dynamic的区别
使用var来声明变量，dart会在编译阶段自动推导出类型。而dynamic不在编译期间做类型检查而是在运行期间做类型校验。

# const和final的区别 const 的值在编译期确定，final 的值在运⾏时确定

# 说说mixin extends implement 之间的关系?
继承（关键字 extends）、混入 mixins （关键字 with）、接口实现（关键字 implements）
这三者可以同时存在，前后顺序是extends -> mixins -> implements。
Flutter中的继承是单继承，子类重写超类的方法要用@OverRide，子类调用超类的方法要用super。


# Flutter中 dart的一些重要概念？
在Dart中，一切都是对象，所有的对象都是继承自Object
Dart是强类型语言，但可以用var或 dynamic来声明一个变量，Dart会自动推断其数据类型,dynamic类似c#
没有赋初值的变量都会有默认值null
Dart支持顶层方法，如main方法，可以在方法内部创建方法
Dart支持顶层变量，也支持类变量或对象变量
Dart没有public protected private等关键字，如果某个变量以下划线（_）开头，代表这个变量在库中是私有的

# Flutter中关于Navigator是什么，为什么Navigator可以实现无需上下文路由导航？
Navigator是在Flutter中负责管理维护页面堆栈的导航器。MaterialApp在需要的时候，会自动为我们创建Navigator。Navigator.of(context)，会使用context来向上遍历Element树，找到MaterialApp提供的NavigatorState再调用其push/pop方法完成导航操作。
所以如果在MaterialApp的navigatorKey属性内设置好一个Key就可以直接使用这个Key来进行路由导航，无需上下文

# 导航返回拦截（WillPopScope）
为了避免用户误触返回按钮而导致 App 退出，在很多 App 中都拦截了用户点击返回键的按钮，然后进行一些防误触判断，比如当用户在某一个时间段内点击两次时，才会认为用户是要退出（而非误触）。Flutter中可以通过WillPopScope来实现返回按钮拦截，