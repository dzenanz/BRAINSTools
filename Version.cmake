#
# ONLY MODIFY TO CHANGE VERSION
#
# The number of commits since last this file has changed it used to
# define "dev" and "post", modification of this file will reset that
# version.
#

# Version info
include(ProjectSourceVersion)

## NOTE:    NEED TO MANUALLY UPDATE ALL XML FILES
##       -  vim $(git grep  -l "<version>" -- '*.xml')
##                     :%s/< *version *> *[^<]*</<version>5.8.0</g
##       -  manually modify CMakeList.txt to update version in project() command
##       -  manually edit CMake/ProjectSourceVersionVars.cmake and change version defaults
##       -  Change values in this file
##       -  git commit -a -m"ENH: Updating version to v5.8.0"
##       -  git tag -a v5.8.0 -m"ENH: Tagging v5.8.0"
##       -  git push origin v5.8.0
##       -  git push origin --tags  ## DON'T forget to do this!
## See note above for updating versions
#-- DON'T OVERRIDE projcet() set(${PROJECT_NAME}_VERSION_MAJOR ${_GIT_VERSION_MAJOR})
#-- DON'T OVERRIDE project() set(${PROJECT_NAME}_VERSION_MINOR ${_GIT_VERSION_MINOR})
#-- DON'T OVERRIDE project() set(${PROJECT_NAME}_VERSION_PATCH ${_GIT_VERSION_PATCH})
#-- DON"T OVERRIDE project() set(${PROJECT_NAME}_VERSION_TWEAK ${_GIT_VERSION_TWEAK})
### SEE ---- NOTE  --- ABOVE --- FOR CONSISTENT -- TAGGING
if(NOT "${${PROJECT_NAME}_VERSION_MAJOR}" EQUAL "${_GIT_VERSION_MAJOR}")
  message(WARNING "VERSION_MAJOR from project not match git tag (${_GIT_TAG}) version: \"${${PROJECT_NAME}_VERSION_MAJOR}\" EQUAL \"${_GIT_VERSION_MAJOR}\"")
endif()
if(NOT "${${PROJECT_NAME}_VERSION_MINOR}" EQUAL "${_GIT_VERSION_MINOR}")
  message(WARNING "VERSION_MINOR from project not match git tag ${_GIT_TAG} version: \"${${PROJECT_NAME}_VERSION_MINOR}\" EQUAL \"${_GIT_VERSION_MINOR}\"")
endif()
if(NOT "${${PROJECT_NAME}_VERSION_PATCH}" EQUAL "${_GIT_VERSION_PATCH}")
  message(WARNING "VERSION_PATCH from project not match git tag ${_GIT_TAG} version: \"${${PROJECT_NAME}_VERSION_PATCH}\" EQUAL \"${_GIT_VERSION_PATCH}\"")
endif()

# pre-release codes are defined based on suffix of most recent tags.

# a[N]+<b[N]+<c[N]+=rc[N]+
if(NOT ${_GIT_VERSION_RC} STREQUAL "" )
  set(${PROJECT_NAME}_VERSION_RC "${_GIT_VERSION_RC}")
endif()


# The hash is the current git sha1 hash tag of the HEAD.
set(${PROJECT_NAME}_VERSION_HASH "${_GIT_VERSION_HASH}")

# DEV or POST is set to the number of commits since this file has been
# changed. If the MAJOR.MINOR.[PATCH[.TWEAK]] matches "closest"
# version tag then its consider in the release branch and POST is set
# while DEV is undefined, otherwise we are considered under
# development and DEV is set and POST is undefined.
if(DEFINED _GIT_VERSION_POST)
  set(${PROJECT_NAME}_VERSION_POST "${_GIT_VERSION_POST}")
elseif(DEFINED _GIT_VERSION_DEV)
  set(${PROJECT_NAME}_VERSION_DEV "${_GIT_VERSION_DEV}")
endif()
