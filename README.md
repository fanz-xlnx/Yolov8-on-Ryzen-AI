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

[3 The Docker Tools Image](#3-the-docker-tools-image)

[4 The Main Flow on the Host](#4-the-main-flow-on-the-host)

[5 Multithreading Application Code](#5-multithreading-application-code)

[6 Run on the Target Board](#6-run-on-the-target-board)

[7 Summary](#7-summary)

[Appendix](#appendix)

[License](#license)



## 1 Introduction

[Vitis™ AI](https://www.xilinx.com/products/design-tools/vitis/vitis-ai.html) is a comprehensive AI inference development solution for AMD devices, boards, and Alveo™ data center acceleration cards. It consists of a rich set of AI models, optimized deep learning processor unit (DPU) cores, tools, libraries, and example designs for AI at the edge and in the data center. It is designed with high efficiency and ease of use in mind, unleashing the full potential of AI acceleration on AMD FPGAs and adaptive SoCs.

In this Deep Learning (DL) tutorial, you will train the [FCN8](http://deeplearning.net/tutorial/fcn_2D_segm.html) and [UNET](https://towardsdatascience.com/understanding-semantic-segmentation-with-unet-6be4f42d4b47) Convolutional Neural Networks (CNNs) for Semantic Segmentation in Keras adopting a small custom dataset, then you will quantize the floating point weights files to an 8-bit fixed point  representation to finally deploy them on the AMD FPGA target boards.

Once the selected CNN has been correctly trained in Keras, the [HDF5](https://www.hdfgroup.org/solutions/hdf5/) file of weights is converted into a TF checkpoint and inference graph file, such floating point frozen graph is then quantized by the Vitis AI Quantizer that creates an 8-bit INT8 fixed point graph from which the Vitis AI Compiler generates the ``xmodel`` file of micro instructions for the Deep Processor Unit (DPU) of the Vitis AI platform. The final application is executed at run time - via Python APIs - on the target board to make predictions that can be compared against the simulation reference results.

## 2 Prerequisites

- Ubuntu 18.04.5 host PC.

- The entire repository of [Vitis AI 3.0](https://github.com/Xilinx/Vitis-AI) stack from [www.github.com/Xilinx](https://www.github.com/Xilinx) web site.

-  Accurate reading of [Vitis AI User Guide 1414](https://docs.xilinx.com/r/en-US/ug1414-vitis-ai/Vitis-AI-Overview) (shortly UG1414).

- Accurate reading of [online Vitis AI](https://xilinx.github.io/Vitis-AI) documentation from [xilinx.github.io](https://xilinx.github.io) web site. In particular, pay attention to the installation and setup instructions for both host and target, it is recommended you build a GPU-based docker image with TensorFlow 1.15.

- A Vitis AI target board such as either:
    - [ZCU102](https://www.xilinx.com/products/boards-and-kits/ek-u1-zcu102-g.html), or
    - [ZCU104](https://www.xilinx.com/products/boards-and-kits/ek-u1-zcu104-g.html), or
    - [VCK190](https://www.xilinx.com/products/boards-and-kits/vck190.html), or
    - the newest Versal Edge **VEK280** board, still in an Early Access phase.

- Familiarity with Deep Learning principles.
