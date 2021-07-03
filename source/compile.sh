# Clone repository and compile MSI Afterburner Exporter
cd ${DATA_DIR}
git clone https://github.com/kennedyoliveira/prometheus-msi-afterburner-exporter
cd ${DATA_DIR}/prometheus-msi-afterburner-exporter
git checkout v$LAT_V
go mod download github.com/prometheus/client_golang
go get github.com/prometheus/client_golang/prometheus@v1.5.1
make build -j${CPU_COUNT}

# Create directories and copy files to destination
mkdir -p ${DATA_DIR}/v${LAT_V} ${DATA_DIR}/${LAT_V}/usr/bin
cp ${DATA_DIR}/prometheus-msi-afterburner-exporter/bin/afterburner-exporter ${DATA_DIR}/$LAT_V/usr/bin/prometheus_afterburner_exporter

# Download plugin page and executables and move it to destination
wget -q -O ${DATA_DIR}/sourcepkg.txz https://github.com/ich777/unraid-prometheus_msi_afterburner_exporter/raw/master/source/sourcepackage.txz
tar -C ${DATA_DIR}/${LAT_V} -xvf ${DATA_DIR}/sourcepkg.txz
cd ${DATA_DIR}/${LAT_V}

# Create Slackware package
makepkg -l y -c y ${DATA_DIR}/v$LAT_V/$APP_NAME-"$(date +'%Y.%m.%d')".tgz
cd ${DATA_DIR}/v$LAT_V
md5sum $APP_NAME-"$(date +'%Y.%m.%d')".tgz | awk '{print $1}' > $APP_NAME-"$(date +'%Y.%m.%d')".tgz.md5