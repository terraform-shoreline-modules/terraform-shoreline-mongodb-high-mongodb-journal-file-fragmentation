

#!/bin/bash



# Set the MongoDB journal commit interval in milliseconds

${JOURNAL_COMMIT_INTERVAL_MS_500}



# Stop the MongoDB service

sudo systemctl stop mongod



# Edit the MongoDB configuration file to increase the journal commit interval

sudo sed -i "s/journalCommitIntervalMs:.*/journalCommitIntervalMs: $journal_commit_interval_ms/" /etc/mongod.conf



# Restart the MongoDB service

sudo systemctl start mongod