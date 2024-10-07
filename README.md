# STM32G0B1 Docker Renode Simulation

The aim of the project is to create a Docker Container on top of [Renode](https://hub.docker.com/r/antmicro/renode) which can simulate a STM32 Microcontroller to test binaries without hardware. Eventually this can be implemented in a CI/CD Pipeline to automate testing the µC-Firmware.

The STM32-Project in this repository only uses a few peripherals (2 GPIO Output, 1 ADC, 1 FDCAN).

To create a project which initializes your needed peripherals see below under [More Documentation](#more-documentation).

To simply build this project and run the Simulation follow [these steps](/Documentation/build_procedure.md).


## How to run the simulation

Using a shell script the boot-process is automated. Simply execute the `stm32g0.sh`   script and a Renode Docker Image will be startet, the peripherals and logging will be set up and finally the µC will be started. 

	# execute from directory in which stm32g0.sh is located
	bash stm32g0.sh  					

    # or from project directory
	bash shell_script/stm32g0.sh	

#### Run the Simulation with custom ELF file
To load your own binary onto the simulated Microcontroller you can simply add it to the project folder and change following path in the [Renode Script](/resc/stm32g0.resc#1) to match the location of your ELF file:

	sysbus LoadELF @/stm32g0/build/Debug/stm32g0b1.elf

It is also possible to load a binary via HTTPS like this:

	sysbus LoadELF @https://remote-server.com/my-project.elf


## Debug using Gdb

A small script was created to allow you to debug the simulation using Gdb.
It will start up Gdb with the Elf file as a parameter and then watch and display the variable TxData which contains values changed by the GPIO and ADC Peripherals.  
To start the debugging session it's easiest to change to the project directory and execute following command:

	bash shell_script/stm32g0_debug.sh

A new console will be opened in which the Renode Simulation is started. Additionally in the original console the Gdb session will be started and connected to the running Simulation. 
Using `c` (continue) you can step to the next point where a variable is changed. The watched variable is an array representing the Pin 1 of GPIOA at index 0, the value of the ADC at index 1 and a continuously increasing counter at index 2.  
Typing `sysbus.adc SetDefaultValue 500` lets you set the value of the used ADC to 500 mV. The change will be visible after a couple of `c`.    
To exit the debugging session type `exit_gdb` in the Gdb console.


## More Documentation

### Set up Project with more peripherals

This project was designed to create the shell of the simulation-container. Thus the initialization code generated with STM32CubeMX only includes two GPIO Output Pin (GPIO_PIN_1, GPIO_PIN_2), one ADC-Peripheral (ADC1) and one CAN-Peripheral (FDCAN1).  
To use more Pins and peripherals one has two options:
+ Regenerate initialization Code with STM32CubeMX as described here: [Regenerate Code](Documentation/regenerate_code.md)   
Be careful as all of your custom Code needs to be between commented sections like this or else it will be overwritten: 

		/* USER CODE BEGIN SysInit */

		// Custom Code

		/* USER CODE END SysInit */


+ Start a project from the beginning as described in this guide: [Project-Setup](Documentation/project_setup.md)

### Further Project Settings

If you are using a Microcontroller from the STM32G0-Family you can then copy the folders *repl, resc* and *shell_script* into your directory to be able to run the above commands.

If you are not using a STM32G0 µC, then you can search for the *.repl* file in [this](https://github.com/renode/renode/blob/master/platforms/cpus) repository. 
In the *.resc* file you then need to change following line to fit your *.repl* file: 
    
    machine LoadPlatformDescription @/stm32g0/repl/stm32g0.repl

Depending on the precise model of the Microcontroller you will need to change the size of the RAM in the *.repl* file. For example a STM32G0B1CBTx has 144KB RAM thus the size needs to be changed like this:
	
	ram: Memory.MappedMemory @ sysbus 0x20000000
		size: 0x24000

If you created the project from the beginning using STM32CubeMX and named your folder differently you will also need to update the following line in the *.resc* file as the elf file will be named after the directory:

	sysbus LoadELF @/stm32g0/build/Debug/stm32g0b1.elf

### Renode specific files

For more information about Renode Platforms (.repl) and Renode Scripts (.resc) a small documentation can be found here:
+ [Renode Platform](/Documentation/repl.md)
+ [Renode Script](/Documentation/resc.md)

Also visit the [Official Renode Documentation](https://renode.readthedocs.io/en/latest/) website for further information.