################################################################################
#
# CMake script for finding bintalk.
# If the optional BINTALK_ROOT_DIR environment variable exists, header files and
# libraries will be searched in the BINTALK_ROOT_DIR/include and BINTALK_ROOT_DIR/libs
# directories, respectively. Otherwise the default CMake search process will be
# used.
#
# This script creates the following variables:
#  BINTALK_FOUND: Boolean that indicates if the package was found
#  BINTALK_INCLUDE_DIR: Paths to the necessary header files
#  BINTALK_LIBRARY: Package libraries
#
################################################################################


# See if BINTALK_ROOT is not already set in CMake
IF (NOT BINTALK_ROOT)
	# See if BINTALK_ROOT is set in process environment
	IF ( NOT $ENV{BINTALK_ROOT} STREQUAL "" )
		SET (BINTALK_ROOT "$ENV{BINTALK_ROOT}")
		MESSAGE(STATUS "Detected BINTALK_ROOT set to '${BINTALK_ROOT}'")
    ENDIF ()
ENDIF ()

# If BINTALK_ROOT is available, set up our hints
IF (BINTALK_ROOT)
	SET (BINTALK_EXECUTABLE_HINTS HINTS "${BINTALK_ROOT}/bin" "${BINTALK_ROOT}")
	SET (BINTALK_INCLUDE_HINTS HINTS "${BINTALK_ROOT}/include" "${BINTALK_ROOT}")
	SET (BINTALK_LIBRARY_HINTS HINTS "${BINTALK_ROOT}/lib")
ENDIF ()

# Find headers and libraries
find_program(BINTALK_EXECUTABLE bintalk HINTS ${BINTALK_EXECUTABLE_HINTS})
find_path(BINTALK_INCLUDE_DIR bintalk/ProtocolReader.h HINTS ${BINTALK_INCLUDE_HINTS})
find_library(BINTALK_LIBRARY bintalk_cpp HINTS ${BINTALK_LIBRARY_HINTS})


# Set BINTALK_FOUND honoring the QUIET and REQUIRED arguments
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(BINTALK DEFAULT_MSG BINTALK_EXECUTABLE BINTALK_LIBRARY BINTALK_INCLUDE_DIR)

# Advanced options for not cluttering the cmake UIs
mark_as_advanced(BINTALK_EXECUTABLE BINTALK_INCLUDE_DIR BINTALK_LIBRARY)
