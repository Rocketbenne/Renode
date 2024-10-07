# Description of *.repl*

The *.repl* file describes the Platfrom on which the Renode Container will run the firmware. 
It describes the Microcontroller and all its peripherals in a YAML-like platform description format.

You can get a standart Renode Platform file for a variety of Microcontrollers [here](https://github.com/renode/renode/tree/master/platforms/cpus).  

### Changing Peripheral-values

Depending on the precise Microcontroller you are using you might have to change some values.

For example if you are using a STM32G0B1CBTx you can start with [this](https://github.com/renode/renode/blob/master/platforms/cpus/stm32g0.repl) file. This file is used as a base for the whole STM32G0 Micrcontroller family, to make it work for our Microcontroller we need to change the size of RAM as follows:

    ram: Memory.MappedMemory @ sysbus 0x20000000
    size: 0x24000            // standard value: 0xC000, 0x24000 are 144 KB RAM

### Changing Peripherals

If we dig in deeper into the used peripherals we can see that the file uses [the CAN.STMCAN class](https://github.com/renode/renode-infrastructure/blob/master/src/Emulator/Peripherals/Peripherals/CAN/STMCAN.cs) for the FDCAN Peripherals of the µC. When looking at the Reigsters and their Offsets we can see that these are not correct. We can use [this](https://stm32-rs.github.io/stm32-rs/STM32G0B1.html) as a reference.  
If we want to use the FDCAN Peripheral we would need to change the used peripheral to [CAN.MCAN](https://github.com/renode/renode-infrastructure/blob/master/src/Emulator/Peripherals/Peripherals/CAN/MCAN.cs). The registers of this C# Peripheral match the Registers of the STM32G0 series. 

If saome peripheral is not working it is most likely due to the peripheral not working correctly or not beeing fully implemented by the Renode Team. In these cases check if the Peripheral describes the correct registers and the register logic is correct.

### Missing Peripherals

The base file could also miss out on some peripherals. In that case you will need to include it manually or even completely create it using Python for some basic logic or C# for a more complex peripheral.
You can write your own peripherals using C# as described [here](https://renode.readthedocs.io/en/latest/advanced/writing-peripherals.html#writing-a-peripheral-model-in-c).

Base-classes for peripherals can be found on the [official Renode Github](https://github.com/renode/renode-infrastructure/tree/master/src/Emulator/Peripherals/Peripherals).