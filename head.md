# 摘 要
温度是工业控制对象主要被控参数之一，在温度控制中，由于受到温度被控对象特性（如惯性大、滞后大、非线性等）的影响，使得控制性能难以提高，有些工艺过程其温度控制的好坏直接影响着产品的质量，因而设计一种较为理想的温度控制系统是非常有价值的。

本设计是基于STC89C52单片机的温度控制系统的工作原理和设计方法制作的一个项目。本文介绍了控制系统的硬件部分，包括：温度检测电路，温度控制电路，显示电路，其他电路。单片机处理信号线接收单片机信号并且进行相应处理，以达到温度控制的目的。该论文还重点介绍了采用模块化结构的软件设计部分。介绍该控制系统的硬件部分会在文中写出，包括的模块是：数字管显示程序，键盘扫描和按键处理程序，温度信号处理程序，继电器控制程序和过热报警程序。同时，还包括系统中复杂的电路设计等方式。主程序包括读取温度子程序，键处理程序，LCD显示程序和数据存储程序。

**关键词：AT89C51，DS18B20温度芯片，温度控制，数码显示**  


# Abstract
This design uses STC89C52 single-chip microcomputer as the core of the working principle and design method of temperature control system. The temperature signal is collected by the temperature chip DS18B20 and transmitted to the single-chip microcomputer as a digital signal. This article introduces the hardware part of the control system, including: temperature detection circuit, temperature control circuit, display circuit. The single chip microcomputer processes the signals accordingly to achieve the purpose of temperature control. The single chip microcomputer processes the signals accordingly to achieve the purpose of temperature control. The paper also focouses on the software design part, which adopts a modular structure. The main modules are: digital tube display prog random access memory, keyboard scanning and key processing prog random access memory, temperature signal processing prog random access Memory, relay control prog, random access memory, and over-temperature alarm pr ocess. The control system can store relevant temperature data in real time and record the current time. The system prog random access memory mainly includes a main prog random access memory, a readout temperature subprog random access memory, a calculation temperature subprog random Access memory, a key processing prog random access memory, an LCD display prog random access memory, and a data storage prog random access memory.


