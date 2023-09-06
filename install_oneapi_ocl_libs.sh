#!/bin/bash
set -e

dnf install wget -y

mkdir -p /opt/intel/oclfpgaemu_2022.15.12.0.01
cd /opt/intel/oclfpgaemu_2022.15.12.0.01
wget https://github.com/intel/llvm/releases/download/2022-WW50/fpgaemu-2022.15.12.0.01_rel.tar.gz
mv fpgaemu-2022.15.12.0.01_rel.tar.gz fpgaemu-2022.15.12.0.01.tar.gz
tar -zxvf fpgaemu-2022.15.12.0.01.tar.gz
rm fpgaemu-2022.15.12.0.01.tar.gz

mkdir -p /opt/intel/oclcpuexp_2022.15.12.0.01
cd /opt/intel/oclcpuexp_2022.15.12.0.01
wget https://github.com/intel/llvm/releases/download/2022-WW50/oclcpuexp-2022.15.12.0.01_rel.tar.gz
mv oclcpuexp-2022.15.12.0.01_rel.tar.gz oclcpuexp-2022.15.12.0.01.tar.gz
tar -zxvf oclcpuexp-2022.15.12.0.01.tar.gz
rm oclcpuexp-2022.15.12.0.01.tar.gz

cpufpga_ver=2022.15.12.0.01

mkdir -p /etc/OpenCL/vendors/
# OpenCL FPGA emulation RT
echo  /opt/intel/oclfpgaemu_$cpufpga_ver/x64/libintelocl_emu.so > /etc/OpenCL/vendors/intel_fpgaemu.icd
# OpenCL CPU RT
echo /opt/intel/oclcpuexp_$cpufpga_ver/x64/libintelocl.so > /etc/OpenCL/vendors/intel_expcpu.icd

mkdir -p /opt/intel/
cd /opt/intel/
wget https://github.com/oneapi-src/oneTBB/releases/download/v2021.7.0/oneapi-tbb-2021.7.0-lin.tgz
tar -zxvf oneapi-tbb-2021.7.0-lin.tgz
rm oneapi-tbb-2021.7.0-lin.tgz

# OpenCL FPGA emulation RT
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbb.so /opt/intel/oclfpgaemu_$cpufpga_ver/x64
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbbmalloc.so /opt/intel/oclfpgaemu_$cpufpga_ver/x64
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbb.so.12 /opt/intel/oclfpgaemu_$cpufpga_ver/x64
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbbmalloc.so.2 /opt/intel/oclfpgaemu_$cpufpga_ver/x64
# OpenCL CPU RT
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbb.so /opt/intel/oclcpuexp_$cpufpga_ver/x64
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbbmalloc.so /opt/intel/oclcpuexp_$cpufpga_ver/x64
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbb.so.12 /opt/intel/oclcpuexp_$cpufpga_ver/x64
ln -s /opt/intel/oneapi-tbb-2021.7.0/lib/intel64/gcc4.8/libtbbmalloc.so.2 /opt/intel/oclcpuexp_$cpufpga_ver/x64


echo /opt/intel/oclfpgaemu_$cpufpga_ver/x64 > /etc/ld.so.conf.d/libintelopenclexp.conf
echo /opt/intel/oclcpuexp_$cpufpga_ver/x64 >> /etc/ld.so.conf.d/libintelopenclexp.conf
ldconfig -f /etc/ld.so.conf.d/libintelopenclexp.conf
