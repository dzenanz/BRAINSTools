
set(proj zlib)

# Set dependency list
set(${proj}_DEPENDENCIES "")

# Include dependent projects if any
ExternalProject_Include_Dependencies(${proj} PROJECT_VAR proj DEPENDS_VAR ${proj}_DEPENDENCIES)

if(${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})
  unset(zlib_DIR CACHE)
  find_package(ZLIB REQUIRED)
  set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS})
  set(ZLIB_LIBRARY ${ZLIB_LIBRARIES})
endif()

# Sanity checks
if(DEFINED zlib_DIR AND NOT EXISTS ${zlib_DIR})
  message(FATAL_ERROR "zlib_DIR variable is defined but corresponds to nonexistent directory")
endif()

if(NOT DEFINED zlib_DIR AND NOT ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})

  if(NOT DEFINED git_protocol)
    set(git_protocol "https")
  endif()

  set(EP_SOURCE_DIR ${CMAKE_BINARY_DIR}/${proj})
  set(EP_BINARY_DIR ${CMAKE_BINARY_DIR}/${proj}-build)
  #  set(EP_INSTALL_DIR ${CMAKE_BINARY_DIR}/${proj}-install)
  set(EP_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})

  ExternalProject_SetIfNotDefined(
    ${CMAKE_PROJECT_NAME}_${proj}_GIT_REPOSITORY
    "${git_protocol}://github.com/commontk/zlib.git"
    QUIET
    )

  ExternalProject_SetIfNotDefined(
    ${CMAKE_PROJECT_NAME}_${proj}_GIT_TAG
    "66a753054b356da85e1838a081aa94287226823e" # 20210122
    QUIET
    )

  ExternalProject_Add(${proj}
    ${${proj}_EP_ARGS}
    GIT_REPOSITORY "${${CMAKE_PROJECT_NAME}_${proj}_GIT_REPOSITORY}"
    GIT_TAG "${${CMAKE_PROJECT_NAME}_${proj}_GIT_TAG}"
    SOURCE_DIR ${EP_SOURCE_DIR}
    BINARY_DIR ${EP_BINARY_DIR}
    CMAKE_CACHE_ARGS
      ${EXTERNAL_PROJECT_DEFAULTS}
      -DZLIB_MANGLE_PREFIX:STRING=slicer_zlib_
      -DCMAKE_INSTALL_PREFIX:PATH=${EP_INSTALL_DIR}
    DEPENDS
      ${${proj}_DEPENDENCIES}
    )

  ExternalProject_GenerateProjectDescription_Step(${proj})

  set(zlib_DIR ${EP_INSTALL_DIR})
  set(ZLIB_ROOT ${zlib_DIR})
  set(ZLIB_INCLUDE_DIR ${zlib_DIR}/include)
  if(BUILD_SHARED_LIBS)
    set(ZLIB_LIBRARY ${zlib_DIR}/lib/libzlib${CMAKE_SHARED_LIBRARY_SUFFIX})
  else()
    set(ZLIB_LIBRARY ${zlib_DIR}/lib/libzlib${CMAKE_STATIC_LIBRARY_SUFFIX})
  endif()
else()
  # The project is provided using zlib_DIR, nevertheless since other project may depend on zlib,
  # let's add an 'empty' one
  ExternalProject_Add_Empty(${proj} DEPENDS ${${proj}_DEPENDENCIES})
endif()

mark_as_superbuild(
  VARS
    ZLIB_INCLUDE_DIR:PATH
    ZLIB_LIBRARY:FILEPATH
    ZLIB_ROOT:PATH
  LABELS "FIND_PACKAGE"
  )

ExternalProject_Message(${proj} "ZLIB_INCLUDE_DIR:${ZLIB_INCLUDE_DIR}")
ExternalProject_Message(${proj} "ZLIB_LIBRARY:${ZLIB_LIBRARY}")
if(ZLIB_ROOT)
  ExternalProject_Message(${proj} "ZLIB_ROOT:${ZLIB_ROOT}")
endif()
