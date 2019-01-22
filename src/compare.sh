#!/bin/bash
ORIGINAL_PATH="/home/icas/Desktop/Clean/test/testa"
COMPARE_PATH"/home/icas/Desktop/Clean/test/testb"

# Log-File Paths
SUCCESSPATH="/home/icas/Desktop/Clean/test/src/logs/success.log"
SIZE_ERROR_PATH="/home/icas/Desktop/Clean/test/src/logs/sizeError.log"
NON_EXIST_PATH="/home/icas/Desktop/Clean/test/src/logs/nonExistanceError.log"

# CLEAN-UP
rm ${SUCCESSPATH}
rm ${SIZE_ERROR_PATH}
rm ${NON_EXIST_PATH}

# compare
find ${ORIGINAL_PATH} -name '*' | while read line; do
  ORIGINAL_FILENAME=""
  ORIGINAL_FILESIZE=0
  COMPARE_FILENAME=""
  COMPARE_FILESIZE=0

  ORIGINAL_FILENAME=${line}
  ORIGINAL_FILESIZE=$(stat -c%s "${ORIGINAL_FILENAME}")
  firstString="${ORIGINAL_FILENAME}"
  secondString="/test/testb"
  thirdString="/test/testa"
  COMPARE_FILENAME="${firstString/$thirdString/$secondString}"
  if [ -f $COMPARE_FILENAME ]
  then
    COMPARE_FILESIZE=$(stat -c%s "${COMPARE_FILENAME}")
    if [ "$COMPARE_FILESIZE" -ne "$ORIGINAL_FILESIZE" ]
    then
      echo "Attention : For ${ORIGINAL_FILENAME} and ${COMPARE_FILENAME} file sizes are not equal : $ORIGINAL_FILESIZE =! $COMPARE_FILESIZE." >> ${SIZE_ERROR_PATH}
    else
      echo "Success ${ORIGINAL_FILENAME} and ${COMPARE_FILENAME} are equally sized : $ORIGINAL_FILESIZE." >> ${SUCCESSPATH}
    fi
  else
    echo "File $COMPARE_FILENAME does not exist." >> ${NON_EXIST_PATH}
  fi
done


