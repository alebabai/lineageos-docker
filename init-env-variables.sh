export USE_CCACHE=1
export CCACHE_DIR=$HOME/android/.ccache

# Initialize ccache if needed
if [ ! -f $CCACHE_DIR/ccache.conf ]; then
	echo "Initializing ccache in $CCACHE_DIR..."
	ccache -M 50G
fi
