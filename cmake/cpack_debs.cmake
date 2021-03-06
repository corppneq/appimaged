# required for DEB-DEFAULT to work as intended
cmake_minimum_required(VERSION 3.6)

set(CPACK_GENERATOR "DEB")

# versioning
# it appears setting CPACK_DEBIAN_PACKAGE_VERSION doesn't work, hence setting CPACK_PACKAGE_VERSION
set(CPACK_PACKAGE_VERSION ${APPIMAGED_VERSION})

# use git hash as package release
set(CPACK_DEBIAN_PACKAGE_RELEASE "git${APPIMAGED_GIT_COMMIT}")

# append build ID, similar to AppImage naming
if(DEFINED ENV{TRAVIS_BUILD_NUMBER})
    set(CPACK_DEBIAN_PACKAGE_RELEASE "${CPACK_DEBIAN_PACKAGE_RELEASE}~travis$ENV{TRAVIS_BUILD_NUMBER}")
else()
    set(CPACK_DEBIAN_PACKAGE_RELEASE "${CPACK_DEBIAN_PACKAGE_RELEASE}~local")
endif()

if(DEFINED ENV{ARCH})
    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE $ENV{ARCH})
    if(CPACK_DEBIAN_PACKAGE_ARCHITECTURE MATCHES "i686")
        set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "i386")
    endif()
endif()

set(CPACK_DEBIAN_PACKAGE_MAINTAINER "AppImage Team")
set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "https://appimage.org/")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
set(CPACK_PACKAGE_DESCRIPTION_FILE "${PROJECT_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")

set(CPACK_DEBIAN_APPIMAGED_PACKAGE_NAME "appimaged")
set(CPACK_COMPONENT_APPIMAGED_DESCRIPTION
    "Optional AppImage daemon for desktop integration.\n  Integrates AppImages into the desktop, e.g., installs icons and menu entries.")

set(CPACK_DEBIAN_APPIMAGED_PACKAGE_DEPENDS "libarchive13, libc6 (>= 2.4), libglib2.0-0, zlib1g, fuse")

set(CPACK_COMPONENTS_ALL appimaged)
set(CPACK_DEB_COMPONENT_INSTALL ON)

include(CPack)
