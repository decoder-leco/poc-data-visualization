#!/bin/bash

# -------
# >>> https://docs.posit.co/ide/server-pro/user/2023.03.1/jupyter-lab/guide/jupyter-kernel-management.html#user-created-kernels
# --- this would be to add a kernel to jupyter lab, baed on a python venv, see https://pypi.org/project/ipykernel/
# -
# 
# Instead of running [pip install ipykernel], we install it with a requirements.txt
# python -m pip install ipykernel
# cat <<EOF >./requirements.kernels.mgmt.txt
# ipykernel
# EOF
# python -m pip install -r requirements.kernels.mgmt.txt


# -------
# >>> https://datatofish.com/r-jupyter-notebook/
# --- 

# ----
# Install CONDA
# > https://conda.io/projects/conda/en/latest/user-guide/install/linux.html#install-linux-silent
# > https://docs.anaconda.com/free/miniconda/
# 
# > 
# 
export CONDA_INSTALLER_DWNLD_LINK="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"
export CONDA_INSTALLER_FILENAME=$(echo "${CONDA_INSTALLER_DWNLD_LINK}" | awk -F '/' '{ print $NF }')
echo "  CONDA_INSTALLER_DWNLD_LINK=[${CONDA_INSTALLER_DWNLD_LINK}]"
echo "  CONDA_INSTALLER_FILENAME=[${CONDA_INSTALLER_FILENAME}]"

curl -LO ${CONDA_INSTALLER_DWNLD_LINK}
export CONDA_INSTALLER_CHECKSUM_SHA256="b978856ec3c826eb495b60e3fffe621f670c101150ebcbdeede4f961f22dc438"
export CONDA_INSTALLER_CHECKSUM_SHA256="05f70cbc89b6caf84e22db836f7696a16b617992eb23d6102acf7651eb132365"

echo "${CONDA_INSTALLER_CHECKSUM_SHA256} ${CONDA_INSTALLER_FILENAME}" | tee -a ./conda.sha256.checksum
sha256sum -c ./conda.sha256.checksum
# https://stackoverflow.com/questions/49865531/bash-script-for-anaconda-installer-and-license-agreement
mkdir -p $HOME/anaconda3
bash ${CONDA_INSTALLER_FILENAME} -b -f -p $HOME/anaconda3
export PATH=$PATH:$HOME/anaconda3/bin
echo "After conda installation, content of [$HOME/anaconda3]"
ls -alh $HOME/anaconda3
ls -alh $HOME/anaconda3/bin
ls -alh $HOME/anaconda3/condabin

# alias conda=$HOME/anaconda3/condabin
conda --version
which conda
echo "# -----------"
echo " Content of bashrc after conda installation:"
cat ~/.bashrc
echo "# -----------"
echo "export PATH=\"\$PATH:\$HOME/anaconda3/bin\"" | tee -a ~/.bashrc
echo " Content of bashrc after conda installation + update:"
cat ~/.bashrc
echo "# -----------"
conda --version
echo "# -----------"
conda install --help
# ----
# Install the R language and its jupyter kernel
# > https://github.com/IRkernel/IRkernel : in the requirements, that the R language platform is installed
# 

# echo 'y\n' | conda install -c r r-irkernel
# echo 'y' | conda install -c r r-irkernel
conda install -y -c r -c defaults -c conda-forge r-irkernel