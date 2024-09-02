#!/bin/bash

# Define the image name
IMAGE_NAME="nillion/retailtoken-accuser:v1.0.0"

# List all container IDs using the specified image
CONTAINER_IDS=$(docker ps -a --filter ancestor=$IMAGE_NAME -q)

# Check if there are any containers to remove
if [ -z "$CONTAINER_IDS" ]; then
    echo "No containers found for image $IMAGE_NAME."
else
    # Stop and remove all containers using the specified image
    echo "Stopping and removing containers for image $IMAGE_NAME..."
    docker rm -f $CONTAINER_IDS
    echo "Containers removed successfully."
fi

#somehow in VPS unable to get the latest height, need to create a var and put it in
#latest_block=$(curl -s "https://testnet.nillion.api.explorers.guru/api/v1/blocks?limit=4&cursor=NTE1MjAzOA==&order_by=asc" | jq '.data[0].height')
#echo "latest block ${latest_block}"
#sleep 10

docker run -d -v /root/nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 accuse --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com" --block-start ${latest_block}
