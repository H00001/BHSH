# 系统硬件电路设计
本系统实现的功能主要是:通过传感器将温度采集，并实时通过数码管显示、通过端口与主机进行实时的数据传输，其中主机可以控制仪表的工作、系统给定温度值得设定,系统通过传感器得到的数据以及程序的控制能够自动或者手动来调节温度的变化。原理框图如图1所示:

![图1](http://my.gunplan.top/static/mfd/001.png)

## 硬件模块

根据本设计要实现的具体功能能够大致确定硬件电路应包含以下几个模块：主控制器、温湿度传感器、数码管显示电路、键盘电路、ISP下载电路、报警电路、电源电路等[6]。

## 主电路设计

### 时钟电路设计

时钟单片定时的标准，时钟电路必须按照单片机的要求来设计[11]。本设计的是在单片机外部采用8MHZ的晶体振荡器，单片机上XTAL1与XTAL2的作用分别是单片机内的振荡器的反向放大器的输入和输出，并在其两端加入电容用来消除噪声。放大器的模式是由熔丝位CKOPT来控制的。当熔丝位处于编程状态时振荡器在其输出引脚产生的振荡是满幅度的。这种模式频率范围比较宽而且十分适合噪声环境或者需要利用XTAL2引脚驱动第二个时钟缓冲器的时候。当熔丝位处于没被编程的时候，振荡器的信号输出幅度是比较小的。这样可以很大程度上降低功率损耗，同时这种情况下频率范围很窄不能够驱动其他时钟。

### 复位电路设计

单片机的复位是指利用硬件或者软件实现单片机和其内部逻辑电路的初始化复位是系统启动完成不可缺少的步骤。 在实际中复位引脚会受到很多外界影响，而且复位引脚通常会与ISP端口相接这样的话，其接线会较长，所以利用一个RC串联电路可增强抗干扰能力。同时在系统掉电时，电容会放电，给复位引脚一个高电平，当电源来电时，就会给复位引脚一个复位信号。而在正常时在电容充电完成复位引脚会一直处于低电平。


## 各模块设计

### 温度采集电路

温度是一个常见非电物理量要想测量温度必须将其转变成可以测量的电信号，随意对于温度测量电路采用热敏电阻为感应器件，通过分压的方式利用电压的变化来反映当前的温度值[12]。根据电阻率随着温度变化的典型特性不同热敏电阻基本分为三种类型：负温度系数热敏电阻、正温度系数热敏电阻和临界温度热敏电阻。本设计温度采集电路采用MF52NTC温敏电阻作为感应元件，NTC热敏电阻器，其电阻率随着温度的升高而均匀减小，NTC热敏电阻一般采用负电阻系数很大的固体多晶半导体氧化物的混合物制成。测温、温度补偿和控温电路都可以根据热敏电阻的这一特性来设计，而且还可以设计成用来降低电路的浪涌电流的功率型组件。

![图2-2温度采集电路](http://my.gunplan.top/static/mfd/002.png)


从上图可以看出温敏电阻和定值电阻R5形成了一个串联分压电路，输出电压*V*temp由于分压得到了一个随电阻值变化而变化的电压值，通过这个电压变化的数值能够得到NTC电阻的大小，也就能算出当前的温度值。从上图可以看出温敏电阻和定值电阻R5形成了一个串联分压电路，输出电压*V*temp由于分压得到了一个随电阻值变化而变化的电压值，通过这个电压变化的数值能够得到NTC电阻的大小，也就能算出当前的温度值。

例如，查表可知当温度值为0度是*R*t电阻值为12.6900 千欧,那么该温度的数字量为572，以此类推可得到个温度的数字量。

利用欧姆定律可以算出输出电压值*V*temp和NTC电阻值的关系表达式：


$ V_{temp} = R_t/(R_t+R_5)*V_{cc} $  （2-2）

那么这温度点对于ADC转换之后的数字量可以计算：

$ D_{adc} = 1024*R_t/(R_t+R_5) $（2-3）

例如，查表可知当温度值为0度是*R*t电阻值为12.6900 千欧,那么该温度的数字量为572，以此类推可得到个温度的数字量。

### 温度报警电路
本次设计有2个温度的设定最低点和2个温度的设定最高点。当前温湿度中的某项数据高于或低于该范围时，单片机将对其产生处理方案，在反馈给继电器的同时也将启动报警电路。蜂鸣器发声原理是电流通过电磁线圈，使电磁线圈产生磁场来驱动振动膜发声的，因此需要一定的电流才能驱动它，单片机IO引脚输出的电流较小，单片机输出的TTL电平基本上驱动不了蜂鸣器[18]，因此需要增加一个电流放大的电路。本设计采用一个三极管C8550来放大驱动蜂鸣器。蜂鸣器报警电路如图2-4所示：
![图2-4 温湿度报警电路](http://my.gunplan.top/static/mfd/003.png)
如图所示，蜂鸣器的正极接到VCC（＋5V）电源上面，蜂鸣器的正极接到三极管的集电极，三极管的基极B经过限流电阻R1后由单片机的引脚控制，当单片机输出高电平时，三极管T1截止，没有电流流过线圈，蜂鸣器不发声；当单片机输出低电平时，三极管导通，这样蜂鸣器的电流形成回路，发出声音。因此，我们可以通过程序控制单片机引脚的电平来使蜂鸣器发出声音和关闭。在蜂鸣器两端并联一个二极管，起到续流的作用，当三极管停止导通时，由电流突然减小，而蜂鸣器内部线圈的缘故，会产感应电流，所以添加一个续流二级管起到保护电路的作用[19]。

### 显示电路设计

发光二极管LED是简单而且廉价的显示输出设备，是目前智能仪器应用最为广泛显示设备，具有低电压，驱动电流小、快速响应、使用寿命长等特点[20]。数码管有共阴、共阳极两种，本设计采用共阳极的2个3位8段数码管来显示温湿度得值。在数码管的每段都应接一个电阻作为限流使用，当LED显示器与单片机的借口相接时，需要用锁存器将总线上瞬时信息锁存，来驱动显示器。驱动显示器的方式有静态驱动和动态驱动两种。

静态驱动是一个锁存器对应一位显示器的接口形式称为静态显示只要将显示信息送入锁存器中，显示器就将持续显示该信息，显示亮度易于保证，其缺点时当显示器为数较多时，需要较多的锁存器，限流电阻等硬件，成本高，功耗也大。

动态驱动是当显示器为数较多时，适合采用动态驱动，其利用人视觉上残留的现象是个显示器轮流点亮，当每个显示器点亮的通电频率在50Hz以上时，人就不会感觉到显示器的闪动了。

由于要显示3位8段数码管而且有两个，所应采用动态驱动方式，利用两个74HC595锁存器，其中电源和清楚短接高电平，输出有效端和低端接低电平，数据从串行数输入端接入锁存器，在每个数据输入时钟上升沿时，串口数据移入锁存器内的寄存器，在每8个时钟周期完成一次数据传输在下一个时钟上升沿时，数据在出行输出端接处，由于采用两个锁存器，当串行输出端和和下一个锁存器的串行输入端连接时，两个锁存器实现了级联，数据会进入下一个锁存器，当给输出始终一个上升沿时数据进入锁存器这个时候当输出有效端低电平时，数据会从Q0~Q7端口传出，由低位到高位输出，这时，锁存器输出端和Led的8段相连，通过限流电阻的保护数码管的每段会被点亮，当级联的数据进入下一个锁存器是时通过同样的道理，由其控制这数码管的位选端，可以选择点那个数码管，这样一个锁存器控制显示的数字，另一个控制着点那个数码管实现数据的显示。

其电路图如图2-5所示：

![图2-5 显示电路](http://my.gunplan.top/static/mfd/005.png)

### 电源电路设计

由于室内的交流电压为220V，而单片机电源电压为5V，所以设计一个经变压器变压在经过整流桥调压，再稳压的一个电源电路设计[20]。系统原理如图2-6所示：

![图2-6 电源系统原理](http://my.gunplan.top/static/mfd/006.png)

首先当电源电压220V进过电压器变压会得到一个12V的交流电但是单片所需供电为5V的直流电，锁着需利用整流电路将交流电转换为直流电，这里采用MB10s整流桥堆，MB10S整流桥堆的工作原理为与单相全桥整流电路相似，能够使将变压器变压后的电压和电流保持一个方向不变但其虽然电压的方向单一的，但含有较大的交流成分，并不能直接给单片机供电，因此，在一般整流电路后，还需利用滤波电路将脉动的直流电压变为平滑的直流电压，电容滤波电路是比较常见而且简单滤波电路，电容比一般采用电解电容， 电容滤波电路利益哦那个电容的充放电作用，使输出电压趋于平滑。  

虽然整流滤波电路能够将交流电变为变为比较平滑的直流电压，可是由于输出电压是变压器副边电压有效值，当电压发生波动时，输出电压也会有波动，并且由于整流桥内的内阻影响当负载变化时内阻电压也会变化，从而影响输出电压的平均为了使输出的直流电更加稳定，还需采用稳压电路，稳压电路采用7805三端稳压器。折是一种集成电路元件，其外部有三个引脚分别为输入端、输出端、和公共端。按照功能可以分为固定式和可调式。本设计的电路采用固定式，其稳压电路如图所示，电容C3用于消除输出电压的高频噪声，一般取小于1F的电容，也可以采用大一些的比如几微法的电容这样可获得比较大的脉冲电流。后电解的电解电容是用来滤波的。如果输入线很长的话，也可以在输入端加一个电容用来防止电路的自激振荡，但是如果C3的容量很大的话，一旦输入端断开，C3会向稳压器放电，从而损坏稳压器，所以，也可以再在输入和输出之间装一个二极管来保护电路。同其他的大功率元件一样7085的封装有金属和塑料封装两种其外形同设计成便于自身散热或者安装散热器。所以电源电路最终设计如图2-7所示：

![图2-7 电源电路图](http://my.gunplan.top/static/mfd/007.png)




### 本章小结
这一章主要介绍了本设计的硬件电路设计部分，将硬件的设计模块和实现方式进行了阐述，本设计主要通过电源转换电路可以将硬件直接接在生产车间的仪表室内，通过显示电路是监控的温湿度值可以显示在数码管上，利用键盘电路可以将参数设定在硬件内并且可以控制柜内温湿度控制器，来保证温湿度的稳定。但是由于有生产车间内的空间较大有时一个传感器不能满足，将柜内温湿度直观地反映出来，可能涉及到多点测量，这样的话可能会造成信号在传输过程中出现问题，同时由于柜内电气干扰很大可能会造成数据的失真情况，所以柜体很大的生产车间内使用本设计的话还需加入隔离电路来保证数据接受的稳定和测量精度。


