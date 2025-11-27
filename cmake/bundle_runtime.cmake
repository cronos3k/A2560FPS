cmake_minimum_required(VERSION 3.19)

# Variables expected (passed with -D or set by caller):
#  BIN           - full path to the built executable (abuse.exe)
#  DEST          - destination directory to copy DLLs into
#  RUNTIME_DIRS  - semicolon-separated list of directories to search for DLLs

if(NOT DEFINED BIN OR NOT DEFINED DEST)
  message(FATAL_ERROR "bundle_runtime.cmake: BIN and DEST must be defined")
endif()

set(_dirs)
if(DEFINED RUNTIME_DIRS)
  separate_arguments(RUNTIME_DIRS_LIST NATIVE_COMMAND "${RUNTIME_DIRS}")
  list(APPEND _dirs ${RUNTIME_DIRS_LIST})
endif()

file(GET_RUNTIME_DEPENDENCIES
  RESOLVED_DEPENDENCIES_VAR _deps
  UNRESOLVED_DEPENDENCIES_VAR _unresolved
  EXECUTABLES "${BIN}"
  DIRECTORIES ${_dirs}
)

foreach(_f IN LISTS _deps)
  if(EXISTS "${_f}")
    get_filename_component(_name "${_f}" NAME)
    file(COPY "${_f}" DESTINATION "${DEST}")
  endif()
endforeach()

if(_unresolved)
  message(WARNING "Unresolved runtime dependencies: ${_unresolved}")
endif()

