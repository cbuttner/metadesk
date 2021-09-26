#!/bin/bash

###### Get Paths ##############################################################
og_path=$PWD
cd "$(dirname "$0")"
cd ..
root_path=$PWD
build_path=$root_path/build
bin_path=$root_path/bin

# TODO(allen): IMPORTANT!! Build scripts here are a bit of a mess. They force
# us to use non-absolute paths for builds, but then we need absolute paths for
# other things. Not good!
examps_path=$root_path/examples
examps=examples


###### Script #################################################################
echo ~~~ Type Info Example ~~~
$bin_path/bld_core.sh show_ctx

echo ~~~ Building Metaprogram ~~~
$bin_path/bld_core.sh unit type_metadata $examps/type_metadata/type_metadata.c

echo ~~~ Running Metaprogram ~~~
cd $examps/type_metadata/generated
$build_path/type_metadata.exe $examps_path/type_metadata/types.mdesk
echo

if [ -f $examps_path/type_metadata/generated/meta_types.h ]; then
echo ~~~ Building Program ~~~
$bin_path/bld_core.sh unit type_info $examps/type_metadata/type_info_final_program.c
else
echo !!! Skipping Program !!!
fi

echo

###### Restore Path ###########################################################
cd $og_path
