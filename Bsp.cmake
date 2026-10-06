#==================== Include necessary files and folders =====================#
include("${CMAKE_CURRENT_LIST_DIR}/Linker/Linker.cmake")

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Startup)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Ral)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Mcal)

# Integration test firmware has own BSP entry point (IntegrationTesting ItCore)
if(INTEGRATION_TESTING_AVAILABLE STREQUAL "ON")
    message(STATUS "Integration test build - HAL (BspMain) is replaced by test firmware, skipping...")
elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/Hal/CMakeLists.txt")
message("${CMAKE_CURRENT_LIST_DIR}/Hal/CMakeLists.txt found")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/Hal)
else()
    message(STATUS "CMakeListst.txt do not found in HAL directory, skipping...")
endif()