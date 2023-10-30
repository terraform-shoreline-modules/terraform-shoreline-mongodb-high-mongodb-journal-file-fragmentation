
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High MongoDB Journal File Fragmentation
---

MongoDB is a popular NoSQL database used extensively for its flexibility, scalability, and high performance. In MongoDB, journal files are used for write-ahead logging and recovery in case of unexpected shutdowns. However, when these journal files become highly fragmented, it can cause performance degradation and even lead to data loss. This incident type refers to the problem of high journal file fragmentation in MongoDB that requires immediate attention from software engineers to prevent any further damage.

### Parameters
```shell
export MONGO_LOG_FILE="PLACEHOLDER"

export MONGODB_JOURNAL_DEVICE="PLACEHOLDER"

export MONGODB_JOURNAL_DIR="PLACEHOLDER"

export JOURNAL_COMMIT_INTERVAL_MS_500="PLACEHOLDER"
```

## Debug

### Check MongoDB log for any errors or warnings related to journal file fragmentation
```shell
grep "journal file" ${MONGO_LOG_FILE}
```

### Get fragmentation percentage of MongoDB journal files
```shell
sudo debugfs -R "stat ${MONGODB_JOURNAL_DEVICE}" | grep "Fragmentation percentage"
```

### Check available free space on MongoDB journal device
```shell
df -h ${MONGODB_JOURNAL_DEVICE}
```

### Check MongoDB's journal commit interval
```shell
mongo --eval "db.adminCommand({getParameter:1, journalCommitInterval:1})"
```

### Check MongoDB's current journal write concern
```shell
mongo --eval "db.adminCommand({getLastErrorDefaults:1}).getLastErrorDefaults.j"
```

### Check MongoDB journal file size
```shell
sudo ls -l ${MONGODB_JOURNAL_DIR} | grep "mongo"
```

### Check MongoDB journaling options
```shell
mongo --eval "db.serverCmdLineOpts().parsed.storage.journal"
```

### Check current MongoDB journal usage
```shell
mongo --eval "db.adminCommand({getCmdLineOpts:1}).parsed.journal"
```

### Check MongoDB's current journal commit wait time
```shell
mongo --eval "db.adminCommand({getParameter:1, journalCommitIntervalMs:1})"
```

## Repair

### Increase the journal commit interval to reduce the frequency of disk writes.
```shell


#!/bin/bash



# Set the MongoDB journal commit interval in milliseconds

${JOURNAL_COMMIT_INTERVAL_MS_500}



# Stop the MongoDB service

sudo systemctl stop mongod



# Edit the MongoDB configuration file to increase the journal commit interval

sudo sed -i "s/journalCommitIntervalMs:.*/journalCommitIntervalMs: $journal_commit_interval_ms/" /etc/mongod.conf



# Restart the MongoDB service

sudo systemctl start mongod


```