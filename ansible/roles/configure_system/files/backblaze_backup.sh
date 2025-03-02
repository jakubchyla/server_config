#! /usr/bin/env sh

BACKUP_DIR="/data/chroot_sshfs/nas"
BACKUP_BUCKET=":b2:backup-hades-storage"
BACKUP_BUCKET_OLD=":b2:backup-hades-storage-old"
RCLONE_B2_ACCOUNT="$(systemd-creds cat b2_application_key_id)"
RCLONE_B2_KEY="$(systemd-creds cat b2_application_key)"

# check if $BACKUP_DIR exists
if ! [ -d "$BACKUP_DIR" ]; then
    printf "%s\n" \
           "$BACKUP_DIR does not exist" \
           "exiting..."
    exit 1
fi

# check if $BACKUP_DIR is empty
if [ -z "$(ls -A "$BACKUP_DIR")" ]; then
    printf "%s\n" \
           "$BACKUP_DIR is empty" \
           "exiting..."
    exit 1
fi

# check if $BACKUP_DIR is a mountpoint
if ! mountpoint "$BACKUP_DIR" > /dev/null; then
    printf "%s\n" \
           "$BACKUP_DIR is not a mountpoint" \
           "exiting..."
    exit 1
fi


export RCLONE_B2_ACCOUNT
export RCLONE_B2_KEY
rclone sync "$BACKUP_DIR" $BACKUP_BUCKET \
            --backup-dir "$BACKUP_BUCKET_OLD/$(date --iso-8601)" \
            --fast-list \
            --transfers 16 \
            --exclude ".123/**" \
            -v
unset -v RCLONE_B2_ACCOUNT
unset -v RCLONE_B2_KEY
printf "%s\n" "finished backup"
