#!/bin/bash

DEPS_django=( sqlite3 python)
#DEPS_django=( sqlite3 python setuptools)

#URL_django=https://pypi.python.org/packages/7f/a6/4ab15169e9075635c0a64bb0a569d1e02c7bd9b5ba839f05fe5d1fbbe3fb/Django-1.9.2.tar.gz
#VERSION_django=${VERSION_django:-1.9.2}
#MD5_django=ee90280973d435a1a6aa01b453b50cd1

URL_django=https://pypi.python.org/packages/c3/c2/6096bf5d0caa4e3d5b985ac72e3a0c795e37fa7407d6c85460b2a105b467/Django-1.10.5.tar.gz
VERSION_django=${VERSION_django:-1.10.5}
MD5_django=3fce02f1e6461fec21f1f15ea7489924

BUILD_django=$BUILD_PATH/django/$(get_directory $URL_django)
RECIPE_django=$RECIPES_PATH/django


function prebuild_django() {

    cd $BUILD_django

    # check marker in our source build
    if [ -f .patched ]; then
	# no patch needed
	return
    fi

    try patch -p1 < $RECIPE_django/migration.patch

    true
}

function shouldbuild_django() {
	if [ -d "$SITEPACKAGES_PATH/django" ]; then
		DO_BUILD=0
	fi

	DO_BUILD=1

}

function build_django() {
	cd $BUILD_django
	push_arm
	try $HOSTPYTHON setup.py install
	pop_arm
}

function postbuild_django() {
	# ensure the blacklist doesn't contain wsgiref or unittest
	$SED '/unittest/d' $BUILD_PATH/blacklist.txt
	$SED '/wsgiref/d' $BUILD_PATH/blacklist.txt
}
