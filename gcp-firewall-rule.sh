#!/bin/bash
# =============================================================================
# Create GCP Firewall Rule for Factorio Server
# Run this from your local machine with gcloud CLI installed and configured
# =============================================================================

# Firewall rule name
RULE_NAME="allow-factorio-server"

# Your GCP project ID (uncomment and set if not using default)
# PROJECT_ID="your-project-id"

echo "Creating firewall rule for Factorio server (UDP 34197)..."

gcloud compute firewall-rules create $RULE_NAME \
    --direction=INGRESS \
    --priority=1000 \
    --network=default \
    --action=ALLOW \
    --rules=udp:34197 \
    --source-ranges=0.0.0.0/0 \
    --description="Allow Factorio game server traffic"

# Optional: Add RCON port if you need remote administration
# gcloud compute firewall-rules create allow-factorio-rcon \
#     --direction=INGRESS \
#     --priority=1000 \
#     --network=default \
#     --action=ALLOW \
#     --rules=tcp:27015 \
#     --source-ranges=YOUR_IP/32 \
#     --description="Allow Factorio RCON (restrict to your IP)"

echo "Firewall rule created successfully!"
echo ""
echo "To verify, run: gcloud compute firewall-rules list --filter=\"name=$RULE_NAME\""

