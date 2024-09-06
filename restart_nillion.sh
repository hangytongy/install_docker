#!/bin/bash

# Define the image names
IMAGE_NAMES=("nillion/retailtoken-accuser:v1.0.0" "nillion/retailtoken-accuser:v1.0.1")

for IMAGE_NAME in "${IMAGE_NAMES[@]}"; do
    # List all container IDs using the specified image
    CONTAINER_IDS=$(docker ps -a --filter ancestor=$IMAGE_NAME -q)

    # Check if there are any containers to remove
    if [ -z "$CONTAINER_IDS" ]; then
        echo "No containers found for image $IMAGE_NAME."
    else
        # Stop and remove all containers using the specified image
        echo "Stopping and removing containers for image $IMAGE_NAME..."
        docker rm -f $CONTAINER_IDS
        echo "Containers for image $IMAGE_NAME removed successfully."
    fi
done

# Uncomment and modify the block below if needed for fetching the latest block height
# latest_block=$(curl -s "https://testnet.nillion.api.explorers.guru/api/v1/blocks?limit=4&cursor=NTE1MjAzOA==&order_by=asc" | jq '.data[0].height')
# echo "Latest block: ${latest_block}"
# sleep 10
