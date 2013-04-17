################################################################################
#
# CMake script for finding ACE.
# If the optional ACE_ROOT_DIR environment variable exists, header files and
# libraries will be searched in the ACE_ROOT_DIR/include and ACE_ROOT_DIR/libs
# directories, respectively. Otherwise the default CMake search process will be
# used.
#
# This script creates the following variables:
#  ACE_FOUND: Boolean that indicates if the package was found
#  ACE_INCLUDE_DIR: Paths to the necessary header files
#  ACE_LIBRARY: Package libraries
#
################################################################################

include(FindPackageHandleStandardArgs)

# See if ACE_ROOT is not already set in CMake
IF (NOT ACE_ROOT)
    # See if ACE_ROOT is set in process environment
    IF ( NOT $ENV{ACE_ROOT} STREQUAL "" )
        SET (ACE_ROOT "$ENV{ACE_ROOT}")
	MESSAGE(STATUS "Detected ACE_ROOT set to '${ACE_ROOT}'")
    ENDIF ()
ENDIF ()

# If ACE_ROOT is available, set up our hints
IF (ACE_ROOT)
    SET (ACE_INCLUDE_HINTS HINTS "${ACE_ROOT}/include" "${ACE_ROOT}")
    SET (ACE_LIBRARY_HINTS HINTS "${ACE_ROOT}/lib")
ENDIF ()

# Find headers and libraries
find_path(ACE_INCLUDE_DIR NAMES ace/ACE.h ${ACE_INCLUDE_HINTS})
find_library(ACE_LIBRARY NAMES ACE ${ACE_LIBRARY_HINTS})

# Set ACE_FOUND honoring the QUIET and REQUIRED arguments
find_package_handle_standard_args(ACE DEFAULT_MSG ACE_LIBRARY ACE_INCLUDE_DIR)

# Advanced options for not cluttering the cmake UIs
mark_as_advanced(ACE_INCLUDE_DIR ACE_LIBRARY)
