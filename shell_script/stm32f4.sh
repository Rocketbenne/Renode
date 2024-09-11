#!bin/bash

NAME="renode2"

# get path to this directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Script directory: $SCRIPT_DIR"

# Give execution rigths to this file
chmod 755 $SCRIPT_DIR/../shell_script/stm32f4.sh

# Start Docker Image
docker run -it --rm --network=host --name $NAME -v $SCRIPT_DIR/..:/stm32f4 antmicro/renode bash -c "renode --console -e 'include @/stm32f4/resc/stm32f4.resc'"
