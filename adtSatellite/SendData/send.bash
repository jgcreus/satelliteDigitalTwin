#!/bin/bash

# Establecer el nombre de la instancia de Azure Digital Twins // Set the Azure Digital Twins instance name
hostname="YOUR.api.digitaltwins.azure.net" # Reemplazar por su propio hostname // Replace with your own hostname

# Lista de twin IDs // List of twin IDs
declare -a twin_ids=("sat" "integrity" "sisa" "spa" "op" "ephemeris" "almanac" "sa" "ar" "sp" "sid" "iod" "ndvashs" "crc" "taccp" "gst" "gpstgstc" "gstutcc" "bgd" "ic" "cc")

# Función para generar el JSON patch dependiendo del twin_id // Function to generate the JSON patch depending on the twin_id
generate_json_patch() {
  local twin_id=$1
  local json_patch=""

  # Generar valores // Generate values
  local today=$(date +%Y-%m-%d)
  local radiation=$(awk -v min=1200 -v max=1600 'BEGIN{srand(); print min+rand()*(max-min)}')
  local battery_health=$(shuf -i 10-100 -n 1)
  local battery_level=$(shuf -i 10-100 -n 1)
  local alert_limit=$(shuf -i 0-100 -n 1)
  local accuracy_level=$(shuf -i 1-10 -n 1)
  local error_margin=$(awk -v min=0.000 -v max=1.000 'BEGIN{srand(); print min+rand()*(max-min)}')
  local confidence_interval=$(shuf -i 1-10 -n 1)

  local semi_major_axis=$(awk -v min=2000 -v max=40000 'BEGIN{srand(); print min+rand()*(max-min)}')
  local eccentricity=$(awk -v min=0.0 -v max=0.2 'BEGIN{srand(); print min+rand()*(max-min)}')
  local inclination=$(awk 'BEGIN{srand(); print rand()*180}')
  local raan=$(awk 'BEGIN{srand(); print rand()*360}')
  local argument_of_perigee=$(awk 'BEGIN{srand(); print rand()*360}')
  local orbital_period=$(awk -v min=9000 -v max=20000 'BEGIN{srand(); print min+rand()*(max-min)}')
  
  local time_of_applicability=$(date +%Y-%m-%dT%H:%M:%S)
  local bash_random=$RANDOM
  local positionX=$(awk -v min=-40000.0 -v max=40000.0 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local positionY=$(awk -v min=-40000.0 -v max=40000.0 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local positionZ=$(awk -v min=-40000.0 -v max=40000.0 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local velocityX=$(awk -v min=-10000.0 -v max=10000.0 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local velocityY=$(awk -v min=-10000.0 -v max=10000.0 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local velocityZ=$(awk -v min=-10000.0 -v max=10000.0 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')

  local update_frequency=$(shuf -i 1-365 -n 1)
  local week_number=$(shuf -i 1-52 -n 1)
  local random_days=$((RANDOM % 366))
  local effective_date=$(date -d "+$random_days days" '+%Y-%m-%d')
  local random_days_end=$(($random_days+7))
  local expiry_date=$(date -d "+$random_days_end days" '+%Y-%m-%d')
  
  local update_interval=$RANDOM
  local issue_of_data=$(shuf -i 1-1000 -n 1)
  local crc=$(shuf -i 0-16777215 -n 1) #24b -> 2^(24)-1=16777215

  local accuracy_of_timing=$(awk -v min=0 -v max=60 'BEGIN{srand(); print min+rand()*(max-min)}')
  local random_hour=$((RANDOM % 24))
  local random_minute=$((RANDOM % 60))
  local random_second=$((RANDOM % 60))
  local gst_time=$(printf "%02d:%02d:%02d" $random_hour $random_minute $random_second)
  local bash_random=$RANDOM
  local gps_conversion=$(awk -v min=0.000 -v max=1.000 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local gst_conversion=$(awk -v min=0.000000 -v max=0.000999 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local broadcast_group_delay=$(awk -v min=0.000000000000 -v max=0.000000999999 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local ionospheric_correction=$(awk -v min=0.000000000000 -v max=0.000000009999 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')
  local bash_random=$RANDOM
  local clock_correction=$(awk -v min=0.00000000000 -v max=0.00000009999 -v seed="$bash_random" 'BEGIN{ srand(seed); print min + rand() * (max - min);}')

  # Personalizar la actualización según el twin_id // Customise the update according to the twin_id
  case $twin_id in
    "sat")
      json_patch="[{\"op\":\"replace\", \"path\":\"/Date\", \"value\":\"$today\"}, {\"op\":\"replace\", \"path\":\"/MessageType\", \"value\":\"INAV\"}, {\"op\":\"replace\", \"path\":\"/Service\", \"value\":\"CS\"}, {\"op\":\"replace\", \"path\":\"/Component\", \"value\":\"E1-B\"}]"
      ;;
    "integrity")
      json_patch="[{\"op\":\"replace\", \"path\":\"/IntegrityLevel\", \"value\":\"Good\"}, {\"op\":\"replace\", \"path\":\"/AlertLimit\", \"value\":$alert_limit}]"
      ;;
    "sisa")
      json_patch="[{\"op\":\"replace\", \"path\":\"/AccuracyLevel\", \"value\":$accuracy_level}, {\"op\":\"replace\", \"path\":\"/ErrorMargin\", \"value\":$error_margin}, {\"op\":\"replace\", \"path\":\"/ConfidenceInterval\", \"value\":$confidence_interval}, {\"op\":\"replace\", \"path\":\"/SystemIdentifier\", \"value\":\"System20240513\"}]"
      ;;
    "spa")
      json_patch="[{\"op\":\"replace\", \"path\":\"/Radiation\", \"value\":$radiation}, {\"op\":\"replace\", \"path\":\"/BatteryHealth\", \"value\":$battery_health}, {\"op\":\"replace\", \"path\":\"/BatteryLevel\", \"value\":$battery_level}]"
      ;;
    "op")
      json_patch="[{\"op\":\"replace\", \"path\":\"/SemiMajorAxis\", \"value\":$semi_major_axis}, {\"op\":\"replace\", \"path\":\"/Eccentricity\", \"value\":$eccentricity}, {\"op\":\"replace\", \"path\":\"/Inclination\", \"value\":$inclination}, {\"op\":\"replace\", \"path\":\"/RightAscensionOfAscendingNode\", \"value\":$raan}, {\"op\":\"replace\", \"path\":\"/ArgumentOfPerigee\", \"value\":$argument_of_perigee}, {\"op\":\"replace\", \"path\":\"/OrbitalPeriod\", \"value\":$orbital_period}]"
      ;;
    "ephemeris")
      json_patch="[{\"op\":\"replace\", \"path\":\"/TimeOfApplicability\", \"value\":\"$time_of_applicability\"}, {\"op\":\"replace\", \"path\":\"/PositionX\", \"value\":$positionX}, {\"op\":\"replace\", \"path\":\"/PositionY\", \"value\":$positionY}, {\"op\":\"replace\", \"path\":\"/PositionZ\", \"value\":$positionZ}, {\"op\":\"replace\", \"path\":\"/VelocityX\", \"value\":$velocityX}, {\"op\":\"replace\", \"path\":\"/VelocityY\", \"value\":$velocityY}, {\"op\":\"replace\", \"path\":\"/VelocityZ\", \"value\":$velocityZ}]"
      ;;
    "almanac")
      json_patch="[{\"op\":\"replace\", \"path\":\"/UpdateFrequency\", \"value\":$update_frequency}]"
      ;;
    "sa")
      json_patch="[{\"op\":\"replace\", \"path\":\"/WeekNumber\", \"value\":$week_number}]"
      ;;
    "ar")
      json_patch="[{\"op\":\"replace\", \"path\":\"/ReferenceType\", \"value\":\"Red\"}, {\"op\":\"replace\", \"path\":\"/ReferenceDetail\", \"value\":\"Days\"}, {\"op\":\"replace\", \"path\":\"/EffectiveDate\", \"value\":\"$effective_date\"}, {\"op\":\"replace\", \"path\":\"/ExpiryDate\", \"value\":\"$expiry_date\"}]"
      ;;
    "sp")
      json_patch="[{\"op\":\"replace\", \"path\":\"/UpdateInterval\", \"value\":$update_interval}, {\"op\":\"replace\", \"path\":\"/ParameterReliability\", \"value\":\"Accurate\"}]"
      ;;
    "sid")
      json_patch="[{\"op\":\"replace\", \"path\":\"/SatelliteId\", \"value\":\"SATGalileo016\"}]"
      ;;
    "iod")
      json_patch="[{\"op\":\"replace\", \"path\":\"/IssueOfData\", \"value\":$issue_of_data}]"
      ;;
    "ndvashs")
      json_patch="[{\"op\":\"replace\", \"path\":\"/NavDataValidity\", \"value\":true}, {\"op\":\"replace\", \"path\":\"/SignalHealthStatus\", \"value\":\"Good\"}]"
      ;;
    "crc")
      json_patch="[{\"op\":\"replace\", \"path\":\"/Crc\", \"value\":$crc}]"
      ;;
    "taccp")
      json_patch="[{\"op\":\"replace\", \"path\":\"/AccuracyOfTiming\", \"value\":$accuracy_of_timing}, {\"op\":\"replace\", \"path\":\"/TimeSystemUsed\", \"value\":\"+%Y-%m-%d\"}]"
      ;;
    "gst")
      json_patch="[{\"op\":\"replace\", \"path\":\"/GalileoSystemTime\", \"value\":\"$gst_time\"}]"
      ;;
    "gpstgstc")
      json_patch="[{\"op\":\"replace\", \"path\":\"/GpsToGalileoTimeConversion\", \"value\":$gps_conversion}]"
      ;;
    "gstutcc")
      json_patch="[{\"op\":\"replace\", \"path\":\"/GstUtcConversion\", \"value\":$gst_conversion}]"
      ;;
    "bgd")
      json_patch="[{\"op\":\"replace\", \"path\":\"/BroadcastGroupDelay\", \"value\":$broadcast_group_delay}]"
      ;;
    "ic")
      json_patch="[{\"op\":\"replace\", \"path\":\"/IonosphericCorrection\", \"value\":$ionospheric_correction}]"
      ;;
    "cc")
      json_patch="[{\"op\":\"replace\", \"path\":\"/ClockCorrection\", \"value\":$clock_correction}]"
      ;;
  esac

  echo "$json_patch"
}

# Iterar sobre la lista de twin IDs // Iterate on the list of twin IDs
for twin_id in "${twin_ids[@]}"
do
  # Generar el JSON patch adecuado // Generate the appropriate JSON patch
  json_patch=$(generate_json_patch "$twin_id")
  
  echo "Actualizando gemelo ID: $twin_id con JSON patch: $json_patch"
  az dt twin update -n "$hostname" --twin-id "$twin_id" --json-patch "$json_patch"
done
