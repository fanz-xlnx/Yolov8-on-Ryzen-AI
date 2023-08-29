<table class="sphinxhide" width="100%">
 <tr width="100%">
    <td align="center"><img src="https://raw.githubusercontent.com/Xilinx/Image-Collateral/main/xilinx-logo.png" width="30%"/><h1>Vitis™ AI Tutorials</h1>
    </td>
 </tr>
</table>

#  Yolov8 on Ryzen AI Software Platform


- Version:      Ryzen AI Software Platform v0.7 
- Support:      AMD Ryzen 7040U, 7040HS series mobile processors with Windows 11 OS.
- Last update:  24 Aug. 2023


## Table of Contents

[1 Introduction](#1-introduction)

[2 Prerequisites](#2-prerequisites)

[3 Installation](#3-installation)

[4 The Main Flow on the Host](#4-the-main-flow-on-the-host)

[5 Multithreading Application Code](#5-multithreading-application-code)

[6 Run on the Target Board](#6-run-on-the-target-board)

[7 Summary](#7-summary)

[Appendix](#appendix)

[License](#license)



## 1 Introduction

[Ryzen™ AI](https://ryzenai.docs.amd.com/en/latest/index.html) is a dedicated AI accelerator integrated on-chip with the CPU cores. The AMD Ryzen™ AI SDK enables developers to take machine learning models trained in PyTorch or TensorFlow and run them on laptops powered by Ryzen AI which can intelligently optimizes tasks and workloads, freeing-up CPU and GPU resources, and ensuring optimal performance at lower power.

In this Deep Learning(DL) tutorial, you will see how to deploy the Yolov8 detection model with ONNX framework on Ryzen AI laptop.

## 2 Prerequisites

- AMD Ryzen AI Laptop with Windows 11 OS.
- Visual Studio 2019 (with Desktop dev c++ & MSVC v142-vs2019 x64/x86 Spectre-mitigated libs)
- Anaconda or Miniconda
- Git
- cmake (version >= 3.26)
- python (version >= 3.9) (Recommended for python 3.9.13 64bit)
- IPU driver & IPU xclbin release >= 20230726
- voe package >= (jenkins-nightly-build-id==205)

## 3 Installation

### IPU Driver

Please download the Adrenalin IPU driver from the Link below and install it on your laptop.

[Adrenalin IPU Driver](https://amdcloud-my.sharepoint.com/:u:/g/personal/anluo_amd_com/EaZ7iksQO2xKs7efI-zZ8BgBZo0wwEyQo91v8xa3br3wNw?e=gA2jTF)

Ensure that the IPU driver is installed from `Device Manager` -> `System Devices` -> `AMD IPU Device` as shown in the following image. The version is expected to be 10.106.6.52

<p align="left">
<img src="images/image1.png">
</p>

### Denpendencies

The Ryzen AI Software Platform requires using a [Conda](https://docs.anaconda.com/free/anaconda/install/windows/) environment for the installation process.

Start a conda prompt. In the conda prompt, create and activate an environment for the rest of the installation process. We will use ***ryzen_test*** here as an example.

```Bash
conda create --name ryzen_test python=3.9
conda activate ryzen_test
```

#### ONNX Runtime

```Bash
pip install onnxruntime
```

#### Cmake

```Bash
pip install cmake
```

#### Vitis AI ONNX Runtime Execution Provider

Download the Execution Provider setup package with the link below:

[Vitis AI ONNX Runtime EP](https://account.amd.com/en/forms/downloads/ryzen-ai-software-platform-xef.html?filename=voe-3.5-win_amd64.zip)

Change the directory to the extracted Execution Provider setup package directory and install the necessary packages:

```Bash
cd voe-3.5-win_amd64\voe-3.5-win_amd64
python installer.py
pip install voe-0.1.0-cp39-cp39-win_amd64.whl
pip install onnxruntime_vitisai-1.15.1-cp39-cp39-win_amd64.whl
```
