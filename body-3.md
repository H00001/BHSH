# 系统软件设计

任何形式的微机都离不开软件。软件设计是设计硬件的重要部分，通过软件才能让单片机实现他的功能，其实再从设计方案开始时就应该考虑到软件设计，因为软件程序的大小，决定这硬件CPU的内存选择，这就要涉及到单片机的选型了，这样可方便软件和硬件之间的相互协调工作，并且想好之后的软件设计和调试工具。当硬件做好之后软件设计就可开展开来，软件是可以单独编写然后进行调试的，当再测试工具上么有问题时，就可将软件下载单片机中来，测试硬件的功能。
对于程序设计应该满足以下要求：
1. 可靠性，对于任何硬件来言，其驱动程序都应该要求工作可靠，如果程序本身就不可靠的话，那么不管他设计的有多么巧妙，功能多齐全，结构都复杂这都是毫无用处的。它与硬件的设计不同，硬件的使用可能会受到外部因素的影响，但对于软件来他的可靠性主要在于程序是否正确。
2. 精度，程序中可能包含着大量计算，可能有大量的函数使用和复杂的数据处理，就拿本设计而言，在温度采集中采用串联分压方式最终传感器采集的是电信号，并不能被单片机直接接收，所以还要加数模转换，单片机内部的10位AD转换在计算温度是采用应该是插值的方法，这就需要大量的计算。而且在数码管上显示的时候还需设定显示的精度。
3. 速度，对于硬件来讲，他是有工作周期的，要按照时间节拍执行一步步指令，如果程序执行速度很慢的话，在工作周期内不能够完成相应的操作，就可能会造成丢失或者某些重要操作的延误。
4. 易理解性、易维护性。通常是指软件系统容易阅读和理解，容易发现和纠正错误，容易修改和补充。由于生产过程自动化程度的不断提高，测控系统的结构日趋复杂，设计人员很难在短时间内就对整个系统理解无误，软件的设计与调试不可能一次完成，有些问题是在运行中逐步暴露出来，这就要求编制的软件容易理解和修改。在软件的设计方法中，结构化设计是最好的一种设计方法，这种设计方法是由整体到局部，然后再由局部到细节，先考虑整个系统所要实现的功能，确定整体目标，然后把这个目标分成一个个的任务。任务中可以分成若干个子任务，送样逐层细分，逐个实现。本仪表就是采用这种模块化的设计方法。这样不但使得设计目标明确、思路清晰，而且在检错、调试时也很方便。当出现问题时，可以根据问题的种类和现象来判断是哪一部分出的问题，很容易找出故障所在和故障原因。同时，采用模块化程序结构设计方案，对于系统功能的扩充和修改也提供了很大的方便。
5. 实时性是电子测量系统的普遍要求，即要求系统及时响应外部事件的发生，并及时给出处理结果。近年来，由于硬件的集成度与运算速度的提高，配合相应的软件，实时性比较容易满足设计要求；
6. 准确性对整个系统具有重要意义，尤其是测量系统，系统要进行一定量的运算，算法的正确性和准确性对结果有着直接的影响，因此在算法的选择、计算的精度等方面都要符合设计的要求；
7. 可靠性是系统软件最重要的指标之一，作为能够稳定运行的系统，抗干扰技术的应用是必不可少的，最起码的要求是在软件受到干扰出现异常时，系统还能恢复正常工作。结合上述编制系统软件的基本要求，首先讨论软件的设计思想。

软件设计的基本方法是结构化程序设计基本步骤为：
1. 从上到下分层设计，把整个软件任务划分若干大的任务，每个大任务再分若干个小任务，这样一层层的分下去，直到这个小任务可以用编程语言实现为止，一般是先从主程序来设计，其他子程序，分程序，先用一些模块来代替，当系统一级程序编好之后，再将这些模块一次扩展为模块，，从而完成整个程序的设计。
2. 模块化编程，分层设计没有解决怎么产生每一层次的程序模块，模块化编程可以对同一部分内容的任意改动并且不行其他程序的设计，要不然就不能够将这些组成同一模块，按照这样思路模块内的程序更利于独立运行、修改和调试，方便实现一些有独特功能的子程序设计。
3. 结构化编程，采用模块化的结构程序更利于进一步细分，优于任何单一入口和出口的程序呢都是有以下三种基本结构组成：顺序结构、条件结构、循环结构。这三种结构在编程语言中都有对应的语句或者指令，而且他们都是单一出口和入口，这样查找问题是很方便。
现在单片机主要的开发语言是C语言，C语言相对比汇编来讲有更好的可靠性并且他可反复擦写。而且在设计完成相同功能的程序时，C语言的效率要比汇编的效率高出很多。并且更加方便调试和更改。其编程语言相能够更好兼容其他高级语言和和汇编词汇，同时也能够象汇编那样根据硬件的内部特性来设计程序驱动单片机的内部寄存器和外部接口。C语言是一种能快速上手而且易懂的结构化编程语言。每一程序都可以由一个或者多个相互独立的程序组成，可以互相调用。其语言模块还能够与汇编相互组合成为一个完整的程序。在目前的单片机编程序言中，C语言越来越受到人们的欢迎。


## 软件设计思想

为了满足系统的要求，编制软件时必须符合以下基本要求: 

易理解性、易维护性。通常是指软件系统容易阅读和理解，容易发现和纠正错误，容易修改和补充。由于生产过程自动化程度的不断提高，测控系统的结构日趋复杂，设计人员很难在短时间内就对整个系统理解无误，软件的设计与调试不可能。

一次完成，有些问题是在运行中逐步暴露出来，这就要求编制的软件容易理解和修改。在软件的设计方法中，结构化设计是最好的一种设计方法，这种设计方法是由整体到局部，然后再由局部到细节，先考虑整个系统所要实现的功能，确定整体目标，然后把这个目标分成一个个的任务。任务中可以分成若干个子任务，送样逐层细分，逐个实现。本仪表就是采用这种模块化的设计方法。这样不但使得设计目标明确、思路清晰，而且在检错、调试时也很方便。当出现问题时，可以根据问题的种类和现象来判断是哪一部分出的问题，很容易找出故障所在和故障原因。同时，采用模块化程序结构设计方案，对于系统功能的扩充和修改也提供了很大的方便。

实时性。实时性是本系统的基本要求。即要求系统及时响应外部事件的发生，并及时给出处理结果。近年来，由于硬件的集成度与速度的提高，配合相应的软件，实时性容易满足要求，特别是对于汇编语言编制的软件。  

1. 可测试性。系统软件的可测试性具有两方面的含义:其一是指比较容易地制定出测试准则，并根据这些准则对软件进行测定；其二是软件设计完成后，首先在模拟环境下运行，经过静态分析和动态仿真运行，证明准确无误后才可投入实际运行。  
2. 准确性。准确性对整个系统具有重要意义。系统要进行大量运算，算法的正确性和准确性问题对控制结果有直接影响，因此在算法选择、位数选择方面要适合要求。
3. 可靠性。可靠性是系统软件最重要的指标之一，它要求两方面的意义:第一是运行参数环境发生变化时，软件都能可靠运行并给出正确结果，也就是要求软件具有自适应性:第二是在环境恶劣干扰严重情况下，软件必须保证也能可靠运行，这对整个系统尤为重要。



## 软件组成

由于整个系统软件相对比较庞大，为了便于编写、调试、修改和增删，系统软件的编制采用了模块化的设计。即整个控制软件由许多独立的小模块组成，它们之间通过软件接口连接，遵循模块内部数据关系紧凑，模块之间数据关系松散的原则，按功能形成模块化结构。

系统的软件主要由主程序模块、数据采集模块、数据处理模块、控制算法模块等组成。主模块的功能是为其余几个模块构建整体框架及初始化工作；数据采集模块的作用是将A／D转换的数字量采集并储存到存储器中；数据处理模块是将采集到的数据进行一系列的处理，其中最重要的是数字滤波程序：控制算法模块完成控制系统的PID运算并且输出控制量。

下面就介绍本系统几个主要的程序模块。

## 程序结构分析
本系统单片机的软件程序结构采用模块化的结构编程，主要包括：主程序设计，EEPROM读写程序设计，锁存器程序设计，显示程序设计，按键程序设计、温度采集程序设计、湿度采集程序设计。

**主程序调用了4个子程序，分别是温度传感器读取程序，数码管显示程序、键盘扫描及按键处理程序、温度信号处理程序。**

* 键盘扫描电路及按键处理程序：实现键盘的输入按键的识别及进入相应的程序。
* 温度信号处理程序：对温度芯片送过来的数据进行处理，进行判断和显示。
* 数码管显示程序：向数码的显示送数，控制系统的显示部分。


## 主程序
主程序功能是首先完成各部分初始化，包括设备初始化、定时器初始化、看门狗初始化，EEPROM初始化。然后是调用各模块的的子程序进行相应的功能实现其包括温湿度显示、AD转换、温湿度控制及报警。如图3-1所示。

![图 3-1系统程序框图](http://my.gunplan.top/static/mfd/302.png)

## 按键程序设计

本设计按键只有三个:设置键、加、减。这三个键要实现功能是通过设置键实现系统参数的设置，再长按设置键一定时间之后，进入手动模式，在手动模式中可以设定温湿度的给定范围，在一定时间没设置是系统自动跳回自动状态，显示当湿度的数值，由于键盘有按下和松开两种形式，其中按下时暂时的，当停止按压时按键就会变为开的形式，由于按键的状态值只是在程序中给定的但是实际上按键是在操作中实现的，所应该对按键进行消除抖动来协调人工操作和程序读取时的快慢不协调问题其程序框图如图3-2所示：
本系统在按键设置上采用两种模式，在默认情况下是手动模式，在手动模式时，按一下设置键可以是界面切换到设计界面，可以分别设置温湿度的上限，和下限，通过加、减键可以进行参数的更改和设定。在将这些设置完成后系统恢复到显示状态，显示当前测量的温湿度的值，另一种模式为自动模式，其设定方式是通过长按设置键来使模式切换到自动，在自动模式时，能够自动判断当前的状态，如果发现温湿度超限，则会发出报警信号。

![图 3-2按键程序框图](http://my.gunplan.top/static/mfd/304.png)

1. 判断是否有键按下
按键的一端接在单片机串口上另一端是接地的因此当按键按下时单片机的接口上会得到一个低电平的输入。所以当有按键按下时单片机的接口应该收到一个0x00得值或者低于0xff得值。
2. 确定按下的是哪一个键
有本设计有3个按键，这样当按键按下时就要对识别是哪个按键按下，但是由于仪表内的参数是程序都设定好的，只要将按键设计不同的工作模式就行了。通过模式切换就可以知道 按下那个按键了。
3. 等待按键释放
在按键按下以后，还需确定按键是否松开，来判断按键的时间因为系统设计对于按键的模式分为按一次和长按，这样对于按键释放的时间就要进行相应的判断来使单片机切换到相应的模式。
4. 按键的值
由于按键不同模式其标志定位的值是不同的，系统需读取按键的值来是驱动单片机的模式切换。
5. 按键的消抖处理
按键消除抖动的方式有两种：一种为构建硬件电路来消除按键的抖动，主要原理是是利用RS触发器得互锁功能，能够消除抖动，但是这样就会加大硬件设计的负担，同时是电路复杂，按照通常的仪表来讲其显示模块一般不会占用太大的空间，应为生产车间空间是有限。所以我们采用的是另一种利用程序的延时消抖方式，利用单片机首次检测到按键信号的时候延时一段时间，在确定按键的状态，这样可以读出稳定之后的状态，相对硬件来讲软件的不增加成本，也不复杂。

## 温度采集模块
由于单片机只能读取数字信号。当温度传感器将温度以电压量采集的，所以采用atmega8内AD模块进行数模转换，在硬件设计时也提到了对于温度计算的方法能够但不是每个二进制AD值都对应着整数温度这样的话测量出的温度就会有很大的误差需要进行校准，所以设计选择了用插值法来进行校准，这种方法是将校准曲线的分为许多小的区间，每个区间利用多项式进行拟合根据输入量的所在的区间来计算出现和对精准的测量值。线性插值原理如图3-3所示。 


![图3-3 线性插值原理](http://my.gunplan.top/static/mfd/305.png)

当传感器的输入和输出按要求进行分段这样就可以将每一段的趋向近似呈直线来看，假设在Xi和Xi+1之间那么它相对的输出值可以近似地看成：
$ y=y_i+\frac {y_{i+1}-y_i} {x_{i+1}-x_{i}}(x-x_i)$                      （3-1）
通过这样的计算可以将将温度值进行校准但是如何将置换华为是程序设计的具体是实现过程是这样的，首先要将校准曲线进行合理的分段选取基点。然后确定个插值点的AD得值，然后计算出相应输出值，最后还要查表比较，确定其所在的范围，再根据公式求出相应的值。温度采集程序如图3-4所示：

![图3-4 温度程序框图](http://my.gunplan.top/static/mfd/306.png)




## 显示程序设计
显示程序主要是利用单片机将控制数码显示温湿度得值，由于硬件设计为两个锁存器控制两个3位8段数码管的显示。如此一来，单芯片的I/O控制线便可以减少了，省下来的控制线可以做其他硬件的设计。通过利用锁存器的级联方法可以使较为方便的选择那个数码管显示，方便了程序设计和电路设计。利用其数据传递式的发送，可以将数据显示出来那么程序设计来讲首先要将数字转化为对应的显示器的段码，在显示采用扫描的方式了，延时2ms可以利用人眼残留现象，避免闪烁。然后确定是显示温度值还是湿度值，进行数码管的选择。然后确定每位数码管显示的相应的值，进行显示设置，最后设置温度精度和湿度精度显示。其程序框图为如图3-5所示：

![图3-6 显示模块流程图](http://my.gunplan.top/static/mfd/b00.png)



## 数据存储寄存器程序设计
EEPROM主要是将数据进行保存以保证在掉电的情况下单片机还能保存当前的数据那么他设计程序很简单基本就是包括从EEPROM写数据及然后就是进行判断是否写完然后设置寄存器，设置存储地址，置位写操作。读程序的方式跟写操作是同样的。

## 本章小结
这一部分主要对单片机的软件驱动动程序进行了设计，程序的设计采用了模块化的方式，如何将单片机要实现的功能利用软件的方式进行驱动，对于软件编写，不应该利用过多的技巧使编程语言变得生涩让人难懂，同时也不该将程序变得太长，这样也会造成与硬件不协调。在本系统中虽然测量的量只有温度和湿度两个量，当但是却采用了许多函数进行计算，程序比较复杂，这对与单片机的数据的处理能力有了很高的要求。虽然采用模块化编程的开发率很高但是效率有点低，但作为一种很基础的编程方式具有很好的指导意义和启发。



