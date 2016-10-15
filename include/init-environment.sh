# Fix ownership and permissions
sudo chmod 775 $SHARED_DIR $WORK_DIR $CCACHE_DIR $OUT_DIR
sudo chown $USER:$USER $SHARED_DIR $WORK_DIR $CCACHE_DIR $OUT_DIR

export USE_CCACHE=1

# Initialize ccache if needed
if [ ! -f $CCACHE_DIR/ccache.conf ]; then
	echo "Initializing ccache in $CCACHE_DIR..."
	ccache -M 50G
fi

# Show general info
screenfetch
