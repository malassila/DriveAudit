#!/bin/bash
#
# Easier to read smartctl
#  @Author: Matt
#
# ===colors===
NC='\033[0m'       # Text Reset (No Color)
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
RedLite='\033[0;91m'	  # Red Lite
Green='\033[0;32m'        # Green
Yellow='\033[0;93m'       # Yellow
Orange='\033[0;33m'	  # Orange
Blue='\033[0;34m'         # Blue
BlueLite='\033[0;94m'     # Blue Lite
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Grey='\033[0;90m'	  # Grey
# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
URedLite='\033[4;91m'	  # Red Lite
UGreen='\033[4;32m'       # Green
UYellow='\033[4;93m'      # Yellow
UOrange='\033[4;33m'	  # Orange
UBlue='\033[4;34m'        # Blue
UBlueLite='\033[4;94m'    # Blue Lite
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White
UGrey='\033[4;90m'	  # Grey
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BRedLite='\033[1;91m'     # Red Lite
BGreen='\033[1;32m'       # Green
BYellow='\033[1;93m'      # Yellow
BOrange='\033[1;33m'      # Orange
BBlue='\033[1;34m'        # Blue
BBlueLite='\033[1;94m'    # Blue Lite
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
BGrey='\033[1;90m'        # Grey
# ===variables===
DEVICE="$@"
echo $DEVICE" Device"
TEMPFILE="/tmp/smartctl_$(date)"
CELSIUS=$'\xc2\xb0'C
# ===help option===
if [ "$DEVICE" = "--help" ]
	then
		echo "Use lazy-smartctl with the same options as you would use smartctl"
	exit
fi
# ===colecting information===
smartctl $DEVICE > $TEMPFILE
# ===functionc===
Model_Family ()
{
	cat $TEMPFILE | grep "Device Model" | awk '{ s = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }'
}
Rotation_Rate ()
{
	cat $TEMPFILE | grep "Rotation Rate" | awk '{ s = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }'
}
Power_On_Hours ()
{
#	local ontime=$(cat $TEMPFILE | grep Power_On_Hours | awk 'NF>1{print $NF}')
	local ontime=$(cat $TEMPFILE | grep Power_On_Hours | awk '{print $10}')
#    local poweron=$ontime
#    local hour=0
#    local day=0
#    local year=0
	# Convert Hours to Days to Years
#        if((poweron>23));then
#            ((hour=poweron%24))
#            ((poweron=poweron/24))
#            if((poweron>364));then
#                ((day=poweron%365))
#                ((year=poweron/365))
#            else
#                ((day=poweron))
#            fi
#        else
#            ((hour=poweron))
#       fi
#	# Check if device is reporting days or hours
#	if [[ "$(Model_Family)" =~ "SiliconMotion" || "$(Model_Family)" =~ "AnotherShowingDaysExclusion" ]]
#		then
#			echo $UWhite"PowerOn Time":$NC $Cyan$ontime "Days"$NC
#		else
#			echo $UWhite"PowerOn Time":$NC $Cyan$year"y" $day"d" $hour"h"$NC
#	fi
}
Host_Reads_32MiB ()
{
	local totalreads=$(cat $TEMPFILE | grep Host_Reads_32MiB | awk '{$10=$10/32; printf "%f\n",$10}')
	# Check to see if the option is included
	if [ ! -z "$totalreads" ]
		then
			echo $UWhite"Total Reads:"$NC $Yellow$totalreads "GB"$NC
	fi
}
Host_Writes_32MiB ()
{
	local totalwrite=$(cat $TEMPFILE | grep Host_Writes_32MiB | awk '{$10=$10/32; printf "%f\n",$10}')
	# Check to see if the option is included
	if [ ! -z "$totalwrite" ]
		then
			echo $UWhite"Total Writes:"$NC $RedLite$totalwrite "GB"$NC
	fi
}
Total_LBAs_Read ()
{
	local totalreads=$(cat $TEMPFILE | grep Total_LBAs_Read | awk '{$10=$10*512/1024/1024/1024; printf "%f\n",$10}')
	# Check to see if the option is included
	if [ ! -z "$totalreads" ]
		then
			echo $UWhite"Total Reads:"$NC $Yellow$totalreads "GB"$NC
	fi
}
Total_LBAs_Written ()
{
	local totalwrite=$(cat $TEMPFILE | grep Total_LBAs_Written | awk '{$10=$10*512/1024/1024/1024; printf "%f\n",$10}')
	# Check to see if the option is included
	if [ ! -z "$totalwrite" ]
		then
			echo $UWhite"Total Writes:"$NC $RedLite$totalwrite "GB"$NC
	fi
}
Lifetime_Writes_GiB ()
{
	local totalreads=$(cat $TEMPFILE | grep Lifetime_Writes_GiB | awk '{$10=$10/8; printf "%f\n",$10}')
	# Check to see if the option is included
	if [ ! -z "$totalreads" ]
		then
			echo $UWhite"Total Reads:"$NC $Yellow$totalreads "GB"$NC
	fi
}
Lifetime_Reads_GiB ()
{
	local totalwrite=$(cat $TEMPFILE | grep Lifetime_Reads_GiB | awk '{$10=$10/8; printf "%f\n",$10}')
	# Check to see if the option is included
	if [ ! -z "$totalwrite" ]
		then
			echo $UWhite"Total Writes:"$NC $RedLite$totalwrite "GB"$NC
	fi
}
Remaining_Lifetime_Perc ()
{
	local life=$(cat $TEMPFILE | grep Remaining_Lifetime_Perc | awk 'NF>1{print $NF}')
	# Check to see if the option is included
	if [ ! -z "$life" ]
		then
			echo  $UWhite"Life:"$NC $life"%"
	fi
}
Healt_Status ()
{
	local devhealth=$(cat $TEMPFILE | grep -i "overall-health" | awk 'NF>1{print $NF}')
	# Check to see if the option is included
	if [ ! -z "$devhealth" ]
		then
			echo $UWhite"Self-assessment test:"$NC $devhealth
	fi
}
Reallocated_Sector_Ct ()
{
	local reallocated=$(cat $TEMPFILE | grep "Reallocated_Sector_Ct" | awk 'NF>1{print $NF}')
	if [[ "$reallocated" -ne "0" ]]
		then
			echo -e $UWhite"Reallocated Sectors:"$NC $Red$reallocated$NC
	fi
}
Device_Size ()
{
	#local cut_DEVICE=$(echo $DEVICE | awk 'NF>1{print $NF}')
	#local lsblkout=$(lsblk --output SIZE -n -d $cut_DEVICE)
	local lsblkout=$(cat $TEMPFILE | grep -i "capacity" | awk '{ s = ""; for (i = 5; i <= NF; i++) s = s $i " "; print s }')
		echo $Green$lsblkout$NC
}
Smart_Error_Count ()
{
	local errors=$(cat $TEMPFILE | grep -i "error count" | awk 'NF>1{print $NF}')
	# Check to see if the option is included
	if [ ! -z "$errors" ]
		then
			echo $UWhite"SMART Errors:"$NC $errors
	fi
}
Temperature_Celsius ()
{
	local temperature=$(cat $TEMPFILE | grep Temperature_Celsius | awk '{print $10}')
	local colorvar=$White
	if (( $"temperature" > "20" && $"temperature" < "40" ))
		then
		colorvar=$Green
	elif (( $"temperature" < "5" || $"temperature" > "50" ))
		then
		colorvar=$Red
	else
		colorvar=$Yellow
	fi
	echo -e $UWhite"Temp:"$NC $colorvar$temperature$CELSIUS$NC
}
Offline_Uncorrectable ()
{
	local offline=$(cat $TEMPFILE | grep Offline_Uncorrectable | awk '{print $10}')
	if [[ $"offline" -ne "0" ]]
		then
			echo -e $UWhite"Bad Sectors:"$NC $Red$offline$NC
	fi
}
UDMA_CRC_Error_Count()
{
	local udma=$(cat $TEMPFILE | grep UDMA_CRC_Error_Count | awk '{print $10}')
	if [[ $"udma" -ne "0" ]]
		then
			echo -e $UWhite"Cable or Interface Errors:"$NC $Red$udma$NC
	fi
}
Current_Pending_Sector()
{
	local pending=$(cat $TEMPFILE | grep Current_Pending_Sector | awk '{print $10}')
	if [[ $"pending" -ne "0" ]]
		then
			echo -e $UWhite"Current_Pending_Sectors:"$NC $Red$pending$NC
	fi
}
# ====output===
echo
echo -e $UWhite"Device:"$NC $BlueLite$(Model_Family)$NC"-" $Blue$(Rotation_Rate)$NC"-" $(Device_Size)
echo -e $(Power_On_Hours) $(Host_Reads_32MiB) $(Host_Writes_32MiB) $(Total_LBAs_Read) $(Total_LBAs_Written) $(Lifetime_Writes_GiB) $(Lifetime_Reads_GiB)
echo -e $(Healt_Status) $(Reallocated_Sector_Ct) $(Offline_Uncorrectable) $(UDMA_CRC_Error_Count) $(Smart_Error_Count) $(Current_Pending_Sector) $(Remaining_Lifetime_Perc) $(Temperature_Celsius)
echo
# ===cleaning===
rm $TEMPFILE
