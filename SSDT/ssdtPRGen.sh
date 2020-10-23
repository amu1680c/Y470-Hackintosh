#!/bin/sh
#
# Script (ssdtPRGen.sh) to create ssdt-pr.dsl for Apple Power Management Support.
#
# Version 0.9 - Copyright (c) 2012 by RevoGirl <RevoGirl@rocketmail.com>
#
# Version 0.9a
#  Modified by RehabMan for mass generate of Intel i3/i5/i7 mobile processors
#

# set -x # Used for tracing errors (can be put anywhere in the script).

#================================= GLOBAL VARS ==================================

ssdtPR=/tmp/ssdt-pr.dsl
ssdtPRcompiled=/tmp/ssdt-pr.aml


#--------------------------------------------------------------------------------

function _printHeader()
{
	echo '/*'                                                               >  $ssdtPR
	echo ' * Intel ACPI Component Architecture'                             >> $ssdtPR
	echo ' * AML Disassembler version 20110316-64 [Mar 16 2011]'            >> $ssdtPR
	echo ' * Copyright (c) 2000 - 2011 Intel Corporation'                   >> $ssdtPR
	echo ' * '                                                              >> $ssdtPR
	echo ' * Original Table Header:'                                        >> $ssdtPR
	echo ' *     Signature        "SSDT"'                                   >> $ssdtPR
	echo ' *     Length           0x0000036A (874)'                         >> $ssdtPR
	echo ' *     Revision         0x01'                                     >> $ssdtPR
	echo ' *     Checksum         0x98'                                     >> $ssdtPR
	echo ' *     OEM ID           "APPLE "'                                 >> $ssdtPR
	echo ' *     OEM Table ID     "CpuPm"'                                  >> $ssdtPR
	echo ' *     OEM Revision     0x00001000 (4096)'                        >> $ssdtPR
	echo ' *     Compiler ID      "INTL"'                                   >> $ssdtPR
	echo ' *     Compiler Version 0x20110316 (537985814)'                   >> $ssdtPR
	echo ' */'                                                              >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
  printf "DefinitionBlock (\"%s\"" $ssdtPRcompiled >> $ssdtPR
	echo ', "SSDT", 1, "APPLE ", "CpuPm", 0x00001000)'>> $ssdtPR
	echo '{'                                                                >> $ssdtPR
}


#--------------------------------------------------------------------------------

function _printExternals()
{
	currentCPU=0;

	while [ $currentCPU -lt $1 ]; do
		echo '    External (\_PR_.CPU'$currentCPU', DeviceObj)'             >> $ssdtPR
		let currentCPU+=1
	done

	echo ''                                                                 >> $ssdtPR
}


#--------------------------------------------------------------------------------

function _printScopeStart()
{
	echo '    Scope (\_PR.CPU0)'                                            >> $ssdtPR
	echo '    {'                                                            >> $ssdtPR
	echo '        Method (APSN, 0, NotSerialized)'							>> $ssdtPR
	echo '        {'														>> $ssdtPR
  printf "            Return (0x%02X)\n" $1									>> $ssdtPR
    echo '        }'														>> $ssdtPR
    echo '        Method (APSS, 0, NotSerialized)'							>> $ssdtPR
    echo '        {'														>> $ssdtPR
  printf "            Return (Package (0x%02X)\n" $2						>> $ssdtPR
	echo '            {'                                                    >> $ssdtPR
}


#--------------------------------------------------------------------------------

function _printPackages()
{
	let tdp=($1*1000)
	let minFrequency=$2
	let maxNonTurboFrequency=$3
	let frequency=$4
	let max_ratio=($frequency/100)

	while [ $frequency -gt $minFrequency ]; do
		echo '                Package (0x06)'                           	>> $ssdtPR
		echo '                {'                                        	>> $ssdtPR
	  printf "                    %d" $frequency                            >> $ssdtPR
		echo ','                                                            >> $ssdtPR

		let ratio=$frequency/100
        
        if [ $frequency -lt $maxNonTurboFrequency ];
            then
                power=$(echo "scale=6;m=((1.1-(($max_ratio-$ratio)*0.00625))/1.1);(($ratio/$max_ratio)*(m*m)*$tdp);" | bc | sed -e 's/.[0-9A-F]*$//')
            else
                power=$tdp
        fi

	  printf "                    0x%08X" $power                            >> $ssdtPR

		echo ','                                                            >> $ssdtPR

		echo '                    0x0A,'                                    >> $ssdtPR
		echo '                    0x0A,'                                    >> $ssdtPR
 
	  printf "                    0x%02X" $ratio                            >> $ssdtPR

		echo '00,'                                                          >> $ssdtPR

      printf "                    0x%02X" $ratio                            >> $ssdtPR

		echo '00'                                                           >> $ssdtPR

		let frequency-=100

		if [ $frequency -eq $minFrequency ];
			then
				echo '                }'                                    >> $ssdtPR
			else
				echo '                },'                                   >> $ssdtPR
		fi
	done

	echo '            })'                                                   >> $ssdtPR
	echo '        }'														>> $ssdtPR
}


#--------------------------------------------------------------------------------

function _printCSTScope()
{
	echo ''                                                                 >> $ssdtPR
	echo '        Method (ACST, 0, NotSerialized)'                          >> $ssdtPR
	echo '        {'                                                        >> $ssdtPR
	echo '            Return (Package (0x06)'                               >> $ssdtPR
	echo '            {'                                                    >> $ssdtPR
	echo '                One,'                                             >> $ssdtPR
	echo '                0x04,'                                            >> $ssdtPR
	echo '                Package (0x04)'                                   >> $ssdtPR
	echo '                {'                                                >> $ssdtPR
	echo '                    ResourceTemplate ()'                          >> $ssdtPR
	echo '                    {'                                            >> $ssdtPR
	echo '                        Register (FFixedHW,'                      >> $ssdtPR
	echo '                            0x01,               // Bit Width'		>> $ssdtPR
	echo '                            0x02,               // Bit Offset'	>> $ssdtPR
	echo '                            0x0000000000000000, // Address'		>> $ssdtPR
	echo '                            0x01,               // Access Size'	>> $ssdtPR
	echo '                            )'                                    >> $ssdtPR
	echo '                    },'                                           >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                    One,'                                         >> $ssdtPR
	echo '                    0x03,'                                        >> $ssdtPR
	echo '                    0x03E8'                                       >> $ssdtPR
	echo '                },'                                               >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                Package (0x04)'                                   >> $ssdtPR
	echo '                {'                                                >> $ssdtPR
	echo '                    ResourceTemplate ()'                          >> $ssdtPR
	echo '                    {'                                            >> $ssdtPR
	echo '                        Register (FFixedHW,'                      >> $ssdtPR
	echo '                            0x01,               // Bit Width'		>> $ssdtPR
	echo '                            0x02,               // Bit Offset'	>> $ssdtPR
	echo '                            0x0000000000000010, // Address'		>> $ssdtPR
	echo '                            0x03,               // Access Size'	>> $ssdtPR
	echo '                            )'                                    >> $ssdtPR
	echo '                    },'                                           >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                    0x03,'                                        >> $ssdtPR
	echo '                    0xCD,'                                        >> $ssdtPR
	echo '                    0x01F4'                                       >> $ssdtPR
	echo '                },'                                               >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                Package (0x04)'                                   >> $ssdtPR
	echo '                {'                                                >> $ssdtPR
	echo '                    ResourceTemplate ()'                          >> $ssdtPR
	echo '                    {'                                            >> $ssdtPR
	echo '                        Register (FFixedHW,'                      >> $ssdtPR
	echo '                            0x01,               // Bit Width'		>> $ssdtPR
	echo '                            0x02,               // Bit Offset'	>> $ssdtPR
	echo '                            0x0000000000000020, // Address'		>> $ssdtPR
	echo '                            0x03,               // Access Size'	>> $ssdtPR
	echo '                            )'                                    >> $ssdtPR
	echo '                    },'                                           >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                    0x06,'                                        >> $ssdtPR
	echo '                    0xF5,'                                        >> $ssdtPR
	echo '                    0x015E'                                       >> $ssdtPR
	echo '                },'                                               >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                Package (0x04)'                                   >> $ssdtPR
	echo '                {'                                                >> $ssdtPR
	echo '                    ResourceTemplate ()'                          >> $ssdtPR
	echo '                    {'                                            >> $ssdtPR
	echo '                        Register (FFixedHW,'                      >> $ssdtPR
	echo '                            0x01,               // Bit Width'		>> $ssdtPR
	echo '                            0x02,               // Bit Offset'	>> $ssdtPR
	echo '                            0x0000000000000030, // Address'		>> $ssdtPR
	echo '                            0x03,               // Access Size'	>> $ssdtPR
	echo '                            )'                                    >> $ssdtPR
	echo '                    },'                                           >> $ssdtPR
	echo ''                                                                 >> $ssdtPR
	echo '                    0x07,'                                        >> $ssdtPR
	echo '                    0xF5,'                                        >> $ssdtPR
	echo '                    0xC8'                                         >> $ssdtPR
	echo '                }'                                                >> $ssdtPR
	echo '            })'                                                   >> $ssdtPR
	echo '        }'                                                        >> $ssdtPR
	echo '    }'                                                            >> $ssdtPR
}


#--------------------------------------------------------------------------------

function _printCPUScopes()
{
	currentCPU=1;

	while [ $currentCPU -lt $1 ]; do
		echo ''                                                             >> $ssdtPR
		echo '    Scope (\_PR.CPU'$currentCPU')'                            >> $ssdtPR
		echo '    {'                                                        >> $ssdtPR
		echo '        Method (APSN, 0, NotSerialized)'                      >> $ssdtPR
		echo '        {'                                                    >> $ssdtPR
		echo '            Return (\_PR.CPU0.APSN())'                        >> $ssdtPR
		echo '        }'                                                    >> $ssdtPR
		echo '        Method (APSS, 0, NotSerialized)'                      >> $ssdtPR
		echo '        {'                                                    >> $ssdtPR
		echo '            Return (\_PR.CPU0.APSS())'                        >> $ssdtPR
		echo '        }'                                                    >> $ssdtPR
		echo '        Method (ACST, 0, NotSerialized)'                      >> $ssdtPR
		echo '        {'                                                    >> $ssdtPR
		echo '            Return (\_PR.CPU0.ACST())'                        >> $ssdtPR
		echo '        }'                                                    >> $ssdtPR
		echo '    }'                                                        >> $ssdtPR
		let currentCPU+=1
	done

	echo '}'                                                                >> $ssdtPR
}


#--------------------------------------------------------------------------------
#
# Only administrators (root) are allowed to run this script.
#
#--------------------------------------------------------------------------------

function _isRoot()
{
  if [ $(id -u) != 0 ]; then
      echo "This script must be run as root" 1>&2
      exit 1
  fi

  echo 1
}


#--------------------------------------------------------------------------------

function main()
{
    #
    # Command line arguments.
    #
    # ./ssdtPRGen.sh TDP LogicalCPUs LowFreq HighFreq TurboFreq OutputFile AMLfile

    let tdp=$1
    let logicalCPUs=$2
    let minFrequency=$3
    let frequency=$4
    let maxTurboFrequency=$5
    
    ssdtPR=$6
    ssdtPRcompiled=$7


    #
    # Do not change anything below this line!
    #

	#let logicalCPUs=$(echo `sysctl hw.logicalcpu` | sed -e 's/^hw.logicalcpu: //')

	#let frequency=$(echo `sysctl hw.cpufrequency` | sed -e 's/^hw.cpufrequency: //')
    #let frequency=($frequency / 1000000)

    let turboStates=$(echo "(($maxTurboFrequency - $frequency) / 100)" | bc)
    
    let minFrequency=($minFrequency - 100)
    let packagelength=$(echo "(($maxTurboFrequency - $minFrequency) / 100)" | bc)

    _printHeader
	_printExternals $logicalCPUs
	_printScopeStart $turboStates $packagelength
	_printPackages $tdp $minFrequency $frequency $maxTurboFrequency
	_printCSTScope
	_printCPUScopes $logicalCPUs
}


#==================================== START =====================================
 
#
# Check number of arguments.
#
if [ $# -eq 7 ];
    then
        main $1 $2 $3 $4 $5 $6 $7
    else
        echo "Usage: $0 TDP LogicalCPUs MinFrequency MaxFrequency MaxTurboFrequency OutputFile AMLfile"
        exit 1
fi

#================================================================================

exit 0
