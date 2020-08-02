#!/bin/bash
EASTD=cache-east
WESTD=cache-west
SRCD=/c/data
ARCHD=/c/data/cache-arch
DAYOLDER=30

SRC_EAST=${SRCD}/${EASTD}
SRC_WEST=${SRCD}/${WESTD}
ARCH_EAST=${ARCHD}/${EASTD}
ARCH_WEST=${ARCHD}/${WESTD}

function move_src_to_arch () {
    if [ $# -ne 3 ];
        then echo "incorrect number of arguments passed to move_src_to_arch"
        exit
    fi
    local d=${1}
    local arc=${2}
    local older=${3}
    echo "*********************"
    date
    echo "** Processing ${d} "
    echo "** Synching +${older}"
  
    cd "${d}" || exit
    mkdir -p "${arc}"
    find . -type f -mtime +"${older}" |
    while read -r fname 
    do
        tar cf - "${fname}" | (cd "${arc}" && tar pxf -)
    done
    echo "** Completed ${d}"
    date
    echo "*********************"
}

function remove_old_from_src () {
    if [ $# -ne 2 ]; then
        echo "incorrect number of arguments passed to move_src_to_arch"
        exit
    fi
    local d=${1}
    local older=${2}
    echo "*********************"
    date
    echo "** Deleting +${older} old files from ${d}"
    find "${d}" -type f -mtime +"${older}" -exec rm -f {} \; 

    echo "** Remove empty directories from ${d}"
    find "${d}" -empty -type d -delete
    date
    echo "*********************"
}

echo " "
echo "*** Processing EAST ***"
move_src_to_arch ${SRC_EAST} ${ARCH_EAST} ${DAYOLDER}
remove_old_from_src ${SRC_EAST} ${DAYOLDER}

echo " "
echo "*** Processing WEST ***"
move_src_to_arch ${SRC_WEST} ${ARCH_WEST} ${DAYOLDER}
remove_old_from_src ${SRC_WEST} ${DAYOLDER}

###