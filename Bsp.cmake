#==================== Include necessary files and folders =====================#
include("${CMAKE_CURRENT_LIST_DIR}/Linker/Linker.cmake")

# Build folders are given - Bsp of the projects of the cores of a multi-core MCU is not in the project folder (it is
# shared in their parent folder), the folders are the same as for Bsp in the project folder
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Startup ${CMAKE_CURRENT_BINARY_DIR}/Bsp/Startup)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Ral     ${CMAKE_CURRENT_BINARY_DIR}/Bsp/Ral)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Mcal    ${CMAKE_CURRENT_BINARY_DIR}/Bsp/Mcal)

# HAL is processed in every build (incl. integration tests of HAL modules),
# Hal/CMakeLists.txt skips BspMain in integration test build (replaced by ItCore)
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/Hal/CMakeLists.txt")
    message(STATUS "${CMAKE_CURRENT_LIST_DIR}/Hal/CMakeLists.txt found")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Hal ${CMAKE_CURRENT_BINARY_DIR}/Bsp/Hal)
else()
    message(STATUS "CMakeLists.txt not found in HAL directory, skipping...")
endif()
