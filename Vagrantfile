# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Para una referencia completa de las opciones, ver https://docs.vagrantup.com.

  config.vm.provider "virtualbox" do |v|
    # MODIFICADO: Aumentamos la RAM de 2GB a 8GB.
    # Compilar con muchos hilos puede consumir bastante memoria.
    v.memory = 16192

    # MODIFICADO: Asignamos 16 CPUs virtuales a la máquina.
    # Esto permitirá hasta 16 procesos de compilación en paralelo.
    # Dejamos la mitad de tus hilos libres para que tu máquina anfitriona no se sature.
    v.cpus = 32
    config.vm.network "forwarded_port", guest: 8888, host: 8888
  end

  # Se usará la imagen de Ubuntu 22.04 LTS.
  config.vm.box = "ubuntu/jammy64"

  # La siguiente sección es para configurar solucionadores de LP como CPLEX.
  # Se mantiene la lógica original por si la necesitas en el futuro.
  provision_env = {}
  if !ENV["DOWNWARD_LP_INSTALLERS"].nil?
      cplex_installer = ENV["DOWNWARD_LP_INSTALLERS"] + "/cplex_studio2211.linux_x86_64.bin"
      if File.file?(cplex_installer)
          config.vm.synced_folder ENV["DOWNWARD_LP_INSTALLERS"], "/lp", :mount_options => ["ro"]
          provision_env["CPLEX_INSTALLER"] = "/lp/" + File.basename(cplex_installer)
      end
  end

  # Aprovisionamiento: aquí se instala todo y se compila el planificador.
  config.vm.provision "shell", env: provision_env, inline: <<-SHELL

    echo ">>> Actualizando e instalando dependencias base..."
    apt-get update && apt-get install --no-install-recommends -y \
        ca-certificates \
        cmake           \
        default-jre     \
        g++             \
        git             \
        libgmp3-dev     \
        make            \
        python3         \
        unzip           \
        zlib1g-dev

    if [ -f "$CPLEX_INSTALLER" ]; then
        echo ">>> Instalando CPLEX..."
        cat > /etc/profile.d/downward-cplex.sh <<-EOM
export cplex_DIR="/opt/ibm/ILOG/CPLEX_Studio2211/cplex"
EOM
        source /etc/profile.d/downward-cplex.sh
        $CPLEX_INSTALLER -DLICENSE_ACCEPTED=TRUE -i silent
    fi

    echo ">>> Compilando e instalando SoPlex..."
    cat > /etc/profile.d/downward-soplex.sh <<-EOM
export soplex_DIR="/opt/soplex"
EOM
    source /etc/profile.d/downward-soplex.sh
    git clone --depth 1 --branch release-710 https://github.com/scipopt/soplex.git soplex
    cd soplex
    cmake -DCMAKE_INSTALL_PREFIX="$soplex_DIR" -S . -B build
    cmake --build build
    cmake --install build

    cd /home/vagrant

    if ! [ -e downward ] ; then
        echo ">>> Clonando el repositorio de Fast Downward..."
        git clone --branch release-24.06.1 https://github.com/aibasel/downward.git downward
        
        echo ">>> Compilando Fast Downward con 16 hilos..."
        # MODIFICADO: Añadimos el flag "-j16" al script de compilación.
        # Esto le indica al script que use 16 hilos, acelerando drásticamente el proceso.
        ./downward/build.py -j16 release debug
        
        chown -R vagrant.vagrant downward
    fi

    echo ">>> ¡Entorno listo!"
  SHELL
end
