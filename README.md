# Factorio Server on GCP

**Server Address:** `34.58.250.90:34197`

## Quick Commands

### Start the Server
```bash
gcloud compute instances start factorio-server --zone=us-central1-a
```

### Stop the Server (saves money when not playing)
```bash
gcloud compute instances stop factorio-server --zone=us-central1-a
```

### Check Server Status
```bash
gcloud compute instances describe factorio-server --zone=us-central1-a --format="value(status)"
```

### Get Current External IP (changes after stop/start)
```bash
gcloud compute instances describe factorio-server --zone=us-central1-a --format="value(networkInterfaces[0].accessConfigs[0].natIP)"
```

## Server Management (via SSH)

### SSH into the Server
```bash
gcloud compute ssh factorio-server --zone=us-central1-a
```

### View Logs
```bash
gcloud compute ssh factorio-server --zone=us-central1-a --command="sudo docker logs -f factorio"
```

### Restart Factorio Container
```bash
gcloud compute ssh factorio-server --zone=us-central1-a --command="cd /opt/factorio && sudo docker-compose restart"
```

### Update Factorio to Latest Version
```bash
gcloud compute ssh factorio-server --zone=us-central1-a --command="cd /opt/factorio && sudo docker-compose pull && sudo docker-compose up -d"
```

## Notes

- The external IP may change when you stop/start the VM. Check the new IP with the command above.
- Server config is at `/opt/factorio/data/config/server-settings.json` on the VM.
- Saves are at `/opt/factorio/data/saves/` on the VM.
- Cost is approximately $13/month if running 24/7. Stop when not playing to save money.

