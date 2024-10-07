# How to build this Project

+ Clone Project

+ Install [Toolchain](/Documentation/project_setup.md#toolchain)

+ Open the project folder in VS Code 

+ Click on `Build` in the bottom left corner of VS Code

+ Execute the Shell script named `stm32g0.sh` in the subfolder `shell_script` to boot the simulation

### What happens:

An [Antmicro/Renode](https://hub.docker.com/r/antmicro/renode) Docker Image will be run, using the project folder as a volume, forwarding the hosts ports and starting the [Renode Script](/resc/stm32g0.resc).  
Firstly this script creates a machine which represents a Microcontroller Unit. It is possible to create multiple machines which can interact with each other.  
After creating the machine the MCU needs to be described. This is done by initializing Peripherals in a [Renode Platform](/repl/stm32g0.repl). To use custom Peripherals one can include them before Loading the Platform onto the MCU. The next step is to load the program in form of an ELF file onto the MCU.  
Then a few options for Logging are set and a GDB Server is started on Port 3333. 
To ensure commuication between the Simulation and a Virtual CAN Network on the host machine, a CAN-Bridge is created.  
After that the simulation is started and it will run the previously loaded ELF file until stopped.  


After changing the C source Code the project needs to be rebuild. To implement these changes into a running Renode Docker Image there are two options:
+ Restarting the whole Docker Image using `quit` and then starting the shell script again
+ Clearing the machine by pausing the machine (command: `p` or `pause`) and resetting the machine (command: `machine Reset`)

After changing other files such as the Renode Script or the Renode Platform you will need to re-run the Shell file to work with your new version.  
