# Factorio Server on GCP

**Server Address:** `35.193.140.235:34197`  
**Version:** 2.0.72 (base game, no Space Age DLC)

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
gcloud compute ssh factorio-server --zone=us-central1-a --command="sudo docker restart factorio"
```

### Update Factorio Version
To change versions, stop and recreate the container (replace `2.0.72` with desired version):
```bash
gcloud compute ssh factorio-server --zone=us-central1-a --command="sudo docker stop factorio && sudo docker rm factorio && sudo docker run -d \
  --name factorio \
  --restart=unless-stopped \
  -p 34197:34197/udp \
  -p 27015:27015/tcp \
  -v /opt/factorio/data:/factorio \
  -e SAVE_NAME=factorio-save \
  -e GENERATE_NEW_SAVE=true \
  -e LOAD_LATEST_SAVE=true \
  -e DLC_SPACE_AGE=false \
  factoriotools/factorio:2.0.72"
```

## Notes

- The external IP may change when you stop/start the VM. Check the new IP with the command above.
- Server config is at `/opt/factorio/data/config/server-settings.json` on the VM.
- Saves are at `/opt/factorio/data/saves/` on the VM.
- Cost is approximately $13/month if running 24/7. Stop when not playing to save money.
- `DLC_SPACE_AGE=false` disables Space Age DLC mods (elevated-rails, quality, space-age).
