# docker tresorit backup

> A simple docker image containing the Tresorit command line interface. Can be run on servers and NAS devices to back up the contents of your Tresorit account.

## Configure

Run the following command to jump into a running Tresorit container:

```bash
docker run --rm -ti \
    -v $(pwd)/Profiles:/home/tresorit/Profiles \
    kriskbx/tresorit-backup \ 
    bash
```

Log into Tresorit by running the following command inside the container. A `Profiles` folder in the current directory on your host will be created:`

```bash
tresorit-cli login --email demo@example.com --password-on-stdin
```

**If** you want to sync directories **from your current machine to Tresorit**, use the `sync` command to setup sync. If you just want to backup things, you don't need to do that. Check out the [Tresorit Linux CLI documentation](https://support.tresorit.com/hc/en-us/articles/360009330614-Using-Tresorit-CLI-for-Linux) on how to use it:

```bash
tresorit-cli sync --start tresor-name --path /home/tresorit/external/tresor-name
```

## Start Container

Start your Container (with some additional privileges for fuse) and mount the Profile directory that has been created in the Configure step into the container as well as the path where you want to store your backups:

```
docker run \
    -v /path/to/formerly/generated/Profiles:/home/tresorit/Profiles \
    -v /path/to/backup/files:/home/tresorit/external \
    --device /dev/fuse \
    --cap-add SYS_ADMIN \
    kriskbx/tresorit-backup
```

Now you can add custom cronjobs by adding env variables starting with `CRONTAB_` to back up your files from the mounted tresorit drive to your local machine. For exampe:

```
docker run \
    -e "CRONTAB_MUSIC=0 8 * * * rsync -arz --progress /home/tresorit/drive/music/ /home/tresorit/external/music" \
    -e "CRONTAB_PHOTOS=0 7 * * * rsync -arz --progress /home/tresorit/drive/photos/ /home/tresorit/external/photos" \
    # …
```

To skip the mounting of Tresorit drive, use `SYNC_ONLY`:

```
docker run \
    -e "SYNC_ONLY=true" \
    # …
```

## License

MIT
