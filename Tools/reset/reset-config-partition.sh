#!/usr/bin/env bash

# USAGE:
# reset-config-partition.sh method IP user password [operation]
#     method:            which method to try: ssh or curl
#     IP:                IP address of the stick
#     user:              admin username
#     password:          user's password
#     operation:         Needed only when "ssh" method is being used. Valid options are "wipe" or "reboot".
#                        Default is "wipe".
CONFIG_PARTITION=/dev/mtd3
if [[ -n $3 ]]; then
  USER=$3
else
  echo "No username is specified"
  exit 1
fi

if [[ -n $4 ]]; then
  PASSWORD=$4
else
  echo "No password is specified"
  exit 1
fi

if [[ -n $2 ]]; then
  IP=$2
else
  echo "No IP is specified"
  exit 1
fi

if [[ "$1" == "ssh" ]] || [[ "$1" == "curl" ]]; then
  METHOD=$1
  if [ "${METHOD}" == "ssh" ]; then
    # Which operation we would like to perform?
    if [[ -n "$5" ]]; then
      if [[ "$5" == "wipe" || "$5" == "reboot" ]]; then
        OPERATION=$5
      else
        echo "Invalid operation. Supported operations are: wipe, reboot. You put: \"${OPERATION}\""
        exit 1
      fi
    else
      # If nothing is specified - just wipe
      echo "No operation is specified for SSH. Considering it's \"wipe\""
      OPERATION="wipe"
    fi
  fi
else
  echo "No method is specified or it's not valid. Supported methods are: curl, ssh. You put: \"${1}\""
  exit 1
fi

echo "Using IP: ${IP}"
echo "Using user: ${USER}"
echo "Using password: ${PASSWORD}"
echo "Using method: ${METHOD}"
if [ "${METHOD}" == "ssh" ]; then
  echo "Operation is: ${OPERATION}"
fi

while true ; do
  case ${METHOD} in
    ssh)
      # Connect by SSH and try to wipe the partition
      echo "Trying SSH conenction to ${IP}. Doing ${OPERATION}"
      case ${OPERATION} in
        wipe)
          COMMAND="flash_eraseall ${CONFIG_PARTITION}"
          ;;
        reboot)
          COMMAND="reboot"
          ;;
        *)
          echo "Invalid operation. Supported operations are: wipe, reboot. You put: \"${OPERATION}\""
          exit 1
          ;;
      esac
      sshpass -p ${PASSWORD} \
          ssh \
            -oStrictHostKeyChecking=no \
            -oUserKnownHostsFile=/dev/null \
            -oKexAlgorithms=+diffie-hellman-group1-sha1 \
            -oHostKeyAlgorithms=+ssh-rsa \
            -oCiphers=+3des-cbc \
            -oConnectTimeout=1 \
            -oConnectionAttempts=1 \
            ${USER}@${IP} -- \
              ${COMMAND}
      STATUS=$?
      ;;
    curl)
      # Log In
      curl -v -X POST http://${IP}/boaform/admin/formLogin \
        --data-raw "challenge=&username=${USER}&password=${PASSWORD}&save=Login&submit-url=%2Fadmin%2Flogin.asp"
      LOGIN_STATUS=$?
      echo "Login status: ${LOGIN_STATUS}"
      if [[ ${LOGIN_STATUS} -eq 0 ]]; then
        # Reset
        echo "Loggen In successfully. Trying to reset the device"
        curl -v --http0.9 -X POST http://${IP}/boaform/formSaveConfig --data-raw "reset=Reset&submit-url=%2Fsaveconf.asp"
        STATUS=$?
      fi
      ;;
    *)
      echo "Unknown method"
      exit 1
      ;;
    esac

    if [[ ${STATUS} -eq 0 ]]; then
      echo "Wipe of ${CONFIG_PARTITION} is done."
      break
    else
      echo "Exit status of previous operation is ${STATUS}. Retrying..."
      echo
      sleep 1
    fi
done
