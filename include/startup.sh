# Fix ownership and permissions
sudo chmod 775 $SHARED_DIR $WORK_DIR $CCACHE_DIR $OUT_DIR $INIT_DIR
sudo chown $USER:$USER $SHARED_DIR $WORK_DIR $CCACHE_DIR $OUT_DIR $INIT_DIR

# add Android SDK platform tools to path
if [ -d "$INIT_DIR/platform-tools" ] ; then
    PATH="$INIT_DIR/platform-tools:$PATH"
fi

# Initialize ccache if needed
if [ ! -f $CCACHE_DIR/ccache.conf ]; then
	echo "Initializing ccache in $CCACHE_DIR..."
	ccache -M 50G
fi

export USE_CCACHE=1
export CCACHE_COMPRESS=1
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

# Show general info
screenfetch
