#!/bin/bash
# Create the exec file (bash and bat) to select the correct VM and run Pharo image

# CREATE THE VM LAUNCHER SCRIPTS ================================================
create_vm_script() {
    VM_SCRIPT=$1
    
    echo "#!/bin/bash" > tmp/$VM_SCRIPT
    echo '# Run the VM according the system architecture
# Step 1 - Get the OS and architecture
# 1.1 Getting the OS

TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
TMP_ARCH=`uname -m`
if [[ "{$TMP_OS}" = *darwin* ]]; then
    OS="mac";
elif [[ "{$TMP_OS}" = *linux* ]]; then
    OS="linux";
elif [[ "{$TMP_OS}" = *win* ]]; then
    OS="win";
elif [[ "{$TMP_OS}" = *mingw* ]]; then
    OS="win";
elif [[ "{$TMP_OS}" = *msys* ]]; then
    OS="win";
else
    echo "OS not identified. Try to run the correct VM on vm folder";
    exit 1;
fi
# 1.2 Getting the architecture
if [[ "{$TMP_ARCH}" = *arm* ]]; then
    ARCH="arm";
elif [[ "{$TMP_ARCH}" = *64* ]]; then
    ARCH="64";
else
    ARCH="32";
fi
# 1.3 Setting the correcty VM folder
if [[ "{$ARCH}" = *arm* ]]; then
    VM="arm";
elif [[ "{$OS}" = *windows* ]]; then
    VM="win32";
elif [[ "{$OS}" = *mac* ]]; then
    VM="osx32";
elif [[ "{$OS}" = *linux* ]] && [[ "{$ARCH}" = *64* ]]; then
    VM="linux64";
elif [[ "{$OS}" = *linux* ]] && [[ "{$ARCH}" = *32* ]]; then
    VM="linux32";
else
    echo "VM not identified. Try to run the correct VM on vm folder";
    exit 1;
fi

# Step 2 - Running the correcty VM and Pharo image ' >> tmp/$VM_SCRIPT

# create the correct start options to pharo, pharo-ui and pharo-server files
if [[ "{$VM_SCRIPT}" = *ui* ]]; then
     echo 'if [[ "{$VM}" = *arm* ]]; then
vm/$VM/pharo PharoThings32.image ;
elif [[ "{$VM}" = *osx32* ]]; then
    # some magic to find out the real location of this script dealing with symlinks
    DIR=`readlink "$0"` || DIR="$0";
    DIR=`dirname "$DIR"`;
    cd "$DIR"
    DIR=`pwd`
    cd - > /dev/null 
    # disable parameter expansion to forward all arguments unprocessed to the VM
    set -f
    # run the VM and pass along all arguments as is
    "$DIR"/"vm/$VM/Pharo.app/Contents/MacOS/Pharo" "$DIR"/PharoThings32.image &
elif [[ "{$VM}" = *linux64* ]]; then
    vm/$VM/pharo PharoThings64.image ;
elif [[ "{$VM}" = *linux32* ]]; then
    vm/$VM/pharo PharoThings32.image ;
fi' >> tmp/$VM_SCRIPT
elif [[ "{$VM_SCRIPT}" = *server* ]]; then
    echo 'if [[ "{$VM}" = *arm* ]]; then
vm/$VM/pharo --headless PharoThings32.image remotePharo --startServerOnPort=40423
elif [[ "{$VM}" = *osx32* ]]; then
    # some magic to find out the real location of this script dealing with symlinks
    DIR=`readlink "$0"` || DIR="$0";
    DIR=`dirname "$DIR"`;
    cd "$DIR"
    DIR=`pwd`
    cd - > /dev/null 
    # disable parameter expansion to forward all arguments unprocessed to the VM
    set -f
    # run the VM and pass along all arguments as is
    "$DIR"/"vm/$VM/Pharo.app/Contents/MacOS/Pharo" --headless "$DIR"/PharoThings32.image remotePharo --startServerOnPort=40423
elif [[ "{$VM}" = *linux64* ]]; then
    vm/$VM/pharo --headless PharoThings64.image remotePharo --startServerOnPort=40423
elif [[ "{$VM}" = *linux32* ]]; then
    vm/$VM/pharo --headless PharoThings32.image remotePharo --startServerOnPort=40423
fi' >> tmp/$VM_SCRIPT
else
   echo 'if [[ "{$VM}" = *arm* ]]; then
vm/$VM/pharo --headless PharoThings32.image $1 $2 $3
elif [[ "{$VM}" = *osx32* ]]; then
    # some magic to find out the real location of this script dealing with symlinks
    DIR=`readlink "$0"` || DIR="$0";
    DIR=`dirname "$DIR"`;
    cd "$DIR"
    DIR=`pwd`
    cd - > /dev/null 
    # disable parameter expansion to forward all arguments unprocessed to the VM
    set -f
    # run the VM and pass along all arguments as is
    "$DIR"/"vm/$VM/Pharo.app/Contents/MacOS/Pharo" --headless "$DIR"/PharoThings32.image $1 $2 $3
elif [[ "{$VM}" = *linux64* ]]; then
    vm/$VM/pharo --headless PharoThings64.image $1 $2 $3
elif [[ "{$VM}" = *linux32* ]]; then
    vm/$VM/pharo --headless PharoThings32.image $1 $2 $3
fi' >> tmp/$VM_SCRIPT
fi
# make the script executable
chmod +x tmp/$VM_SCRIPT
}

echo "Creating starter scripts pharo, pharo-ui and pharo-server"
create_vm_script "pharo"
create_vm_script "pharo-ui"
create_vm_script "pharo-server"

# echo '#!/bin/bash
# vm/arm/pharo --headless PharoThings32.image remotePharo startServerOnPort=40423' > tmp/pharo-server
# chmod +x tmp/pharo-server

echo '@echo off
start /min vm\win32\Pharo.exe PharoThings32.image' > tmp/pharo.bat