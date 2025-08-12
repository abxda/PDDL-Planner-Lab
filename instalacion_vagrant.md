# 🐍 Tutorial: Configuración del Entorno Python en Vagrant

**Objetivo:** Instalar Jupyter Lab y todas las librerías de Python necesarias para ejecutar los cuadernos de planificación dentro de la máquina virtual de Vagrant ya aprovisionada.

**Punto de Partida:** Has ejecutado `vagrant up` y el script de aprovisionamiento ya ha compilado el planificador Fast Downward en `/home/vagrant/downward/`.

--- 

### Paso 1: Conectarse a la Máquina Virtual

Este es el primer y más fundamental paso. Desde tu terminal, en el directorio donde se encuentra tu `Vagrantfile`, ejecuta:

```bash
vagrant ssh
```

Al ejecutar este comando, tu terminal cambiará y ahora estarás operando **dentro** de la máquina virtual de Ubuntu.

### Paso 2: Actualizar el Sistema e Instalar Dependencias Clave

Aunque el aprovisionamiento hizo el trabajo pesado, es una buena práctica asegurarse de que todo esté actualizado e instalar las herramientas que necesitamos: `pip` (el gestor de paquetes de Python) y `graphviz` (el motor para visualizar grafos).

```bash
# Actualiza la lista de paquetes de Ubuntu
sudo apt-get update

# Instala pip para Python 3 y el motor de Graphviz
sudo apt-get install -y python3-pip graphviz
```

### Paso 3: Instalar las Librerías de Python

Ahora usaremos `pip` para instalar todas las librerías de Python que nuestro cuaderno necesita. Usaremos el flag `--user` que es una buena práctica porque instala los paquetes en el directorio personal del usuario (`/home/vagrant/.local/`), sin tocar los paquetes del sistema.

```bash
pip3 install --user jupyterlab matplotlib numpy graphviz ipywidgets
```



### Paso 4: Iniciar Jupyter Lab

¡Ya está todo listo! Ahora, desde dentro de la máquina virtual, puedes iniciar el servidor de Jupyter Lab. Es importante que lo inicies desde el directorio sincronizado `/vagrant` para que puedas ver y editar los archivos de tu proyecto.

```bash
# Navega al directorio del proyecto
cd /vagrant

# Inicia Jupyter Lab
/home/vagrant/.local/bin/jupyter lab --ip=0.0.0.0 -
```

* `--ip=0.0.0.0`: Permite que Jupyter acepte conexiones desde fuera de la VM.

### Paso 5: Acceder desde tu Navegador Local

Al ejecutar el comando anterior, la terminal de la VM te mostrará un mensaje con varias URLs. Busca una que se parezca a esto:

`http://127.0.0.1:8888/lab?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

1. Abre el navegador web en **tu máquina principal** (anfitriona).
2. Pega la URL anterior directamente en la barra de direcciones.

¡Listo! Ahora tienes un entorno de planificación y análisis completamente funcional, con el planificador ejecutándose nativamente en la VM y la interfaz de Jupyter accesible cómodamente desde tu navegador.
