cmake_minimum_required(VERSION 3.21)

set( PROJECT_NAME "REPLACE_WITH_PROJECT_NAME" )
project( ${PROJECT_NAME} LANGUAGES CXX )
set( TARGET ${PROJECT_NAME} )

set( CMAKE_CXX_STANDARD 17 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_EXTENSIONS OFF )

# Set source and include paths
set( INCLUDE_PATH "${PROJECT_SOURCE_DIR}/include/" )
set( SOURCE_PATH "${PROJECT_SOURCE_DIR}/src/" )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin )

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

find_package( SFML 2.5 COMPONENTS graphics window system network audio REQUIRED )

# Recursively find files
file( GLOB_RECURSE HPPS "${INCLUDE_PATH}/*.hpp" )
file( GLOB_RECURSE INLS "${INCLUDE_PATH}/*.inl" )
file( GLOB_RECURSE CPPS "${SOURCE_PATH}/*.cpp"  )

add_executable( ${TARGET} ${CPPS} ${INLS} ${HPPS} )

# Include header file directory to target
target_include_directories( ${TARGET} PUBLIC $<BUILD_INTERFACE:${INCLUDE_PATH}> $<INSTALL_INTERFACE:include/> )

target_link_libraries( ${TARGET} PUBLIC sfml-graphics sfml-window sfml-system sfml-network sfml-audio )

if( WIN32 )
   target_compile_definitions( ${TARGET} PRIVATE WIN32 )
elseif( APPLE )
    find_library( FOUNDATION_LIBRARY Foundation REQUIRED )
    find_library( COREGRAPHICS_LIBRARY CoreGraphics REQUIRED )

    target_link_libraries( ${TARGET} PUBLIC ${FOUNDATION_LIBRARY} ${COREGRAPHICS_LIBRARY} )
elseif( "${CMAKE_SYSTEM_NAME}" MATCHES "Linux" )
    find_package( X11 REQUIRED )
    target_link_libraries( ${TARGET} PUBLIC ${X11_LIBRARIES} )    
endif()

if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(TARGET ${TARGET} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:${TARGET}> $<TARGET_FILE_DIR:${TARGET}> COMMAND_EXPAND_LISTS)
endif()

install(TARGETS ${TARGET}
        RUNTIME DESTINATION)