# STM32 Setup and Project Initialization

This is a short step-by-step guide how one can set up a project for a STM32 Microcontroller.  
Admin-privileges are only needed when setting up WSL.

## Pre-requities

+ WSL with Ubuntu Distro

+ Visual Studio Code

+ WSL VS Code Extension: [WSL VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)

+ C++ Extensions for Visual Studio Code: [C/C++ Extension Pack for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)

## Toolchain

+ Install STM32CubeMX on Windows:			[STM32CubeMX - STMicroelectronics](https://www.st.com/en/development-tools/stm32cubemx.html) 

+ Download STM32CubeCLT for Linux:		[STM32CubeCLT - STMicroelectronics](https://www.st.com/en/development-tools/stm32cubeclt.html) 

    + Move it into a folder in Linux (WSL) using the Explorer

    + Un-zip and use following command in an Ubuntu Shell:

        + sudo sh {file_name}

+ Install arm-none-eabi-gcc in WSL as described in this guide: 		[Cross-compiler: Install Guide](https://learn.arm.com/install-guides/gcc/cross/) 

+ Install “STM32 VS Code Extension” in Visual Studio Code:  [STM32 VS Code Extension](https://marketplace.visualstudio.com/items?itemName=stmicroelectronics.stm32-vscode-extension)

## Project Initialization

+ Create Initialization C Code

    + Open STM32CubeMX and click on File → New Project

    + Search for a Microcontroller in the *Commercial Part Number* - field

        + For example: STM32G0B1CBT3

    + Select the correct Microcontroller and click on *Start Project*

    + Create the desired configuration of the Microcontroller (Google how to)

    + Click on *Project Manager* and for the field *Toolchain / IDE* select *CMake*

    + Save the Project ( File → Save Project As )

    + Click on *GENERATE CODE* to create the initialization code 

+ Copy the folder contents into a directory in your WSL System

+ Open the directory with VS Code through an Ubuntu Shell

+ Press *CTRL+SHIFT+P* and search for *Open workspace Settings (JSON)* and hit enter

+ Add this Json-Snippet  so that the *STM32 VS Code Extension* correctly finds the *C/C++ Extensions*

        {
            "remote.extensionKind": {
                "stmicroelectronics.stm32-vscode-extension": [
                    "workspace"
                ]
            }
        }

+ Reload your VS Code (either by closing and re-opening or with *CTRL+SHIFT+P* and type *Reload Window*)

+ On the left of VS Code there should be a tab for the STM 32 VS Code Extension

    + Click on Import CMake project

    + Move to the directory containing the whole project and hit enter

    + Then click on *Import project*

+ On the bottom left side of VS Code click on *Build* and the project should be building

    + When building the project for the first time select *Debug* from the drop-down menu at the top of VS Code

+ The executable file should be found in the folder *build/Debug*

+ Custom code can be written in *Core/Src/main.c*