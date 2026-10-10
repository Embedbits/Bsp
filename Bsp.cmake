#==================== Include necessary files and folders =====================#
include("${CMAKE_CURRENT_LIST_DIR}/Linker/Linker.cmake")

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Startup)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Ral)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Mcal)

# HAL is processed in every build (incl. integration tests of HAL modules),
# Hal/CMakeLists.txt skips BspMain in integration test build (replaced by ItCore)
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/Hal/CMakeLists.txt")
    message(STATUS "${CMAKE_CURRENT_LIST_DIR}/Hal/CMakeLists.txt found")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Hal)
else()
    message(STATUS "CMakeLists.txt not found in HAL directory, skipping...")
endif()
