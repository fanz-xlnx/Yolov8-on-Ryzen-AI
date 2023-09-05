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

[4 Run Yolov8 Demo](#4-run-yolov8-demo)

[5 Summary](#5-summary)

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
- openCV (version = 4.6.0)
- glog
- gflags
- cmake (version >= 3.26)
- python (version >= 3.9) (Recommended for python 3.9.13 64bit)
- IPU driver & IPU xclbin release >= 20230726
- voe package >= (jenkins-nightly-build-id==205)

## 3 Installation

### Visual Studio 2019

The [Visual Studio](https://my.visualstudio.com/Downloads?q=visual%20studio%202019&wt.mc_id=o~msft~vscom~older-downloads) is required to compile the related source code.

:exclamation: The Yolov8 demo in this tutorial may not be compatible with other Visual Studio version.

### IPU Driver

Please download the Adrenalin IPU driver from the Link below and install it on your laptop.

[Adrenalin IPU Driver](https://amdcloud-my.sharepoint.com/:u:/g/personal/anluo_amd_com/EaZ7iksQO2xKs7efI-zZ8BgBZo0wwEyQo91v8xa3br3wNw?e=gA2jTF)

Ensure that the IPU driver is installed from `Device Manager` -> `System Devices` -> `AMD IPU Device` as shown in the following image. The version is expected to be 10.106.6.52

<p align="left">
<img src="images/image1.png">
</p>

### Denpendencies

The Ryzen AI Software Platform requires using a [Conda](https://docs.anaconda.com/free/anaconda/install/windows/) environment for the installation process.

Start a `Conda Prompt`. In the Conda Prompt, create and activate an environment for the rest of the installation process. We will use ***ryzen_test*** here as an example.

```Conda Prompt
conda create --name ryzen_test python=3.9
conda activate ryzen_test
```

#### ONNX Runtime

```Conda Prompt
pip install onnxruntime
```

#### Cmake

```Conda Prompt
pip install cmake
```

#### Vitis AI ONNX Runtime Execution Provider

Download the Execution Provider setup package with the link below:

[Vitis AI ONNX Runtime EP](https://account.amd.com/en/forms/downloads/ryzen-ai-software-platform-xef.html?filename=voe-3.5-win_amd64.zip)

Change the directory to the extracted Execution Provider setup package directory and install the necessary packages:

```Conda Prompt
cd voe-3.5-win_amd64\voe-3.5-win_amd64
python installer.py
pip install voe-0.1.0-cp39-cp39-win_amd64.whl
pip install onnxruntime_vitisai-1.15.1-cp39-cp39-win_amd64.whl
```
#### OpenCV

It is recommended to build OpenCV form source code and use static build. [Git](https://git-scm.com/download/win) is required to clone the repository.

Start a `Git Bash`. In the Git Bash, clone the repository

```Git Bash
git clone https://github.com/opencv/opencv.git -b 4.6.0
```

Switch back to the `Conda Prompt`, and compile the OpenCV source code with cmake.

```Conda Prompt
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_CONFIGURATION_TYPES=Release -A x64 -T host=x64 -G "Visual Studio 16 2019" '-DCMAKE_INSTALL_PREFIX=C:\Program Files\opencv' '-DCMAKE_PREFIX_PATH=.\opencv' -DCMAKE_BUILD_TYPE=Release -DBUILD_opencv_python2=OFF -DBUILD_opencv_python3=OFF -DBUILD_WITH_STATIC_CRT=OFF -B build -S opencv
cmake --build build --config Release
cmake --install build --config Release
```

#### gflags

In the Git Bash, clone the repository

```Git Bash
git clone https://github.com/gflags/gflags.git
```

Switch back to the `Conda Prompt`, and compile the gflags source code with cmake.

```Conda Prompt
cd gflags
mkdir mybuild
cd mybuild
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_CONFIGURATION_TYPES=Release -A x64 -T host=x64 -G "Visual Studio 16 2019" '-DCMAKE_INSTALL_PREFIX=C:\Program Files\gflag'  -B build -S ../
cmake --build build --config Release
cmake --install build --config Release
cd ../..
```

#### glog

In the Git Bash, clone the repository

```Git Bash
git clone https://github.com/google/glog.git
```

Switch back to the `Conda Prompt`, and compile the glog source code with cmake.

```Conda Prompt
cd glog
mkdir mybuild
cd mybuild
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_CONFIGURATION_TYPES=Release -A x64 -T host=x64 -G "Visual Studio 16 2019" '-DCMAKE_INSTALL_PREFIX=C:\Program Files\glog'  -B build -S ../
cmake --build build --config Release
cmake --install build --config Release
cd ../..
```

## 4 Run Yolov8 Demo

### Compilation

move `YOLOv8_RyzenAI_demo` folder to `VOE` folder(same level as **vitis_ai_ep_cxx_sample**)

```Conda Prompt
build.bat
```

The output will be generated as below.

```
......
    -- Installing: C:/Users/ibane/Desktop/voe-win_amd64-with_xcompiler_on-c07e419-latest/bin/camera_yolov8.exe
    -- Installing: C:/Users/ibane/Desktop/voe-win_amd64-with_xcompiler_on-c07e419-latest/bin/camera_yolov8_nx1x4.exe
    -- Installing: C:/Users/ibane/Desktop/voe-win_amd64-with_xcompiler_on-c07e419-latest/bin/test_jpeg_yolov8.exe
```

### Run with Image

```
run_jpeg.bat DetectionModel_int.onnx sample_yolov5.jpg
```

The output will be generated as below.

```
result: 0       person  490.38498       85.79535        640.00488       475.18262       0.932453     
result: 0       person  65.96048        97.76373        320.66068       473.83783       0.924142   
result: 0       person  182.15485       306.91266       445.14795       475.26132       0.893309   
result: 27      tie     584.48022       221.15732       632.27008       244.21243       0.851953   
result: 27      tie     175.62622       224.15210       235.84900       248.83557       0.651355    
```

### Run with Live Camera

```
camera_nx.bat
```
