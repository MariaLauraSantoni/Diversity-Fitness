#!/bin/bash

#SBATCH --job-name=d5
#SBATCH --array=0-##jobs_count##
#SBATCH --clusters=inter
#SBATCH --partition=cm4_inter_large_mem
#SBATCH --time=96:00:00
#SBATCH --mail-user=your_email@domain.com
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=script.out
#SBATCH --err=script.err

export GUROBI_HOME=/dss/dsshome1/lxc0D/ge89yen2/Gurobi/gurobi1003/linux64
export PATH=$PATH:$GUROBI_HOME/bin
export GRB_LICENSE_FILE=/lrz/sys/applications/gurobi/gurobi.lic
python main_Gurobi.py
