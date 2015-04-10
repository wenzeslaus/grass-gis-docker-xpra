# this file is based on wiki page:
#     http://grasswiki.osgeo.org/wiki/Compile_and_Install_Ubuntu

# this is a single command watch the backslashes
sudo apt-get install -y \
    build-essential \
    flex make bison gcc libgcc1 g++ cmake ccache \
    python python-dev \
    python-opengl \
    python-wxversion python-wxtools python-wxgtk2.8 \
    python-dateutil libgsl0-dev python-numpy \
    wx2.8-headers wx-common libwxgtk2.8-dev libwxgtk2.8-dbg \
    libwxbase2.8-dev  libwxbase2.8-dbg \
    libncurses5-dev \
    zlib1g-dev gettext \
    libtiff-dev libpnglite-dev \
    libcairo2 libcairo2-dev \
    sqlite3 libsqlite3-dev \
    libpq-dev \
    libreadline6 libreadline6-dev libfreetype6-dev \
    libfftw3-3 libfftw3-dev \
    libboost-thread-dev libboost-program-options-dev liblas-c-dev \
    resolvconf \
    libjasper-dev \
    subversion \
    libav-tools libavutil-dev ffmpeg2theora \
    libffmpegthumbnailer-dev \
    libavcodec-dev \
    libxmu-dev \
    libavformat-dev libswscale-dev \
    checkinstall \
    libglu1-mesa-dev libxmu-dev \
    ghostscript

sudo apt-get install -y netcdf-bin libnetcdf-dev
sudo apt-get install -y libproj-dev libgeos-dev libgdal-dev python-gdal
