# ollama-webui-docker-cuda
Run Ollama and WebUI with Nvidia (CUDA) support locally in docker.
ChatGPT like experience, free forever, uncensored and private.

![Open WebUI Demo](https://raw.githubusercontent.com/open-webui/open-webui/main/demo.gif)

## Prerequisites

- Linux (tested on Ubuntu)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Make](https://askubuntu.com/questions/161104/how-do-i-install-make)
- [Curl](https://gcore.com/learning/how-to-install-curl-on-ubuntu/)
- Docker ([Part-1](https://docs.docker.com/engine/install/ubuntu/) & [Part-2](https://docs.docker.com/engine/install/linux-postinstall/))
- Nvidia GPU (see notes below regarding compatability / VRAM requirements)

## Installation

### Step 1: Install & Configure Nvidia Toolkit for Docker 

_Run each commands one by one, in the order listed below._

```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update

sudo apt-get install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker

sudo systemctl restart docker
```

### Step 2: Clone the Repository & Start the Docker Containers

_For simplicity, the example below shows cloning the repository to Desktop, you can clone it anywhere you like._

```
cd $HOME/Desktop

git clone git@github.com:latheesan-k/ollama-webgui-docker-cuda.git

cd ollama-webgui-docker-cuda

make up
```

### Step 3: Run Ollama WebUI

> Visit [http://localhost:8000](http://localhost:8000) and enjoy

Go to [https://ollama.com/library/](https://ollama.com/library/) to find models to run locally.
Then on the local ollama webui, click on the `Avatar` (on the top right) -> `Admin Panel` -> `Settings` -> `Models` and click the download icon (Manage Models) and enter the name of the model (e.g. `deepseek-r1:32b`) into **Pull a model from Ollama.com** section. 

Once the model is downloaded, you can click on `New Chat` and select the downloaded model from the dropdown and that's it, you are now ready to have ChatGPT like experience locally.

To learn more, please visit the official project https://github.com/open-webui/open-webui or search for tutorials on YouTube.

## Compatability / VRAM requirements

Most of the Nvidia RTX GPU are supported. The main factor that determines which models you can run is the available VRAM on your GPU.

For example, RTX 4090 has 24 GB VRAM, which means you will be able to run a powerful reasoning model such as `32b` [deepseek-r1](https://ollama.com/library/deepseek-r1:32b) (on par with ChatGPT o1).

This is possible because the 32 billion parameter model is quantized to Q4_K_M format (aka compression, small loss in quality to reduce the VRAM requirement), which results in model size being approximately `20gb`, which is roughly the same amount of VRAM you will need to fully offload the model weights into the GPU.

If you can fully offload the model weight into the GPU, the model will be performant using only the GPU. If you don't have enough VRAM, Ollama will use both the GPU VRAM and the system RAM through the CPU to run the model anyway, but it will be slow.

## Available Make Commands

_To run the make commands, simple type `make command-name` (e.g. `make up`)_

* `up` Starts the docker containers
* `down` Shuts down the docker containers
* `status` View the status of all running containers
* `stats` View the resource usage of all running containers
* `logs` View the logs out of all running containers