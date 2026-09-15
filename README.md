# BSP (Board Support Package) Module

The BSP module provides all necessary components to initialize and support the hardware of STM32 microcontrollers for a given MCU family.

Each STM32 family is available in a separate Git branch. For example, the branch `STM32U5` contains all BSP components required for the U5 family.

## Structure

- **Linker Module**  
  Generates the linker script according to the MCU type selected by the user.

- **Startup Module**  
  - Calls the user application entry point.  
  - Initializes memory sections (RAM, .data, .bss, etc.).  
  - Executes C++ constructors if C++ is used.  

- **MCAL Module**  
  Provides low-level drivers and peripheral access for the MCU.  

- **RAL Module**  
  Provides unified access to peripheral libraries (abstracted LL/CMSIS headers) across all MCU families.  
  Also builds ST's HAL/LL driver library (`HAL_LL_Lib`) for the selected family - HAL is not a separate BSP module, it is generated and exposed as part of RAL.

- **CMake Configuration**  
  The BSP module sets up the compiler and build options according to the selected MCU family.  
  Each family branch contains the appropriate CMake toolchain and configuration for that family.

## Usage

- Clone the BSP repository and check out the branch corresponding to your target MCU family, then initialize its submodules (Linker, Startup, MCAL, RAL), e.g.:  

```
git clone --recurse-submodules -b STM32U5 <repo_url> bsp_project
```

  If you already have a clone checked out on the wrong branch, or forgot `--recurse-submodules`:

```
cd bsp_project
git checkout STM32U5
git submodule update --init --recursive
```

- Include the BSP module in your project via `CMakeLists.txt` (e.g. `add_subdirectory(bsp_project)`), and set the following variables **before** doing so:

  | Variable | Example | Purpose |
  |---|---|---|
  | `TARGET_MCU` | `STM32U575xx` | Passed as a compiler define and used to select the RAL module's build configuration |
  | `MCU_FAMILY_ID` | `STM32U5xx` | Must match the family this branch was generated for - RAL fails the CMake configure step with a `FATAL_ERROR` if it doesn't |

- The linker script, startup code, MCAL, RAL, and HAL are automatically configured based on the selected MCU family once these variables are set.  

## Branching Strategy

- Each STM32 family has its own branch:
  - `STM32U5` – includes BSP for U5 family  
  - `STM32H5` – includes BSP for H5 family  
  - `STM32H7` – includes BSP for H7 family  
  - `STM32G4` – includes BSP for G4 family  
  - … and others  

This allows the user to work with the same BSP interface while supporting multiple MCU families through branches.

## Notes

- Do not mix files from different MCU family branches.  
- Always build the project from the branch corresponding to the target MCU.  
- CMake automatically selects the correct toolchain and compiler flags for the selected family.
- This repository uses git submodules - a plain `git clone`/`git checkout` without `--recurse-submodules` or `git submodule update --init --recursive` will leave the Linker, Startup, MCAL, and RAL directories empty.

---

## License

This project is licensed under the **Creative Commons Attribution–NonCommercial 4.0 International (CC BY-NC 4.0)**.

You are free to use, modify, and share this work for **non-commercial purposes**, provided appropriate credit is given.

See [LICENSE.md](LICENSE.md) for full terms or visit [creativecommons.org/licenses/by-nc/4.0](https://creativecommons.org/licenses/by-nc/4.0/).

---

## Authors

- **Mr.Nobody** — [embedbits.com](https://embedbits.com)

Contributions are welcome! Please open a pull request.

---

## 🌐 Useful Links

- [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)
- [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/)
- [Embedbits Github](https://github.com/Embedbits)
- [CC BY-NC 4.0 License](https://creativecommons.org/licenses/by-nc/4.0/)
