# Docker Enviroment for i386 Simulator
<p align="justify">
The aim of this repository is to build a docker environment that will allow students to connect via SSH and use the i386 simulator available at <a href="https://github.com/miguelgonpam/Sim-i386-32bit">Sim-i386-32bit</a>, so they can avoid instalation and the compiling of a cross-compiler that generates those i386 executables.
  
</p>

## Folder structure
Before running the docker, user should take a look to the following files.
<ul>
  <li><b>users.csv</b> should have a list of all the users that will access via SSH. For each user, a linux user and a /home/user folder is created, so everyone has his own directory. User's password is the same as the username.</li>
  This file has a default list of users that looks like this:
</ul>  

  ```
  user1
  user2
  ...
  user12
  ```
<ul>
  <li><b>script.sh</b> is the script that is copied inside the docker and installs everything needed to the environment to work</li>
  <li><b>start.sh</b> is the script stops and removes all existing dockers. Then builds and runs the docker containing the simulator environments</li>
  <li><b>docker-compose.yaml</b> is the configuration file of the docker. By default it exposes the <b>port 22</b>, so users can access the host machine via SSH. If that port is in use in the host machine, users must connect using the dockers IP, which is printed at the end of <b>start.sh</b></li>
  <li><b>i386-linux-musl-cross</b> is a folder that contains the static binutils, static gcc and the i386 toolchain in general. This toolchain is not in this repository, but it can either be compiled (not recommended because it takes several time) or downloaded on the latest release of <a href="https://github.com/miguelgonpam/i386-static-toolchain">this repository</a>. It also contains all the info to compile the toolchain. <br><b>Without this toolchain</b>, no ELF-32 executables can be compiled, so the only way to use the simulator is writing i386-bytecode by hand in raw files, using hexedit or something similar.</li>
</ul>

If the toolchain is not downloaded, the following command should be run so the docker build doesn't fail.
```
touch ./i386-linux-musl-cross/bin/i386-linux-musl-gcc ./i386-linux-musl-cross/bin/i386-linux-musl-objdump ./i386-linux-musl-cross/bin/i386-linux-musl-readelf
```


Once the toolchain is downloaded and copied into the right folder, the folder structure should look something like this.

```
.
├── README.md
├── docker-compose.yaml
├── i386-linux-musl-cross
│   ├── bin
│   ├── i386-linux-musl
│   ├── include
│   ├── lib
│   ├── libexec
│   └── share
├── script.sh
├── start.sh
└── users.csv
```

## Run the Docker
Once the folders are in order and we have the toolchain, we can run the docker by executing:
```
sudo chmod +x ./start.sh
sudo ./start.sh
```

If the `port 22` is available at the host machine, users can log in via SSH after the building is complete. For example:
From the host machine:
```
ssh user1@localhost
```
From another machine
```
ssh user1@<host ip>
```




