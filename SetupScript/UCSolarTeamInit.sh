#!/usr/bin/env bash
sudo mkdir -p /tmp/solarcar
sudo chmod +x qt-installer-noninteractive.qs
sudo chmod +x init.vim

sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo apt-get -qq update
sudo apt-get -q --yes  install cmake software-properties-common build-essential mesa-common-dev libgl1-mesa-dev git-all gitk sublime-text-installer neovim putty
sudo cp init.vim ~/.config/nvim/

sudo apt-get -q -o Dpkg::Options::="--force-condef" -o Dpkg::Options::="--force-confold" --yes --force-yes upgrade

echo "Installing Git Repositores in ~/Documents/SolarCar"
mkdir -p ~/Documents/SolarCar
(cd ~/Documents/SolarCar/
mkdir DeltaTelemetryServer
mkdir BackupCamera
mkdir DeltaHermes
mkdir EpsilonHermes
mkdir AndroidClientTelemetry
mkdir DeltaDesktopClientTelemetry

git clone https://github.com/UCSolarCarTeam/Epsilon-Domovoi.git
git clone https://github.com/UCSolarCarTeam/Development-Guide.git
git clone https://github.com/UCSolarCarTeam/Delta-Telemetry-Server.git DeltaTelemetryServer/Delta-Telemetry-Server
git clone https://github.com/UCSolarCarTeam/Delta-Telemetry-Test-Tool.git
git clone https://github.com/UCSolarCarTeam/Epsilon-Embedded-Test-Tool.git
git clone https://github.com/UCSolarCarTeam/BackupCamera.git BackupCamera/Backup-Camera
git clone https://github.com/UCSolarCarTeam/Epsilon-Onboard-Media-Control.git
git clone https://github.com/UCSolarCarTeam/Delta-OnBoard-Media-Control.git

git clone https://github.com/UCSolarCarTeam/Delta-Hermes.git DeltaHermes/Delta-Hermes
git clone https://github.com/UCSolarCarTeam/Epsilon-Hermes.git EpsilonHermes/Epsilon-Hermes
git clone https://github.com/UCSolarCarTeam/Android-Client-Telemetry.git AndroidClientTelemetry/Android-Client-Telemetry
git clone https://github.com/UCSolarCarTeam/Delta-Desktop-Client-Telemetry.git DeltaDesktopClientTelemetry/Delta-Desktop-Client-Telemetry
git clone https://github.com/UCSolarCarTeam/Recruit-Training.git)

(cd ~/Documents/SolarCar/DeltaOnboardMediaControl/Delta-Onboard-Media-Control/
git clone https://github.com/google/googletest.git
cd googletest
g++ -isystem googletest/include/ -Igoogletest -isystem googlemock/include/ -Igooglemock -pthread -c googlemock/src/gmock-all.cc
g++ -isystem googletest/include/ -Igoogletest -isystem googlemock/include/ -Igooglemock -pthread -c googletest/src/gtest-all.cc
ar -rv libgmock.a gtest-all.o gmock-all.o
cp libgmock.a ../test/
sudo cmake -DBUILD_SHARED_LIBS=ON
sudo make
sudo cp -a include/gtest/ /usr/include/
sudo cp -a libgtest_main.so libgtest.so /usr/lib/)

(cd /tmp/solarcar/
echo "Installing ANT, SDK, NDK and JDK in /opt/"
sudo wget -q http://mirror.its.dal.ca/apache//ant/binaries/apache-ant-1.9.7-bin.tar.gz
sudo tar -xzf apache-ant-1.9.7-bin.tar.gz
sudo mv apache-ant-1.9.7/ /opt/

sudo wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
sudo tar -xzf android-sdk_r24.4.1-linux.tgz
sudo mv android-sdk-linux/ /opt/

sudo wget -q http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
sudo unzip -qq android-ndk-r12b-linux-x86_64.zip 
sudo mv android-ndk-r12b/ /opt/

sudo wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz
sudo tar -xzvf jdk-8u101-linux-x64.tar.gz
sudo mv jdk1.8.0_101/ /opt/

echo "Downloading QT Installer"
sudo wget -q http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
sudo chmod +x qt-unified-linux-x64-online.run)

echo "Installing QT into Home/Qt/"
/tmp/solarcar/qt-unified-linux-x64-online.run --script qt-installer-noninteractive.qs 

(cd /tmp/solarcar/
echo "Installing QWT Plot in /usr/local"
sudo wget -q http://heanet.dl.sourceforge.net/project/qwt/qwt/6.1.3/qwt-6.1.3.tar.bz2
sudo tar -xvf  qwt-6.1.3.tar.bz2
sudo mv qwt-6.1.3/ /usr/local/
cd /usr/local/qwt-6.1.3/
$HOME/Qt/5.5/gcc_64/bin/qmake qwt.pro
sudo make
sudo make install)

(cd /tmp/solarcar/
echo "Installing golang in /usr/local"
sudo wget -q https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
sudo tar -xf go1.7.linux-amd64.tar.gz
sudo mv go/ /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile )

(cd /usr/local
echo "Installing arm compiler in /usr/local"
git clone https://github.com/adamgreen/gcc4mbed.git
cd /usr/local/gcc4mbed/
sudo sed -i '108d;109d;110d;134d' linux_install # Remove 'press any key to continue' and building samples
sudo ./linux_install)

sudo rm -r /tmp/solarcar/