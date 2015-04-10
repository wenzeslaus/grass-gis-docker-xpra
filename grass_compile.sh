SRCDIR=grass70_release

svn checkout https://svn.osgeo.org/grass/grass/branches/releasebranch_7_0 $SRCDIR

cd $SRCDIR

# uncomment following lines if you want to compile in debug mode
# (when debugging using gdb debugger) and to get compiler warnings
# (which is advantageous if you are compiling your code)
# export CFLAGS="-ggdb -Wall -Werror-implicit-function-declaration -Wmissing-prototypes -Wmissing-declarations -Wredundant-decls"
# export CXXFLAGS="-ggdb -Wall"

./configure \
    --enable-largefile=yes \
    --with-nls \
    --with-cxx \
    --with-readline \
    --with-pthread \
    --with-proj-share=/usr/share/proj \
    --with-geos=/usr/bin/geos-config \
    --with-wxwidgets \
    --with-cairo \
    --with-opengl-libs=/usr/include/GL \
    --with-freetype=yes --with-freetype-includes="/usr/include/freetype2/" \
    --with-postgresql=yes --with-postgres-includes="/usr/include/postgresql" \
    --with-sqlite=yes \
    --with-mysql=yes --with-mysql-includes="/usr/include/mysql" \
    --with-odbc=no \
    --with-liblas=yes --with-liblas-config=/usr/bin/liblas-config

make -j$(nproc)  &&  sudo make install  &&  sudo ldconfig
