# Description of monitor, script syntax and *.resc*-file

The Monitor is Renode's command line interface. Here you can control the emulation using a wide range of built-in functions. They allow you to access emulation objects like peripherals, machines, and external connectors.  
You can add your own functions with [Python](https://renode.readthedocs.io/en/latest/basic/using-python.html).  
A *.resc* file can be used to automate the process as it can contain a series of renode commands.  
Pressing `Tab` can be used for autocompletion in the monitor. Pressing `Tab` a second time will print all the possible autocompletions.

## Description of import commands

### `help` / `?`

These commands list every available command with a short description in the Renode Monitor.  
When combined with another command, the command is described in closer detail, also showing how to use it.  
For example entering 
    
    help start

will lead to

    start [ s ]
    starts the emulation.

    Usage:
    start - starts the whole emulation
    start @path - executes the script and starts the emulation

### `mach create`

Used to create a machine on which the Microcontroller can be instantiated and firmware can be simulated.  
You can add an optional parameter to give the machine a custom name.

    mach create "ren"

### `include`

Using the include-command one can add other Renode scripts or other things like self-written peripherals.

    include @scripts/single-node/quark_c1000.resc

    include @/stm32g0/renode_peripherals/rcc.cs

### `machine LoadPlatformDescription`

Loads the platform description file (*.repl*). It takes one parameter which is the path to the file. In the renode monitor most times you will need to use `@` as a prefix for paths. 

    machine LoadPlatformDescription @/stm32g0/repl/stm32g0.repl

### `sysbus`

This is the machine's root for all peripherals. The peripherals of the Microcontroller can then be accessed using `sysbus.cpu` for example. It is also possible to type the command `using sysbus` to set a default prefix which will allow you to call `cpu` without the using prefix.

### `sysbus LoadELF`

This command loads the binary which will later be executed in the simulation. 

    sysbus LoadELF @/stm32g0/build/Debug/stm32g0b1.elf

### `sysbus.cpu AddHook`
To quickly check if a function was called by the Microcontroller you can add a hook which detects when the function is entered.

    sysbus.cpu AddHook `sysbus GetSymbolAddress "main"` "print 'You have reached the main function'"


### `start` / `s`

Start the simulation, which means the binary loaded onto the Platform will be executed. It is also possible to give it a path to another Renode Script (*.resc*) as a parameter. This will result in starting the emulation and then executing the commands in the script.

    start @/path/to/script.resc

### `machine StartGdbServer`

You can start and expose a Gdb Server to Debug the Firmware.

    machine StartGdbServer 3333

### CAN commands

To send out CAN messages we firstly need to create a Renode-Internal CAN-Hub. This allows multiple machines to talk to each other in Renode. Here we will call it `canHub`.

    emulation CreateCANHub "canHub"

We then need to connect the CAN-Peripheral of the Microcontroller to this CAN-Hub.

    connector Connect sysbus.fdcan1 canHub

To be able to send the messages to the host machine, we need to create a CAN bridge to the host. The default name is `vcan0`. We will call the CAN bridge `socketcan`.

    machine CreateSocketCANBridge "socketcan"

Now we only need to connect this CAN bridge to our internal CAN-Hub.

    connector Connect sysbus.socketcan canHub

To disconnect a device from the CAN-Hub we can simply use the `Disconnect` function. For example when disconnecting the fdcan1 peripheral from the created CAN-Hub the command looks as follows.

    connector Disconnect sysbus.fdcan1 canHub


### Logging Commands

The commands for loggin on different levels, using a file to save the logs, and giving peripherals access to logging are described very well in the [Official Renode Documentation](https://renode.readthedocs.io/en/latest/basic/logger.html#).

### More Commands

Some more commands can be found in the [Official Renode Documentation](https://renode.readthedocs.io/en/latest/basic/monitor-syntax.html).  
Unfortunately not every available command is explained in the Documentation or elsewhere, often a lot more commands are available. All available commands can be seen by pressing `TAB` twice in the Renode simulation.  
This also works for functions of peripherals. Just type in the name of a peripheral (i.e. sysbus) and press `TAB` twice.